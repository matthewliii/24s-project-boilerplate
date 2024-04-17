########################################################
# Sample musicFile blueprint of endpoints
# Remove this file if you are not using it in your project
########################################################
from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


musicFile = Blueprint('musicFile', __name__)

# Get all music files uploaded by a user with a specific musicFileID from the DB
@musicFile.route('/musicFile/<userID>/<MusicFileID>', methods=['GET'])
def get_musicFile(userID, MusicFileID):
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
def get_musicFilesKey(userID, Key):
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