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
    'Key' int NOT NULL,
    Tempo int NOT NULL,
    ReleaseStatus boolean DEFAULT FALSE,
    PRIMARY KEY(MusicFileID)
);

CREATE TABLE trackInfo
(
    MusicFileID int NOT NULL,
    Popularity int NOT NULL,
    Streams int NOT NULL,
    Mood varchar(50) NOT NULL,
    Duration int NOT NULL,
    Lyrics longtext,
    CONSTRAINT fk01
        FOREIGN KEY (MusicFileID) references musicFile(MusicFileID)
        ON UPDATE cascade ON DELETE restrict
);

CREATE TABLE playlist
(
    PlaylistID int NOT NULL,
    Name varchar(50) NOT NULL,
    OrderNum
    Description varchar(200),
    CreationDate datetime DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY(PlaylistID)
);

CREATE TABLE charts
(
    ChartID int NOT NULL,
    Name varchar(50) NOT NULL,
    Desription varchar(200),
    CreationDate datetime DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (ChartID)
)
