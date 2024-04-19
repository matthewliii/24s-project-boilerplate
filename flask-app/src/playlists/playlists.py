########################################################
# Sample playlist blueprint of endpoints
# Remove this file if you are not using it in your project
########################################################
from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


playlist = Blueprint('playlist', __name__)

################ /playlist endpoint ################
# Create a new playlist of PlaylistID
@playlist.route('/playlist', methods=['POST'])
def create_playlist():
# collecting data from the request object
    data = request.get_json()
    cursor = db.get_db().cursor()

    query = "INSERT INTO playlist (PlaylistID, Name, Description, CreationDate) VALUES (%s, %s, %s, %s, %s)"
    cursor.execute(query, (data['PlaylistID'], data['Name'], data['Description'], data['CreationDate']))
    db.get_db().commit()
    return make_response(jsonify({"message": "Playlist created!"}))

################ /playlist/{playlistID} endpoint ################
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

#update generic playlist info of PlaylistID
@playlist.route('/playlist/<playlistID>', methods=['PUT'])
def update_playlist(playlistID):
    cursor = db.get_db().cursor()
    the_data = request.json

    name = the_data.get('name')
    description = the_data.get('description')

    query = 'UPDATE Playlist INFO'
    updates = []
    if name is not None:
        updates.append('name = "{}"'.format(name))
    if description is not None:
        updates.append('description = "{}"'.format(description))
    query += ', '.join(updates)
    query += ' WHERE playlistID = "{}"'.format(playlistID)

    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return 'playlist {} updated successfully!'.format(playlistID)

#deleted generic playlist of PlaylistID
@playlist.route('/playlist/<playlistID>', methods=['DELETE'])
def delete_playlist(playlistID):
    query = 'DELETE FROM playlist WHERE playlistID = "{}"'.format(playlistID)

    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return 'Playlist {} deleted successfully!'.format(playlistID)

################ /playlist/{userID} endpoint ################
# Get all playlists created by a user with a specific userID
@playlist.route('/playlistUser/<userID>', methods=['GET'])
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

################ /playlist/{chartID} endpoint ################
# Get the playlist associated with trending charts of ChartID
@playlist.route('/playlistChart/<chartID>', methods=['GET'])
def playlist_chart(chartID):
    try:
        cursor = db.get_db().cursor()
        cursor.execute('''
            SELECT c.chartID, c.name, c.description
            FROM Chart c
            JOIN playlistCharts AS pc ON c.chartID = pc.chartID
            WHERE pc.chartID = %s
        ''', (chartID,))
        charts = cursor.fetchall()

        if not charts:
            return 'No chart found for this playlist.', 404

        charts_data = [{'chartID': chart[0], 'name': chart[1], 'description': chart[2]} for chart in charts]

        return jsonify(charts_data), 200
    except Exception as e:
        current_app.logger.error(str(e))
        return jsonify({'error': 'Failed to retrieve playlist for chart.'}), 500

################ /playlist/{sessionID} endpoint ################
# Get the session of SessionID
@playlist.route('/playlistSession/<SessionID>', methods=['GET'])
def get_session(sessionID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from sessions where sessionID = {0}'.format(sessionID))
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

################ /playlist/{playlistID}/{musicFile} endpoint ################
# Get a song with id MusicFileID that is in a playlist with a specific playlistID
@playlist.route('/playlist/<playlistID>/<musicFileID>', methods=['GET'])
def get_song_from_playlist(playlistID, musicFileID):
    cursor = db.get_db().cursor()
    cursor.execute(f'''
SELECT mF.MusicFileID, title, artist, genre, `key`, tempo, ReleaseStatus, userid
FROM playlist p join playlistSong pS on p.PlaylistID = pS.PlaylistID
    join musicFile mF on pS.MusicFileID = mF.MusicFileID
WHERE p.PlaylistID = {str(playlistID)} AND mF.MusicFileID = {str(musicFileID)}
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

# Add new song with musicFileID to playlist with PlaylistID
@playlist.route('/playlist/<playlistID>/<musicFileID>', methods=['POST'])
def add_song_to_playlist():
# collecting data from the request object
    data = request.get_json()
    cursor = db.get_db().cursor()

    query = "INSERT INTO playlistSong (OrderNum, MusicFileID, PlaylistID) VALUES (%s, %s, %s, %s)"
    cursor.execute(query, (data['OrderNum'], data['MusicFileID'], data['PlaylistID']))
    db.get_db().commit()
    return make_response(jsonify({"message": "Song added!"}))

# Deletes song with MusicFileID from playlist with PlaylistID
@playlist.route('/playlist/<playlistID>/<musicFileID>', methods=['DELETE'])
def delete_song_from_playlist(playlistID, musicFileID):
    query = f'DELETE FROM playlistSong WHERE playlistID = "{playlistID}" AND musicFileID = "{musicFileID}"'

    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return f'Song {musicFileID} removed successfully from Playlist {playlistID}!'


################ /playlist/{userID}/{playlistID} endpoint ################
# Add collaborator with UserID from playlist with PlaylistID
@playlist.route('/playlistAddCollab', methods=['POST'])
def add_collaborators():
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    PlaylistID = the_data['PlaylistID']
    UserID = the_data['UserID']

    # Constructing the query
    query = "insert into playlistOwnership (UserID, PlaylistID) VALUES ('" + str(UserID) + "', '" + str(PlaylistID) + "')" 
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return make_response(jsonify({"message": "Collaborator added!"}))

# Deletes collaborator with UserID from playlist with PlaylistID
@playlist.route('/playlist/<playlistID>/<musicFileID>', methods=['DELETE'])
def remove_collaborators(userID, playlistID):
    query = f'DELETE FROM playlistOwnership WHERE playlistID = "{playlistID}" AND userID = "{userID}"'

    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return f'User {userID} removed as a collaborator from Playlist {playlistID}!'

# Get all playlists and songs in it
@playlist.route('/playlist', methods=['GET'])
def get_playlists():
    cursor = db.get_db().cursor()
    cursor.execute(f'''
select * from playlist join playlistOwnership pO on playlist.PlaylistID = pO.PlaylistID join users u on pO.UserID = u.UserID
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

@playlist.route('/user', methods=['GET'])
def get_user():

    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    UserID = the_data['UserID']

    cursor = db.get_db().cursor()
    cursor.execute("select UserID, FullName From users where UserID = '" + str(UserID) + "'")
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

@playlist.route('/users', methods=['GET'])
def get_users():

    cursor = db.get_db().cursor()
    cursor.execute("select UserID, FullName From users")
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response