from flask import Flask, render_template, request, redirect, session, flash
from mysqlconnection import MySQLConnector
import re, md5
app = Flask(__name__)
app.secret_key = "MySessionSecretKey1"
mysql = MySQLConnector( app, "the_wall")
email_regex = re.compile(r'^[a-zA-Z0-9.+_-]+@[a-zA-Z0-9._-]+\.[a-zA-Z]+$')

@app.route( "/" )
def lr():
    # session['user_id'] = False
    if session['user_id']:
        return redirect( "/wall" )
    return render_template( "index.html" )

# VIEW MESSAGES AND COMMENTS
@app.route( "/wall" )
def wall():
    if not session['user_id']:
        return render_template( "index.html" )

    query = "SELECT first_name, id FROM users WHERE id = :id"
    q_p = { 'id': session['user_id'] }
    user = {}
    user = mysql.query_db( query, q_p )[0]

    query = "SELECT first_name, last_name, message, DATE_FORMAT(messages.created_at, '%M %d, %Y') AS message_date, messages.id, user_id FROM messages JOIN users ON users.id = messages.user_id ORDER BY messages.created_at DESC"
    messages = mysql.query_db( query )

    query = "SELECT users.first_name, users.last_name, comments.message_id, comment, DATE_FORMAT(comments.created_at, '%M %d, %Y') AS comment_date FROM comments JOIN users ON comments.user_id = users.id ORDER BY comments.created_at ASC"
    comments = mysql.query_db( query )
    
    return render_template( "wall.html", user = user, messages = messages, comments = comments )

# POST A MESSAGE TO START A DISCUSSION
@app.route( "/post_message", methods = ['POST'] )
def post_message():
    query = "INSERT INTO messages( message, user_id, created_at, updated_at ) VALUES( :message, :user_id, NOW(), NOW() )"
    q_p = {
        'message': request.form['message'],
        'user_id': session['user_id']
    }
    mysql.query_db( query, q_p )
    flash( "Your message has been posted" )
    return redirect( "/wall" )

# POST A COMMENT IN RESPONCE TO A MESSAGE
@app.route( "/post_comment/<message_id>", methods = ['POST'])
def post_comment( message_id ):
    query = "INSERT INTO comments( comment, user_id, message_id, created_at, updated_at ) VALUES( :comment, :user_id,:message_id, NOW(), NOW() )"
    q_p = {
        'comment': request.form['comment'],
        'user_id': session['user_id'],
        'message_id': message_id
    }
    mysql.query_db( query, q_p )
    
    return redirect( "/wall" )

# DELETE MESSAGE
@app.route( "/delete_message" )
def delete_message():
    flash ("delete command received!")
    return redirect( "/wall" )

# LOGIN
@app.route( "/authorization", methods = ["POST"] )
def authorization():
    # EMAIL VALIDATION
    if not email_regex.match( request.form['email'] ):
        flash( "Invalid email" )
    else:        
        query = "SELECT * FROM users WHERE users.email = :email LIMIT 1"
        q_p = { 'email': request.form['email'] }
        user = mysql.query_db( query, q_p )
        if not user:
            flash( "Email " + request.form['email'] + " is not registered with any user" )
        else:
            pw_h = md5.new( request.form['pw'] ).hexdigest()
            if user[0]['password'] != pw_h: # PASSWORD VALIDATION
                flash( "Wrong password" )
            else:  # SUCCESSFUL LOGIN
                session['user_id']= user[0]['id']
                return redirect( "/wall" )

    return redirect( "/" )

# SIGN UP
@app.route( "/signup", methods = ["POST"] )
def signup():
    error = False

    # FORM INPUT VALIDATIONS
    # VALIDATE FIRST NAME
    if len( request.form['first_name'] ) < 2: # NAME LENGTH
        error = True
        flash( "First name is too short" )
    elif not str.isalpha( str( request.form['first_name'] ) ): # NAME CONVENTIONS
        error = True
        flash( "Invalid characters in the first name" )
    
    # VALIDATE LAST NAME
    if len( request.form['last_name'] ) < 2: # NAME LENGTH
        error = True
        flash( "Last name is too short" )
    elif not str.isalpha( str( request.form['last_name'] ) ): # NAME CONVENTIONS
        error = True
        flash( "Invalid characters in the last name" )
    
    # VALIDATE EMAIL
    if not email_regex.match( request.form['email'] ): # EMAIL CONVENTIONS
        error = True
        flash( "Invalid email" )
    else: # CHECK IF EMAIL IS ALREADY IN USE
        # email = request.form['email']
        query = "SELECT email FROM users WHERE users.email = :email LIMIT 1"
        q_p = { 'email': request.form['email'] }
        existing_email = mysql.query_db( query, q_p )
        if existing_email:
            error = True
            flash( "Email " + request.form['email'] + " is already in use" )

    # VALIDATE PASSWORD CONVENTIONS AND REPEAT
    if len( str( request.form['pw'] ) ) < 8:
        error = True
        flash( "Password should be at least 8 characters long")
    elif request.form['pw'] != request.form['rpt_pw']:
        error = True
        flash( "Repeat password does not match")

    if error:
        return redirect( "/" )

    else: # ADD NEW USER INTO THE DATABASE
        query = "INSERT INTO users( first_name, last_name, email, password, created_at, updated_at ) VALUES( :first_name, :last_name, :email, :pw_h, NOW(), NOW() )"
        q_p = {
            'first_name': request.form['first_name'],
            'last_name': request.form['last_name'],
            'email': request.form['email'],
            'pw_h': md5.new( request.form['pw'] ).hexdigest()
        }
        mysql.query_db( query, q_p )

        flash( "Your user account has been saved" )
        
        # FETCH THE NEW USER ID FROM THE DATABASE FOR SESSION LOGIN
        query = "SELECT id FROM users WHERE email = :email LIMIT 1"
        q_p = { 'email': request.form['email'] }
        session['user_id']= mysql.query_db( query, q_p )[0]['id']
        
    return redirect( "/wall" )

@app.route( "/logout", methods = ["POST"])
def logout():
    session['user_id'] = False
    return redirect( "/" )

app.run( debug = True )