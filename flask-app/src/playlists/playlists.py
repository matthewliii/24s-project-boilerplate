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

################ /playlist/{chartID} endpoint ################
# Get the playlist associated with trending charts of ChartID
@playlist.route('/playlist/<chartID>', methods=['GET'])
def playlist_chart(chartID):
    try:
        cursor = db.get_db().cursor()
        cursor.execute('''
            SELECT c.chartID, c.name, c.description
            FROM Chart c
            JOIN playlistCharts AS pc ON c.chartID = pc.chartID
            WHERE om.orderID = %s
        ''', (chartID,))
        charts = cursor.fetchall()

        if not charts:
            return 'No chart found for this playlist.', 404

        charts_data = [{'chartID': chart[0], 'name': chart[1], 'description': chart[2]} for chart in charts]

        return jsonify(charts_data), 200
    except Exception as e:
        current_app.logger.error(str(e))
        return jsonify({'error': 'Failed to retrieve playlist for chart.'}), 500

################ /playlist_musicFile endpoint ################
# Get a playlist with a specific playlistID and songs in it
@playlist.route('/playlist/<playlistID>/<MusicFileID>', methods=['GET'])
def get_playlist_playlistID_musicFileID(playlistID):
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





