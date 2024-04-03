DROP DATABASE mixMaven;
CREATE DATABASE mixMaven;
USE mixMaven;

CREATE TABLE users
(
    UserID int AUTO_INCREMENT,
    Name varchar(50) NOT NULL,
    Email varchar (75) UNIQUE NOT NULL,
    PRIMARY KEY (UserID)
);

CREATE TABLE musicFile
(
    MusicFileID int AUTO_INCREMENT,
    Title varchar(50) NOT NULL,
    Artist varchar(50) NOT NULL,
    Genre varchar(50) NOT NULL,
    `Key` int NOT NULL,
    Tempo int NOT NULL,
    ReleaseStatus boolean DEFAULT FALSE,
    UserID int NOT NULL,
    PRIMARY KEY(MusicFileID),
    CONSTRAINT fk10
        FOREIGN KEY (UserID) REFERENCES users(UserID)
        ON UPDATE cascade ON DELETE restrict
);

CREATE TABLE trackInfo
(
    MusicInfoID int AUTO_INCREMENT,
    Popularity int NOT NULL,
    Streams int NOT NULL,
    Mood varchar(50) NOT NULL,
    Duration int NOT NULL,
    Lyrics longtext,
    MusicFileID int NOT NULL,
    PRIMARY KEY (MusicInfoID),
    CONSTRAINT fk01
        FOREIGN KEY (MusicFileID) references musicFile(MusicFileID)
        ON UPDATE cascade ON DELETE restrict
);

CREATE TABLE playlist
(
    PlaylistID int AUTO_INCREMENT,
    Name varchar(50) NOT NULL,
    Description varchar(200),
    CreationDate datetime DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY(PlaylistID)
);

CREATE TABLE charts
(
    ChartID int AUTO_INCREMENT,
    Name varchar(50) NOT NULL,
    Description varchar(200),
    CreationDate datetime DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (ChartID)
);

CREATE TABLE sessions
(
    SessionID int AUTO_INCREMENT,
    Name varchar(50) NOT NULL,
    Description varchar(200),
    CreationDate datetime DEFAULT CURRENT_TIMESTAMP NOT NULL,
    SongHistory varchar(100),
    PRIMARY KEY (SessionID)
);

CREATE TABLE artist
(
    ArtistID int AUTO_INCREMENT,
    Name varchar(50) NOT NULL,
    Genre varchar(50) NOT NULL,
    PRIMARY KEY (ArtistID)
);

CREATE TABLE playlistSong
(
    OrderNum int NOT NULL,
    MusicFileID int NOT NULL,
    PlaylistID int NOT NULL,
    CONSTRAINT fk02
        FOREIGN KEY (MusicFileID) REFERENCES musicFile(MusicFileID)
        On UPDATE cascade ON delete RESTRICT,
    CONSTRAINT fk03
        FOREIGN KEY (PlaylistID) REFERENCES playlist(PlaylistID)
        ON UPDATE cascade On DELETE RESTRICT
);

CREATE TABLE playlistOwnership
(
    UserID int NOT NULL,
    PlaylistID int NOT NULL,
    CONSTRAINT fk04
        FOREIGN KEY (UserID) REFERENCES users(UserID)
        ON UPDATE cascade On DELETE RESTRICT,
    CONSTRAINT fk05
        FOREIGN KEY (PlaylistID) REFERENCES playlist(PlaylistID)
        ON UPDATE cascade On DELETE RESTRICT
);

CREATE TABLE playlistSessions
(
    SessionID int NOT NULL,
    PlaylistID int NOT NULL,
    CONSTRAINT fk06
        FOREIGN KEY (SessionId) REFERENCES sessions(SessionID)
        ON UPDATE cascade On DELETE RESTRICT,
    CONSTRAINT fk07
        FOREIGN KEY (PlaylistID) REFERENCES playlist(PlaylistID)
        ON UPDATE cascade On DELETE RESTRICT
);

CREATE TABLE playlistCharts
(
    ChartID int NOT NULL,
    PlaylistID int NOT NULL,
    CONSTRAINT fk08
        FOREIGN KEY (ChartID) REFERENCES charts(ChartID)
        ON UPDATE cascade On DELETE RESTRICT,
    CONSTRAINT fk09
        FOREIGN KEY (PlaylistID) REFERENCES playlist(PlaylistID)
        ON UPDATE cascade On DELETE RESTRICT
);

CREATE TABLE artistSong
(
    ArtistID int NOT NULL,
    MusicFileID int NOT NULL,
    CONSTRAINT fk11
        FOREIGN KEY (ArtistID) REFERENCES artist(ArtistID)
        ON UPDATE cascade ON DELETE RESTRICT,
    CONSTRAINT fk12
        FOREIGN KEY (MusicFileID) REFERENCES musicFile(MusicFIleID)
        ON UPDATE cascade ON DELETE RESTRICT
);

CREATE TABLE userPreferences
(
    MusicFileID int NOT NULL,
    Genre varchar(50) NOT NULL,
    ArtistID int NOT NULL,
    CONSTRAINT fk13
        FOREIGN KEY (MusicFileID) REFERENCES musicFile(MusicFileID)
        ON UPDATE cascade ON DELETE RESTRICT,
    CONSTRAINT fk14
        FOREIGN KEY (ArtistID) REFERENCES artist(ArtistID)
        ON UPDATE cascade ON DELETE RESTRICT
);

INSERT INTO users (UserID, Name, Email) VALUES (1, 'John Doe', 'johndoe@example.com'),
    (2, 'Jane Smith', 'janesmith@example.com'),
    (3, 'Mike Johnson', 'mikejohnson@example.com'),
    (4, 'Emily Brown', 'emilybrown@example.com');

