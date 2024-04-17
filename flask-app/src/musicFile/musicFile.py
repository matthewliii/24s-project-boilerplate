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
@musicFile.route('/musicFile/<userID>/<MusicFileID>', methods=['POST'])
def create_musicFile(userID, MusicFileID):
# collecting data from the request object
    data = request.get_json()
    cursor = db.get_db().cursor()

    query = "INSERT INTO musicFile (MusicFileID, Title, Artist, Genre, `Key`, Tempo, ReleaseStatus, UserID) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)"
    cursor.execute(query, (MusicFileID, data['Title'], data['Artist'], data['Genre'], data['`Key`'], data['Tempo'], data['ReleaseStatus'], userID))
    db.get_db().commit()
    return make_response(jsonify({"message": "MusicFile created!"}))

# Get all music files uploaded by a user from the DB
@musicFile.route('/musicFile/<userID>', methods=['GET'])
def get_musicFiles(userID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from musicFile where UserID = ' + userID)
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

    