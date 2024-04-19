########################################################
# Sample musicFile blueprint of endpoints
# Remove this file if you are not using it in your project
########################################################
from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


musicFile = Blueprint('musicFile', __name__)

# Return a song with MusicFileID
@musicFile.route('/musicFile/<musicFileID>', methods=['GET'])
def get_musicFile(musicFileID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from musicFile where musicFileID = {0}'.format(musicFileID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        row = (dict(zip(row_headers, row)))
        for key, value in row.items():
            if isinstance(value, bytes):
                row[key] = value.decode('utf-8')
        json_data.append(row)

    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get all music files uploaded by a user with a specific musicFileID from the DB
@musicFile.route('/musicFile/<userID>/<MusicFileID>', methods=['GET'])
def get_musicFile_of_UserID(userID, MusicFileID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from musicFile where UserID = ' + userID + ' and MusicFileID = ' + MusicFileID)
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Create a new musicFile corresponding with a new music file ID and corresponding with a userID
@musicFile.route('/musicFile/<userID>/<MusicFileID>', methods=['PUT'])
def create_musicFile(userID, MusicFileID):
# collecting data from the request object
    data = request.get_json()
    cursor = db.get_db().cursor()

    query = "INSERT INTO musicFile (MusicFileID, Title, Artist, Genre, `Key`, Tempo, ReleaseStatus, UserID) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)"
    cursor.execute(query, (MusicFileID, data['Title'], data['Artist'], data['Genre'], data['`Key`'], data['Tempo'], data['ReleaseStatus'], userID))
    db.get_db().commit()
    return make_response(jsonify({"message": "MusicFile created!"}))

# Get all music files uploaded by a user from the DB
@musicFile.route('/musicFiles/<userID>', methods=['GET'])
def get_musicFiles(userID):
    cursor = db.get_db().cursor()
    cursor.execute('select Title, Artist, Genre, `Key`, Tempo from musicFile where UserID = ' + str(userID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get all music files uploaded by a user and a filter key from the DB
@musicFile.route('/musicFileKey/<userID>/<Key>', methods=['GET'])
def get_musicFiles_User_Key(userID, Key):
    cursor = db.get_db().cursor()
    cursor.execute('select * from musicFile where UserID = ' + userID + ' and `Key` = ' + Key)
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get all music files with a filter key from the DB
@musicFile.route('/musicFileKey/<Key>', methods=['GET'])
def get_musicFiles_Key(Key):
    cursor = db.get_db().cursor()
    cursor.execute('select * from musicFile where `Key` = ' + Key)
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get all music files from the DB
@musicFile.route('/all_musicFiles', methods=['GET'])
def get_all_musicFiles():
    cursor = db.get_db().cursor()
    cursor.execute('select Title, Artist, Genre, `Key`, Tempo from musicFile')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response


# Update generic info of music file uploaded by a specific user
@musicFile.route('/musicFile/<userID>/<MusicFileID>', methods=['PUT'])
def update_musicFile_info():
    
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    id = the_data['MusicFileId']
    title = the_data['Title']
    artist = the_data['Artist']
    genre = the_data['Genre']
    key = the_data['Key']
    tempo = the_data['Tempo']
    release_status = the_data['ReleaseStatus']
    

    # Constructing the query
    query = 'update musicFile set title = "'
    query += title  + '", artist = "'
    query += artist + '", genre = "'
    query += genre + '", key = "' 
    query += key + '", tempo = "'
    query += tempo + '", releasestatus = "'
    query += release_status + '" where id = "' + str(id) + '";'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'

# deletes music file uploaded by userID
@musicFile.route('/musicFile/<userID>/<MusicFileID>', methods=['DELETE'])
def delete_musicFile(userID, MusicFileID):
    query = 'DELETE FROM musicFile WHERE userID = ' + str(userID) + ' AND musicFileID = ' + str(MusicFileID)

    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return 'Music File {} deleted successfully!'.format(MusicFileID)

# Adds music file uploaded by userID
# (Title, Artist, Genre, `Key`, Tempo, ReleaseStatus, UserID)
@musicFile.route('/musicFile/<Title>/<Artist>/<Genre>/<Key>/<Tempo>/<Release>/<userID>', methods=['PUT'])
def add_musicFile(Title, Artist, Genre, Key, Tempo, Release, userID):
    query = 'insert into musicFile (Title, Artist, Genre, `Key`, Tempo, ReleaseStatus, UserID)\
        values (' + Title + ', ' + Artist + ', ' + Genre + ', ' + str(Key) + ', ' + str(Tempo) + ', ' + str(Release) + ', ' + str(userID) + ')'

    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return 'Music File {} added successfully!'.format(userID)

# Get music files sorted by column
@musicFile.route('/musicFileFilterBy/<input>', methods=['GET'])
def get_musicFiles_Columm(input):
    cursor = db.get_db().cursor()
    cursor.execute('select Title, Artist, Genre, `Key`, Tempo from musicFile ORDER BY ' + input)
    #cursor.execute('select Title, Artist, Genre, `Key`, Tempo from musicFile ORDER BY Tempo')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get music file by title
@musicFile.route('/musicFileByTitle', methods=['GET'])
def get_musicFileByTitle():
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    title = the_data['Title']
    cursor = db.get_db().cursor()
    cursor.execute('select Title, Artist, Genre, `Key`, Tempo from musicFile WHERE Title = ' + title)
    row_headers = [x[0] for x in cursor.description]


    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response