INSERT INTO musicFile (Title, Artist, Genre, `Key`, Tempo, ReleaseStatus, UserID) VALUES
('Song 1', 'Artist A', 'Pop', 1, 120, TRUE, 1),
('Song 2', 'Artist B', 'Rock', 2, 140, FALSE, 2),
('Song 3', 'Artist C', 'Hip Hop', 3, 90, TRUE, 3),
('Song 4', 'Artist D', 'Electronic', 4, 100, FALSE, 4);

INSERT INTO trackInfo (Popularity, Streams, Mood, Duration, Lyrics, MusicFileID) VALUES
(80, 500000, 'Happy', 240, 'Lyrics for Song 1.', 1),
(70, 300000, 'Energetic', 180, 'Lyrics for Song 2.', 2),
(90, 700000, 'Relaxed', 320, 'Lyrics for Song 3.', 3),
(60, 200000, 'Upbeat', 200, 'Lyrics for Song 4.', 4);

INSERT INTO playlist (Name, Description, CreationDate) VALUES
('Favorites', 'My favorite songs', '2024-04-01 10:00:00'),
('Workout Mix', 'Songs for working out', '2024-04-02 14:30:00'),
('Chill Vibes', 'Relaxing music for chilling', '2024-04-03 12:45:00'),
('Road Trip', 'Songs for a road trip', '2024-04-03 18:20:00');

INSERT INTO charts (Name, Description, CreationDate) VALUES
('Top 10 Hits', 'Chart of the top 10 popular songs', '2024-04-01 10:00:00'),
('Weekly Mix', 'Weekly curated playlist', '2024-04-02 14:30:00'),
('Genre Showcase', 'Showcasing different music genres', '2024-04-03 12:45:00'),
('Throwback Thursday', 'Throwback songs from the past', '2024-04-03 18:20:00');

INSERT INTO sessions (Name, Description, SongHistory) VALUES
('Morning Playlist', 'A morning playlist for starting the day', 'Song 1, Song 2, Song 3'),
('Evening Chill', 'Relaxing music for the evening', 'Song 4, Song 5, Song 6'),
('Work Mode', 'Upbeat songs for productivity', 'Song 7, Song 8, Song 9'),
('Party Mix', 'High-energy tracks for a party', 'Song 10, Song 11, Song 12');

INSERT INTO artist (Name, Genre) VALUES
('Artist A', 'Pop'),
('Artist B', 'Rock'),
('Artist C', 'Hip Hop'),
('Artist D', 'Electronic');

INSERT INTO playlistSong (OrderNum, MusicFileID, PlaylistID) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 2),
(4, 4, 2);

INSERT INTO playlistOwnership (UserID, PlaylistID) VALUES
(1, 1),
(2, 2),
(3, 1),
(4, 2);

INSERT INTO playlistSessions (SessionID, PlaylistID) VALUES
(1, 1),
(2, 2),
(3, 1),
(4, 2);

INSERT INTO playlistCharts (ChartID, PlaylistID) VALUES
(1, 1),
(2, 2),
(3, 1),
(4, 2);

INSERT INTO artistSong (ArtistID, MusicFileID) VALUES
(1, 1),
(2, 2),
(3, 1),
(4, 2);

INSERT INTO userPreferences (MusicFileID, Genre, ArtistID) VALUES
(1, 'Pop', 1),
(2, 'Rock', 2),
(3, 'Pop', 1),
(4, 'Rock', 2);

INSERT INTO users
    VALUES(3, 'John Smith', 'johnsmith@gmail.com', 'house');

/* As a user, I want to be able to add and store new music. */
INSERT INTO musicFile
    VALUES(1, 'You are my sunshine', 'LeBonBon', 'happy', 1, 1, true, 3);

INSERT INTO trackInfo
    VALUES(1, 10, 1000000, 'happy', 100, 'You are my sunshine, You are my sunshine, You are my sunshine', 1);

INSERT INTO playlist (PlaylistID, Name, Description)
    VALUES(1, 'Johns Playlist', 'Johns favorite songs');

INSERT INTO playlistSong
    VALUES(1, 1, 1);

/* As users, we want to be able to collaborate with other users to create playlists together. */
INSERT INTO playlistOwnership
    VALUES(1, 1);
    VALUES(2, 1);

INSERT INTO artist
    VALUES(1, 'LeBonBon', 'happy');

INSERT INTO artistSong
    VALUES(1, 1);

INSERT INTO userPreferences
    VALUES(1, 'house', 1);



/* As a user, I want to be able to sort my collection of music files by title, artist, genre, and BPM */
/* Sort music files by title */
SELECT * FROM MusicFile WHERE UserID = 3 ORDER BY Title;

/* Sort music files by artist */
SELECT * FROM MusicFile WHERE UserID = 3 ORDER BY Artist;

/* Sort music files by genre */
SELECT * FROM MusicFile WHERE UserID = 3 ORDER BY Genre;

/* Sort music files by BPM */
SELECT * FROM MusicFile WHERE UserID = 3 ORDER BY Tempo;

/* As a user, I would like to be able to search and filter through his collection of music files. */
/* Search music files by title */
SELECT * FROM MusicFile WHERE UserID = 1 AND Title LIKE '%You are my sunshine%';

/* Search music files by artist */
SELECT * FROM MusicFile WHERE UserID = 1 AND Artist LIKE '%LeBonBon%';

/* Search music files by genre */
SELECT * FROM MusicFile WHERE UserID = 1 AND Genre LIKE '%Happy%';
