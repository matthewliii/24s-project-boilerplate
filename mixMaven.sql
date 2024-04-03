DROP DATABASE mixMaven;
CREATE DATABASE mixMaven;
USE mixMaven;

CREATE TABLE users
(
    UserID int NOT NULL,
    Name varchar(50) NOT NULL,
    Email varchar (75) UNIQUE NOT NULL,
    UserPreferences varchar (75),
    PRIMARY KEY (UserID)
);

CREATE TABLE musicFile
(
    MusicFileID int NOT NULL,
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
    MusicInfoID int NOT NULL,
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
    PlaylistID int NOT NULL,
    Name varchar(50) NOT NULL,
    Description varchar(200),
    CreationDate datetime DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY(PlaylistID)
);

CREATE TABLE charts
(
    ChartID int NOT NULL,
    Name varchar(50) NOT NULL,
    Description varchar(200),
    CreationDate datetime DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (ChartID)
);

CREATE TABLE sessions
(
    SessionID int NOT NULL,
    Name varchar(50) NOT NULL,
    Description varchar(200),
    CreationDate datetime DEFAULT CURRENT_TIMESTAMP NOT NULL,
    SongHistory varchar(100),
    PRIMARY KEY (SessionID)
);

CREATE TABLE artist
(
    ArtistID int NOT NULL,
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
