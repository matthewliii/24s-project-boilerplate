########################################################
# Sample playlist blueprint of endpoints
# Remove this file if you are not using it in your project
########################################################
from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


playlist = Blueprint('playlist', __name__)

# Get all playlists created by a user with a specific userID
@playlist.route('/playlist/<userID>', methods=['GET'])
def get_playlists_by_user(userID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from playlist p join playlistOwnership po on p.PlaylistID = po.PlaylistID where UserID = ' + userID)
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get a playlist with a specific playlistID and songs in it
@playlist.route('/playlist/<playlistID>', methods=['GET'])
def get_playlist(playlistID):
    cursor = db.get_db().cursor()
    cursor.execute(f'''
select p.PlaylistID, Name, Description, CreationDate, OrderNum, mf.MusicFileID,
Title, Artist, Genre, `Key`, Tempo, ReleaseStatus, UserID
from playlist p join playlistSong pS on p.PlaylistID = pS.PlaylistID
join musicFile mf on pS.MusicFileID = mf.MusicFileID where p.PlaylistID = {str(playlistID)}
                   ''')
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