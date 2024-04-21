DROP DATABASE mixMaven;
CREATE DATABASE mixMaven;
USE mixMaven;

CREATE TABLE users
(
    UserID int AUTO_INCREMENT,
    FullName varchar(50) NOT NULL,
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

insert into users (UserID, FullName, Email) values
(1, 'Margaret Furmage', 'mfurmage0@va.gov'),
(2, 'Justus Praill', 'jpraill1@wp.com'),
(3, 'Benito Mahaffey', 'bmahaffey2@samsung.com'),
(4, 'Jobi McRobb', 'jmcrobb3@oaic.gov.au'),
(5, 'Darsey Askey', 'daskey4@yellowbook.com'),
(6, 'Alphonse Conkling', 'aconkling5@blogtalkradio.com'),
(7, 'Pepi McKie', 'pmckie6@51.la'),
(8, 'Chelsea McGowing', 'cmcgowing7@dell.com'),
(9, 'Natale Greenside', 'ngreenside8@eventbrite.com'),
(10, 'Pierrette Skillern', 'pskillern9@cdc.gov'),
(11, 'Stevy Foreman', 'sforemana@de.vu'),
(12, 'Blake Iverson', 'biversonb@storify.com'),
(13, 'Matthieu Karpov', 'mkarpovc@cpanel.net'),
(14, 'Gunther Bezarra', 'gbezarrad@4shared.com'),
(15, 'Jarid Causon', 'jcausone@paypal.com'),
(16, 'Irene Wickett', 'iwickettf@elegantthemes.com'),
(17, 'Townsend Lamball', 'tlamballg@taobao.com'),
(18, 'Laryssa Dimitrescu', 'ldimitrescuh@hao123.com'),
(19, 'Tasha Wild', 'twildi@accuweather.com'),
(20, 'Marlon Simmans', 'msimmansj@mail.ru'),
(21, 'Saundra Laxton', 'slaxtonk@qq.com'),
(22, 'Radcliffe Smouten', 'rsmoutenl@cbc.ca'),
(23, 'Daffie Devennie', 'ddevenniem@lulu.com'),
(24, 'Israel Rymill', 'irymilln@ezinearticles.com'),
(25, 'Roanna Messitt', 'rmessitto@biglobe.ne.jp'),
(26, 'Helenka Patience', 'hpatiencep@mtv.com'),
(27, 'Grace Danilovich', 'gdanilovichq@independent.co.uk'),
(28, 'Bernete Maggorini', 'bmaggorinir@alexa.com'),
(29, 'Federico Rubery', 'fruberys@narod.ru'),
(30, 'Helenka Rickcord', 'hrickcordt@wikispaces.com'),
(31, 'Derrek Derkes', 'dderkesu@fastcompany.com'),
(32, 'Rochell Francello', 'rfrancellov@ocn.ne.jp'),
(33, 'Pryce Couthard', 'pcouthardw@icq.com'),
(34, 'Allan Fidelli', 'afidellix@prnewswire.com'),
(35, 'Gussi Duddin', 'gduddiny@timesonline.co.uk'),
(36, 'Gerald Blackett', 'gblackettz@omniture.com'),
(37, 'Sapphira Sant', 'ssant10@miibeian.gov.cn'),
(38, 'Christie Shah', 'cshah11@intel.com'),
(39, 'Alard Wale', 'awale12@tumblr.com'),
(40, 'Giffy Melwall', 'gmelwall13@quantcast.com'),
(41, 'Stanton Hearnah', 'shearnah14@wordpress.com'),
(42, 'Janifer Juppe', 'jjuppe15@nifty.com'),
(43, 'Bab Torrejon', 'btorrejon16@virginia.edu'),
(44, 'Fredra Vasichev', 'fvasichev17@wp.com'),
(45, 'Pietro Creeber', 'pcreeber18@moonfruit.com'),
(46, 'Nancy Kield', 'nkield19@unblog.fr'),
(47, 'Pat New', 'pnew1a@miitbeian.gov.cn'),
(48, 'Victor Swaddle', 'vswaddle1b@github.io'),
(49, 'Natasha Casero', 'ncasero1c@blogger.com'),
(50, 'Melony Renihan', 'mrenihan1d@delicious.com');


insert into musicFile (MusicFileID, Title, Artist, Genre, `Key`, Tempo, ReleaseStatus, UserID) values
(1, 'Rosewood Rondo', 'The Harmonic Hares', 'rock', 12, 127, true, 13),
(2, 'Coral Cantata', 'Retro Rhythms', 'hip hop', 21, 63, false, 16),
(3, 'Dancing in the Moonlight', 'Electric Dreamers', 'pop', 5, 137, false, 43),
(4, 'Ruby Rhapsody', 'Reggae Rascals', 'jazz', 5, 129, false, 36),
(5, 'Pearl Polka', 'The Funky Ferrets', 'blues', 45, 85, false, 34),
(6, 'Bronze Ballad', 'Lil Sparkle', 'rock', 50, 74, true, 41),
(7, 'Electric Dreams', 'The Musical Mice', 'blues', 15, 106, true, 28),
(8, 'Galactic Groove', 'The Beat Boxers', 'blues', 27, 159, false, 29),
(9, 'Golden Gavotte', 'The Jazz Jets', 'reggae', 40, 142, true, 47),
(10, 'Amber Adagio', 'The Beat Badgers', 'rock', 35, 90, true, 8),
(11, 'Silver Sonnet', 'Electronic Echoes', 'country', 18, 166, false, 25),
(12, 'Silver Sonnet', 'Reggae Rascals', 'hip hop', 48, 153, false, 1),
(13, 'Ethereal Elegy', 'Metal Monkeys', 'metal', 47, 87, true, 26),
(14, 'Turquoise Tune', 'Retro Rebels', 'jazz', 39, 81, true, 31),
(15, 'Turquoise Tune', 'Metal Monkeys', 'pop', 25, 104, false, 22),
(16, 'Oceanic Overture', 'Soulful Serenade', 'classical', 48, 118, true, 23),
(17, 'Silver Sonnet', 'The Rhythm Raccoons', 'reggae', 36, 68, false, 5),
(18, 'Platinum Prelude', 'DJ Banana Split', 'electronic', 12, 134, true, 4),
(19, 'Pearl Polka', 'Soulful Sirens', 'classical', 11, 86, true, 21),
(20, 'Lullaby of the Night', 'Hip Hop Hounds', 'electronic', 34, 168, true, 37),
(21, 'Aurora Anthem', 'The Funky Monkeys', 'country', 14, 141, false, 7),
(22, 'Electric Dreams', 'Pop Princesses', 'metal', 19, 168, false, 6),
(23, 'Copper Cadenza', 'The Beat Badgers', 'electronic', 9, 98, false, 44),
(24, 'Electric Dreams', 'The Musical Mice', 'country', 28, 114, true, 33),
(25, 'Crimson Cadence', 'The Harmonic Hedgehogs', 'metal', 18, 139, false, 20),
(26, 'Ivory Interlude', 'Soulful Serenade', 'rock', 31, 114, true, 10),
(27, 'Lullaby of the Night', 'Rockin Rhinos', 'classical', 14, 81, true, 2),
(28, 'Opal Overture', 'Soulful Sirens', 'rock', 3, 129, false, 32),
(29, 'Silver Sonnet', 'The Funky Ferrets', 'rock', 31, 170, true, 40),
(30, 'Ruby Rhapsody', 'The Harmonic Hedgehogs', 'rock', 44, 128, false, 27),
(31, 'Azure Allegro', 'Pop Princesses', 'electronic', 41, 111, true, 48),
(32, 'Serenade of the Stars', 'Folk Foxes', 'reggae', 7, 187, false, 49),
(33, 'Golden Gavotte', 'The Beat Badgers', 'classical', 7, 167, false, 30),
(34, 'Pearl Polka', 'Lil Sparkle', 'country', 14, 60, true, 14),
(35, 'Oceanic Overture', 'Classical Cats', 'pop', 4, 132, true, 50),
(36, 'Sunset Serenade', 'Punk Pigs', 'pop', 26, 92, false, 46),
(37, 'Ivory Interlude', 'The Rockin Roosters', 'classical', 31, 137, true, 18),
(38, 'Enchanted Echoes', 'Indie Icons', 'reggae', 9, 77, false, 19),
(39, 'Violet Verse', 'Country Crooners', 'jazz', 3, 144, false, 12),
(40, 'Ethereal Elegy', 'Alternative Alligators', 'hip hop', 12, 167, false, 17),
(41, 'Ivory Interlude', 'Neon Nights', 'electronic', 5, 118, false, 9),
(42, 'Sapphire Serenade', 'The Melodic Mermaids', 'rock', 21, 176, true, 24),
(43, 'Starlight Symphony', 'Rockin Rhinos', 'country', 46, 86, false, 38),
(44, 'Midnight Melodies', 'Pop Pioneers', 'metal', 16, 132, true, 35),
(45, 'Lullaby of the Night', 'Rockin Rhinos', 'classical', 14, 81, true, 2),
(46, 'Emerald Elegy', 'Hip Hop Hounds', 'country', 30, 94, false, 15),
(47, 'Ethereal Elegy', 'Pop Princesses', 'rock', 41, 78, false, 39),
(48, 'Topaz Tango', 'The Disco Ducks', 'metal', 19, 159, true, 42),
(49, 'Silver Sonnet', 'Soulful Sirens', 'pop', 42, 175, false, 45),
(50, 'Violet Verse', 'Indie Icons', 'reggae', 26, 129, false, 3);

insert into trackInfo (MusicInfoID, Popularity, Streams, Mood, Duration, Lyrics, MusicFileID)
values
    (1, 98, 802470983, 'nostalgic', 7484, 'Billie Jean', 29),
    (2, 49, 291207197, 'happy', 6426, 'Dancing Queen', 7),
    (3, 22, 541780358, 'nostalgic', 4738, 'Don''t stop believin''', 5),
    (4, 10, 978335392, 'nostalgic', 2322, 'Thriller', 33),
    (5, 62, 533855930, 'calm', 8249, 'I''m walking on sunshine', 37),
    (6, 5, 381449424, 'dreamy', 9772, 'Don''t stop believin''', 47),
    (7, 38, 316774933, 'melancholic', 6654, 'Thriller', 50),
    (8, 62, 660750092, 'happy', 2207, 'Don''t stop believin''', 44),
    (9, 78, 772812805, 'relaxed', 7337, 'Thriller', 21),
    (10, 46, 958041703, 'upbeat', 5699, 'Thriller', 16),
    (11, 47, 240831875, 'dreamy', 9561, 'Dancing Queen', 48),
    (12, 88, 568712183, 'sad', 6141, 'I will always love you', 18),
    (13, 83, 946032851, 'energetic', 3795, 'Hotel California', 20),
    (14, 98, 407303152, 'relaxed', 4739, 'Hotel California', 24),
    (15, 48, 873030858, 'nostalgic', 6612, 'Billie Jean', 19),
    (16, 24, 930995367, 'calm', 2071, 'I will always love you', 35),
    (17, 56, 746790073, 'nostalgic', 9061, 'I will always love you', 9),
    (18, 52, 371880766, 'upbeat', 4738, 'Don''t stop believin''', 30),
    (19, 75, 324973971, 'angry', 7652, 'Hotel California', 31),
    (20, 11, 269577157, 'upbeat', 162, 'Hotel California', 39),
    (21, 30, 836980224, 'nostalgic', 3040, 'Billie Jean', 45),
    (22, 83, 451764190, 'energetic', 4487, 'Don''t stop believin''', 8),
    (23, 54, 770434001, 'energetic', 5473, 'I will always love you', 27),
    (24, 90, 191748664, 'relaxed', 99, 'I''m walking on sunshine', 12),
    (25, 85, 5861999, 'melancholic', 7116, 'Livin'' on a prayer', 26),
    (26, 47, 255307246, 'upbeat', 5375, 'I''m walking on sunshine', 4),
    (27, 4, 308837694, 'upbeat', 1547, 'Dancing Queen', 49),
    (28, 99, 844507336, 'sad', 4502, 'Thriller', 10),
    (29, 98, 571218443, 'upbeat', 1397, 'Dancing Queen', 40),
    (30, 34, 176935387, 'dreamy', 2730, 'I will always love you', 38),
    (31, 3, 727430173, 'upbeat', 4175, 'I''m walking on sunshine', 36),
    (32, 76, 749349753, 'dreamy', 2965, 'Billie Jean', 34),
    (33, 66, 538805199, 'melancholic', 3177, 'Sweet Caroline', 11),
    (34, 71, 203930185, 'happy', 3670, 'Thriller', 1),
    (35, 23, 717400288, 'nostalgic', 5404, 'Sweet Caroline', 46),
    (36, 13, 230555359, 'energetic', 1858, 'I will always love you', 23),
    (37, 65, 379746382, 'relaxed', 6711, 'I''m walking on sunshine', 32),
    (38, 27, 118899017, 'energetic', 9548, 'I''m walking on sunshine', 3),
    (39, 26, 72134622, 'angry', 2335, 'Bohemian Rhapsody', 22),
    (40, 19, 288424443, 'nostalgic', 4129, 'Livin'' on a prayer', 25),
    (41, 85, 430033136, 'happy', 8180, 'Don''t stop believin''', 2),
    (42, 15, 768247826, 'dreamy', 3428, 'Thriller', 15),
    (43, 8, 451975103, 'happy', 7238, 'Don''t stop believin''', 17),
    (44, 11, 644234548, 'angry', 1734, 'I will always love you', 43),
    (45, 9, 46896723, 'energetic', 1828, 'Billie Jean', 41),
    (46, 5, 812006453, 'happy', 7782, 'I will always love you', 28),
    (47, 7, 501484022, 'melancholic', 2035, 'Billie Jean', 13),
    (48, 81, 972939253, 'dreamy', 8631, 'Billie Jean', 42),
    (49, 76, 232134802, 'nostalgic', 6873, 'Billie Jean', 6),
    (50, 65, 829358489, 'melancholic', 7800, 'I''m walking on sunshine', 1);


insert into playlist (PlaylistID, Name, Description) values
(1, '90s Pop Punk', 'Relaxing acoustic melodies'),
(2, '90s Indie', 'Country road trip playlist'),
(3, 'Acoustic Sessions', 'EDM party mix'),
(4, '90s Indie', '90s throwback hits'),
(5, 'Summer Vibes', 'Chill vibes for a rainy day'),
(6, 'Guitar Legends', 'Jazz classics for a cozy evening'),
(7, '90s Nostalgia', 'EDM party mix'),
(8, 'Throwback Tunes', 'High-energy workout tunes'),
(9, '90s Indie', 'Feel-good pop songs'),
(10, '80s Flashback', 'Soulful R&B jams'),
(11, 'Dance Party', 'Chill vibes for a rainy day'),
(12, 'Pop Hits', 'Relaxing acoustic melodies'),
(13, 'Indie Mix', 'Country road trip playlist'),
(14, '90s Grunge', 'Country road trip playlist'),
(15, '90s R&B', 'Soulful R&B jams'),
(16, 'Folk Favorites', 'Chill vibes for a rainy day'),
(17, 'Electronic Beats', '90s throwback hits'),
(18, 'Soulful Sounds', 'EDM party mix'),
(19, '80s Flashback', 'Chill vibes for a rainy day'),
(20, 'Chill Vibes', 'Country road trip playlist'),
(21, 'Indie Mix', 'Country road trip playlist'),
(22, 'Feel Good Favorites', 'Feel-good pop songs'),
(23, 'Jazz Lounge', 'Jazz classics for a cozy evening'),
(24, 'Indie Mix', 'Soulful R&B jams'),
(25, 'Classical Melodies', 'Soulful R&B jams'),
(26, 'Summer Vibes', 'High-energy workout tunes'),
(27, 'Alternative Anthems', 'Jazz classics for a cozy evening'),
(28, '90s Jazz', 'Soulful R&B jams'),
(29, 'Guitar Legends', 'Indie rock anthems'),
(30, '90s Reggae', 'Soulful R&B jams'),
(31, 'Acoustic Sessions', '90s throwback hits'),
(32, '90s Indie', '90s throwback hits'),
(33, 'Instrumental Bliss', 'EDM party mix'),
(34, 'Jazz Lounge', 'Feel-good pop songs'),
(35, '90s Classical', 'Country road trip playlist'),
(36, 'Chill Vibes', 'Relaxing acoustic melodies'),
(37, 'Karaoke Night', 'Soulful R&B jams'),
(38, '90s Jazz', 'Jazz classics for a cozy evening'),
(39, 'Latin Beats', 'Indie rock anthems'),
(40, '90s Nostalgia', 'Chill vibes for a rainy day'),
(41, 'Acoustic Sessions', 'Soulful R&B jams'),
(42, 'Latin Beats', 'Chill vibes for a rainy day'),
(43, 'Classical Melodies', 'Jazz classics for a cozy evening'),
(44, 'Reggae Rhythms', '90s throwback hits'),
(45, 'Dance Party', 'Chill vibes for a rainy day'),
(46, 'Soulful Sounds', 'Relaxing acoustic melodies'),
(47, 'Acoustic Sessions', 'Soulful R&B jams'),
(48, '90s Hip Hop', 'Indie rock anthems'),
(49, 'Pop Hits', 'Soulful R&B jams'),
(50, 'Disney Magic', 'High-energy workout tunes');


insert into charts (ChartID, Name, Description) values
(1, 'Pop Music Charts', 'Top 100 Hits of the Week'),
(2, 'iTunes Top 20', 'Classic Rock Anthems'),
(3, 'Top 100 Hits', 'Classic Rock Anthems'),
(4, 'Pop Music Charts', 'Best Songs of the Year'),
(5, 'iTunes Top 20', 'Top 100 Hits of the Week'),
(6, 'Radio Hits Countdown', 'Top 100 Hits of the Week'),
(7, 'Billboard Hot 200', 'Chart-Topping Pop Hits'),
(8, 'Top 100 Hits', 'Rising Stars in Music'),
(9, 'Pop Music Charts', 'Top 100 Hits of the Week'),
(10, 'Music Streaming Top 10', 'Top 100 Hits of the Week'),
(11, 'Music Streaming Top 10', 'Classic Rock Anthems'),
(12, 'Music Streaming Top 10', 'Hip Hop and R&B Bangers'),
(13, 'iTunes Top 20', 'Indie Music Discoveries'),
(14, 'Music Streaming Top 10', 'Best Songs of the Year'),
(15, 'UK Top 40', 'Chart-Topping Pop Hits'),
(16, 'Billboard Hot 200', 'Rising Stars in Music'),
(17, 'Radio Hits Countdown', 'Chart-Topping Pop Hits'),
(18, 'Radio Hits Countdown', 'Top 100 Hits of the Week'),
(19, 'Pop Music Charts', 'Classic Rock Anthems'),
(20, 'Top 100 Hits', 'Indie Music Discoveries'),
(21, 'UK Top 40', 'Indie Music Discoveries'),
(22, 'Billboard Hot 200', 'Indie Music Discoveries'),
(23, 'Chart Toppers Weekly', 'Ultimate Party Playlist'),
(24, 'Rock Music Countdown', 'Hip Hop and R&B Bangers'),
(25, 'UK Top 40', 'EDM Dancefloor Fillers'),
(26, 'Top 100 Hits', 'Hip Hop and R&B Bangers'),
(27, 'Music Streaming Top 10', 'Best Songs of the Year'),
(28, 'Radio Hits Countdown', 'Classic Rock Anthems'),
(29, 'iTunes Top 20', 'Country Music Favorites'),
(30, 'Global Top 50', 'Indie Music Discoveries'),
(31, 'Top 100 Hits', 'Chart-Topping Pop Hits'),
(32, 'Music Streaming Top 10', 'Ultimate Party Playlist'),
(33, 'iTunes Top 20', 'Rising Stars in Music'),
(34, 'Billboard Hot 200', 'Chart-Topping Pop Hits'),
(35, 'Billboard Hot 200', 'Best Songs of the Year'),
(36, 'Radio Hits Countdown', 'EDM Dancefloor Fillers'),
(37, 'UK Top 40', 'EDM Dancefloor Fillers'),
(38, 'iTunes Top 20', 'Ultimate Party Playlist'),
(39, 'UK Top 40', 'Rising Stars in Music'),
(40, 'Radio Hits Countdown', 'Chart-Topping Pop Hits'),
(41, 'Top 100 Hits', 'Ultimate Party Playlist'),
(42, 'Chart Toppers Weekly', 'EDM Dancefloor Fillers'),
(43, 'Top 100 Hits', 'Hip Hop and R&B Bangers'),
(44, 'Global Top 50', 'Hip Hop and R&B Bangers'),
(45, 'Global Top 50', 'Chart-Topping Pop Hits'),
(46, 'Global Top 50', 'Rising Stars in Music'),
(47, 'Pop Music Charts', 'Classic Rock Anthems'),
(48, 'Billboard Hot 200', 'Country Music Favorites'),
(49, 'Rock Music Countdown', 'Ultimate Party Playlist'),
(50, 'Music Streaming Top 10', 'Indie Music Discoveries');


insert into sessions (SessionID, Name, Description, SongHistory) values
(1, 'Classical Cadence', 'Hip hop freestyle cypher', 'Livin'' on a Prayer'),
(2, 'Classical Cadence', 'Experimental noise music exploration', 'Smells Like Teen Spirit'),
(3, 'Rock Rendezvous', 'Reggae dub mixing session', 'Shape of You'),
(4, 'Jazz Jam', 'Country music songwriting workshop', 'Bohemian Rhapsody'),
(5, 'Rock Rendezvous', 'Experimental noise music exploration', 'Smells Like Teen Spirit'),
(6, 'Blues Bash', 'Reggae dub mixing session', 'Uptown Funk'),
(7, 'Pop Party', 'Jazz improvisation workshop', 'Billie Jean'),
(8, 'Classical Cadence', 'Hip hop freestyle cypher', 'Smells Like Teen Spirit'),
(9, 'Blues Bash', 'Reggae dub mixing session', 'I Will Always Love You'),
(10, 'Pop Party', 'Pop music cover song performance', 'Billie Jean'),
(11, 'Electronic Extravaganza', 'Country music songwriting workshop', 'Hey Jude'),
(12, 'Electronic Extravaganza', 'Pop music cover song performance', 'Billie Jean'),
(13, 'Funky Fusion', 'Classical music ensemble rehearsal', 'Bohemian Rhapsody'),
(14, 'Classical Cadence', 'Jazz improvisation workshop', 'Wonderwall'),
(15, 'Reggae Rhythm', 'Jazz improvisation workshop', 'Billie Jean'),
(16, 'Funky Fusion', 'Experimental noise music exploration', 'Billie Jean'),
(17, 'Jazz Jam', 'Folk music sing-along gathering', 'Smells Like Teen Spirit'),
(18, 'Rock Rendezvous', 'Rock band jam session', 'Bohemian Rhapsody'),
(19, 'Pop Party', 'Jazz improvisation workshop', 'Hey Jude'),
(20, 'Blues Bash', 'Country music songwriting workshop', 'Wonderwall'),
(21, 'Blues Bash', 'Classical music ensemble rehearsal', 'I Will Always Love You'),
(22, 'Blues Bash', 'Rock band jam session', 'Uptown Funk'),
(23, 'Funky Fusion', 'Folk music sing-along gathering', 'Bohemian Rhapsody'),
(24, 'Electronic Extravaganza', 'Folk music sing-along gathering', 'I Will Always Love You'),
(25, 'Jazz Jam', 'Classical music ensemble rehearsal', 'Bohemian Rhapsody'),
(26, 'Hip Hop Hangout', 'Classical music ensemble rehearsal', 'Billie Jean'),
(27, 'Electronic Extravaganza', 'Folk music sing-along gathering', 'Uptown Funk'),
(28, 'Rock Rendezvous', 'Jazz improvisation workshop', 'Smells Like Teen Spirit'),
(29, 'Reggae Rhythm', 'Classical music ensemble rehearsal', 'Sweet Child o'' Mine'),
(30, 'Blues Bash', 'Hip hop freestyle cypher', 'Shape of You'),
(31, 'Electronic Extravaganza', 'Country music songwriting workshop', 'Livin'' on a Prayer'),
(32, 'Blues Bash', 'Country music songwriting workshop', 'Bohemian Rhapsody'),
(33, 'Classical Cadence', 'Jazz improvisation workshop', 'Wonderwall'),
(34, 'Jazz Jam', 'Country music songwriting workshop', 'Uptown Funk'),
(35, 'Classical Cadence', 'Experimental noise music exploration', 'Wonderwall'),
(36, 'Classical Cadence', 'Reggae dub mixing session', 'Uptown Funk'),
(37, 'Funky Fusion', 'Folk music sing-along gathering', 'Wonderwall'),
(38, 'Hip Hop Hangout', 'Electronic music production tutorial', 'Livin'' on a Prayer'),
(39, 'Classical Cadence', 'Electronic music production tutorial', 'Shape of You'),
(40, 'Pop Party', 'Jazz improvisation workshop', 'Smells Like Teen Spirit'),
(41, 'Hip Hop Hangout', 'Folk music sing-along gathering', 'Sweet Child o'' Mine'),
(42, 'Reggae Rhythm', 'Pop music cover song performance', 'Hey Jude'),
(43, 'Classical Cadence', 'Classical music ensemble rehearsal', 'Bohemian Rhapsody'),
(44, 'Reggae Rhythm', 'Electronic music production tutorial', 'Uptown Funk'),
(45, 'Jazz Jam', 'Country music songwriting workshop', 'Livin'' on a Prayer'),
(46, 'Rock Rendezvous', 'Pop music cover song performance', 'Bohemian Rhapsody'),
(47, 'Rock Rendezvous', 'Rock band jam session', 'I Will Always Love You'),
(48, 'Electronic Extravaganza', 'Hip hop freestyle cypher', 'Bohemian Rhapsody'),
(49, 'Jazz Jam', 'Hip hop freestyle cypher', 'Sweet Child o'' Mine'),
(50, 'Electronic Extravaganza', 'Jazz improvisation workshop', 'Hey Jude');

INSERT INTO artist (Name, Genre) VALUES
('Artist A', 'Pop'),
('Artist B', 'Rock'),
('Artist C', 'Hip Hop'),
('Artist D', 'Electronic');

INSERT INTO playlistSong (OrderNum, MusicFileID, PlaylistID) VALUES
(62, '43', '10'), (29, '21', '9'), (62, '36', '17'), (68, '48', '48'),
(70, '23', '50'), (37, '10', '38'), (51, '18', '13'), (98, '12', '28'),
(45, '9', '12'), (48, '38', '32'), (29, '24', '27'), (40, '40', '49'),
(5, '47', '31'), (10, '30', '23'), (48, '19', '3'), (77, '17', '11'),
(19, '44', '41'), (67, '39', '16'), (46, '5', '47'), (74, '45', '6'),
(17, '3', '1'), (44, '33', '33'), (13, '29', '7'), (85, '50', '42'),
(51, '16', '14'), (84, '1', '4'), (17, '4', '21'), (69, '34', '24'),
(94, '20', '2'), (62, '7', '8'), (62, '11', '35'), (69, '32', '5'),
(86, '27', '37'), (36, '6', '25'), (20, '41', '22'), (93, '22', '45'),
(22, '49', '36'), (37, '28', '19'), (39, '31', '39'), (25, '14', '34'),
(26, '13', '29'), (57, '46', '44'), (67, '8', '15'), (25, '25', '18'),
(49, '35', '26'), (52, '37', '30'), (75, '2', '43'), (44, '42', '40'),
(31, '15', '20'), (45, '26', '46'), (33, '16', '26'), (66, '33', '49'),
(47, '7', '22'), (58, '36', '10'), (91, '10', '35'), (80, '26', '38'),
(45, '49', '2'), (51, '39', '31'), (68, '20', '15'), (44, '27', '16'),
(83, '30', '47'), (67, '3', '21'), (22, '18', '43'), (78, '6', '37'),
(60, '11', '18'), (76, '8', '14'), (39, '45', '11'), (88, '37', '1'),
(35, '13', '23'), (12, '29', '42'), (20, '17', '32'), (20, '5', '50'),
(97, '40', '44'), (38, '47', '48'), (82, '1', '12'), (32, '44', '24'),
(77, '22', '25'), (19, '35', '39'), (28, '32', '40'), (13, '42', '45'),
(33, '43', '29'), (100, '23', '7'), (30, '14', '20'), (84, '50', '30'),
(92, '48', '27'), (13, '4', '34'), (16, '41', '19'), (84, '25', '5'),
(29, '46', '4'), (61, '9', '6'), (63, '12', '33'), (79, '38', '41'),
(41, '15', '8'), (60, '2', '28'), (18, '19', '13'), (12, '24', '9'),
(48, '28', '46'), (86, '34', '36'), (91, '21', '3'), (85, '31', '17'),
(41, '19', '2'), (1, '16', '27'), (15, '18', '3'), (8, '11', '40'),
(64, '43', '23'), (70, '42', '49'), (74, '31', '14'), (55, '37', '16'),
(24, '2', '8'), (99, '20', '36'), (5, '30', '6'), (68, '50', '42'),
(4, '41', '21'), (79, '14', '4'), (26, '33', '24'), (90, '39', '10'),
(82, '17', '15'), (77, '22', '5'), (94, '48', '20'), (14, '21', '28'),
(52, '34', '13'), (57, '38', '33'), (62, '4', '7'), (37, '49', '46'),
(80, '46', '43'), (96, '44', '41'), (10, '8', '19'), (22, '25', '50'),
(82, '28', '29'), (31, '1', '17'), (35, '47', '45'), (78, '13', '1'),
(33, '27', '9'), (20, '26', '38'), (22, '15', '22'), (82, '6', '32'),
(80, '23', '30'), (44, '29', '44'), (14, '9', '31'), (54, '10', '12'),
(67, '3', '26'), (73, '40', '39'), (55, '45', '35'), (64, '7', '11'),
(83, '36', '34'), (93, '32', '47'), (76, '24', '18'), (55, '5', '25'),
(90, '35', '48'), (33, '12', '37'), (34, '30', '38'), (81, '20', '42'),
(43, '35', '47'), (18, '49', '29'), (10, '14', '25'), (75, '32', '10'),
(82, '28', '45'), (75, '44', '14'), (99, '43', '28'), (19, '22', '9'),
(60, '13', '8'), (25, '31', '39'), (74, '39', '3'), (9, '40', '41'),
(26, '18', '23'), (38, '1', '44'), (5, '15', '33'), (16, '20', '35');


INSERT INTO playlistOwnership (UserID, PlaylistID) VALUES
('5', '28'), ('26', '27'), ('20', '4'), ('37', '26'), ('43', '40'),
('11', '12'), ('31', '14'), ('34', '13'), ('38', '47'), ('4', '41'),
('7', '46'), ('15', '20'), ('18', '22'), ('47', '39'), ('17', '49'),
('12', '19'), ('10', '34'), ('21', '36'), ('1', '35'), ('28', '37'),
('8', '29'), ('48', '10'), ('19', '45'), ('36', '38'), ('40', '1'),
('45', '33'), ('44', '44'), ('27', '21'), ('46', '15'), ('33', '25'),
('9', '43'), ('14', '3'), ('32', '17'), ('16', '7'), ('35', '18'),
('41', '6'), ('42', '5'), ('29', '48'), ('39', '8'), ('30', '31'),
('6', '23'), ('50', '50'), ('25', '30'), ('24', '9'), ('13', '2'),
('3', '24'), ('2', '32'), ('22', '11'), ('49', '16'), ('23', '42'),
('4', '17'), ('14', '40'), ('34', '28'), ('40', '18'), ('44', '42'),
('42', '24'), ('16', '43'), ('36', '31'), ('6', '20'), ('7', '29'),
('25', '21'), ('29', '38'), ('18', '50'), ('39', '2'), ('30', '49'),
('24', '22'), ('50', '9'), ('32', '12'), ('22', '32'), ('13', '14'),
('35', '6'), ('41', '47'), ('48', '5'), ('28', '3'), ('26', '37'),
('11', '27'), ('10', '39'), ('15', '25'), ('8', '7'), ('38', '23'),
('21', '16'), ('19', '15'), ('46', '35'), ('49', '46'), ('27', '33'),
('9', '34'), ('33', '44'), ('3', '41'), ('43', '48'), ('31', '8'),
('5', '19'), ('45', '36'), ('2', '1'), ('1', '13'), ('20', '10'),
('47', '26'), ('17', '11'), ('12', '4'), ('23', '45'), ('37', '30'),
('19', '17'), ('41', '42'), ('49', '25'), ('35', '46'), ('32', '23'),
('38', '1'), ('33', '8'), ('17', '15'), ('12', '50'), ('29', '35'),
('42', '38'), ('36', '31'), ('23', '19'), ('6', '48'), ('15', '10'),
('16', '32'), ('3', '43'), ('31', '9'), ('50', '29'), ('39', '18'),
('2', '45'), ('37', '7'), ('10', '26'), ('13', '22'), ('43', '21'),
('26', '37'), ('4', '13'), ('46', '39'), ('5', '49'), ('25', '20'),
('18', '41'), ('9', '11'), ('22', '40'), ('45', '2'), ('47', '27'),
('24', '5'), ('34', '16'), ('27', '30'), ('20', '12'), ('14', '44'),
('11', '24'), ('40', '47'), ('48', '36'), ('1', '33'), ('21', '4'),
('28', '14'), ('30', '28'), ('7', '34'), ('44', '3'), ('8', '6'),
('4', '18'), ('18', '23'), ('40', '7'), ('26', '49'), ('15', '29'),
('23', '42'), ('14', '40'), ('36', '12'), ('28', '36'), ('37', '35'),
('8', '27'), ('9', '39'), ('33', '24'), ('17', '26'), ('13', '13'),
('25', '50'), ('16', '38'), ('49', '9'), ('10', '22'), ('24', '43'),
('22', '3'), ('47', '14'), ('6', '21'), ('30', '47'), ('27', '41'),
('2', '44'), ('21', '33'), ('12', '16'), ('38', '4'), ('41', '17'),
('19', '37'), ('43', '34'), ('1', '8'), ('39', '46'), ('11', '1'),
('34', '19'), ('42', '5'), ('29', '6'), ('20', '20'), ('46', '10'),
('32', '11'), ('5', '31'), ('48', '25'), ('50', '2'), ('7', '30'),
('35', '28'), ('3', '45'), ('45', '15'), ('31', '32'), ('44', '48'),
('2', '26'), ('36', '20'), ('3', '35'), ('46', '13'), ('25', '21'),
('50', '36'), ('34', '43'), ('4', '29'), ('27', '45'), ('45', '32'),
('21', '46'), ('42', '9'), ('32', '50'), ('41', '30'), ('22', '40'),
('29', '7'), ('44', '14'), ('7', '44'), ('39', '11'), ('24', '39'),
('8', '18'), ('5', '17'), ('23', '48'), ('18', '25'), ('40', '47'),
('26', '22'), ('16', '34'), ('37', '2'), ('33', '8'), ('15', '6'),
('30', '1'), ('17', '41'), ('43', '37'), ('13', '24'), ('38', '3'),
('35', '16'), ('1', '4'), ('11', '31'), ('6', '49'), ('31', '19'),
('9', '15'), ('48', '12'), ('28', '42'), ('19', '5'), ('47', '33'),
('49', '10'), ('20', '38'), ('10', '28'), ('12', '23'), ('14', '27');


insert into playlistSessions (SessionID, PlaylistID) values ('23', '33'),
('22', '47'),
('4', '15'),
('50', '34'),
('40', '26'),
('16', '48'),
('38', '8'),
('3', '46'),
('18', '50'),
('29', '10'),
('2', '30'),
('33', '12'),
('32', '19'),
('15', '31'),
('31', '49'),
('20', '6'),
('11', '29'),
('36', '39'),
('8', '22'),
('35', '36'),
('19', '35'),
('13', '20'),
('27', '45'),
('17', '2'),
('34', '37'),
('24', '5'),
('1', '14'),
('49', '40'),
('42', '13'),
('48', '1'),
('14', '25'),
('9', '27'),
('45', '9'),
('7', '4'),
('43', '23'),
('6', '43'),
('5', '38'),
('30', '18'),
('37', '11'),
('10', '41'),
('39', '24'),
('47', '42'),
('26', '16'),
('44', '21'),
('21', '17'),
('46', '32'),
('28', '7'),
('12', '3'),
('25', '28'),
('41', '44'),
('38', '24'),
('42', '25'),
('39', '32'),
('44', '36'),
('50', '30'),
('43', '9'),
('26', '41'),
('3', '31'),
('21', '1'),
('5', '39'),
('18', '13'),
('4', '8'),
('7', '21'),
('41', '12'),
('2', '35'),
('19', '46'),
('32', '14'),
('35', '38'),
('40', '20'),
('24', '43'),
('47', '5'),
('29', '34'),
('1', '44'),
('12', '4'),
('6', '26'),
('9', '47'),
('37', '48'),
('15', '27'),
('48', '50'),
('25', '11'),
('34', '17'),
('8', '28'),
('11', '7'),
('20', '18'),
('22', '29'),
('13', '10'),
('16', '40'),
('10', '49'),
('49', '42'),
('28', '37'),
('33', '16'),
('27', '22'),
('17', '19'),
('30', '15'),
('36', '2'),
('14', '45'),
('31', '23'),
('46', '6'),
('45', '3'),
('33', '38'),
('11', '49'),
('50', '40'),
('6', '21'),
('44', '19'),
('47', '13'),
('22', '23'),
('37', '18'),
('24', '42'),
('36', '41'),
('5', '6'),
('9', '2'),
('38', '39'),
('30', '29'),
('16', '31'),
('17', '33'),
('7', '50'),
('43', '5'),
('15', '35'),
('26', '47'),
('27', '28'),
('29', '48'),
('19', '45'),
('10', '8'),
('28', '20'),
('45', '26'),
('3', '9'),
('20', '36'),
('31', '44'),
('49', '11'),
('25', '3'),
('14', '10'),
('39', '1'),
('32', '25'),
('34', '46'),
('13', '14'),
('12', '43'),
('1', '24'),
('23', '16'),
('8', '32'),
('4', '27'),
('21', '37'),
('48', '22'),
('42', '12'),
('41', '7'),
('35', '34'),
('18', '15'),
('2', '17'),
('40', '4'),
('46', '30'),
('34', '15'),
('50', '45'),
('41', '5'),
('4', '40'),
('42', '22'),
('29', '20'),
('17', '44'),
('15', '23'),
('37', '16'),
('13', '36'),
('30', '29'),
('7', '34'),
('20', '3'),
('8', '26'),
('31', '28'),
('18', '8'),
('21', '4'),
('44', '43'),
('10', '35'),
('24', '13'),
('19', '19'),
('11', '50'),
('48', '39'),
('26', '21'),
('25', '27'),
('6', '41'),
('36', '49'),
('1', '47'),
('45', '1'),
('12', '38'),
('3', '46'),
('40', '24'),
('16', '10'),
('32', '11'),
('28', '14'),
('39', '2'),
('35', '25'),
('43', '31'),
('38', '37'),
('33', '30'),
('46', '6'),
('22', '17'),
('5', '48'),
('47', '9'),
('2', '18'),
('27', '33'),
('9', '12'),
('23', '7'),
('49', '42'),
('14', '32'),
('22', '15'),
('25', '33'),
('14', '46'),
('23', '9'),
('42', '34'),
('9', '50'),
('8', '12'),
('35', '38'),
('16', '44'),
('32', '28'),
('47', '18'),
('44', '3'),
('4', '43'),
('3', '45'),
('45', '4'),
('7', '21'),
('18', '31'),
('29', '13'),
('19', '47'),
('43', '16'),
('38', '25'),
('37', '49'),
('41', '27'),
('11', '35'),
('40', '24'),
('20', '30'),
('34', '40'),
('48', '41'),
('13', '19'),
('21', '48'),
('36', '42'),
('27', '11'),
('46', '39'),
('15', '2'),
('30', '5'),
('26', '22'),
('17', '23'),
('5', '36'),
('6', '32'),
('33', '1'),
('24', '17'),
('49', '6'),
('50', '14'),
('12', '20'),
('39', '29'),
('2', '26'),
('1', '7'),
('31', '10'),
('10', '37'),
('28', '8');


INSERT INTO playlistCharts (ChartID, PlaylistID) VALUES
('19', '50'), ('27', '48'), ('10', '33'), ('37', '32'), ('23', '29'), ('40', '22'),
('2', '27'), ('5', '17'), ('30', '41'), ('47', '23'), ('21', '28'), ('39', '15'),
('3', '30'), ('38', '40'), ('32', '14'), ('16', '47'), ('12', '18'), ('13', '43'),
('8', '39'), ('18', '6'), ('9', '2'), ('48', '13'), ('28', '36'), ('41', '34'),
('25', '49'), ('49', '38'), ('34', '5'), ('35', '7'), ('15', '45'), ('44', '1'),
('6', '8'), ('20', '3'), ('11', '20'), ('50', '35'), ('14', '10'), ('45', '12'),
('24', '31'), ('31', '26'), ('29', '24'), ('33', '4'), ('46', '44'), ('42', '37'),
('43', '46'), ('4', '19'), ('7', '25'), ('17', '11'), ('26', '21'), ('1', '9'),
('22', '42'), ('36', '16'), ('43', '42'), ('31', '34'), ('34', '13'), ('35', '25'),
('32', '41'), ('4', '45'), ('42', '36'), ('5', '50'), ('14', '20'), ('33', '17'),
('23', '12'), ('28', '26'), ('8', '48'), ('7', '23'), ('11', '9'), ('37', '33'),
('40', '7'), ('45', '1'), ('20', '49'), ('26', '24'), ('50', '37'), ('22', '22'),
('44', '15'), ('9', '6'), ('3', '38'), ('17', '43'), ('10', '28'), ('39', '40'),
('25', '35'), ('27', '19'), ('21', '10'), ('6', '29'), ('49', '44'), ('41', '31'),
('48', '39'), ('24', '8'), ('30', '14'), ('15', '3'), ('1', '30'), ('13', '5'),
('38', '21'), ('18', '27'), ('2', '4'), ('46', '16'), ('16', '32'), ('36', '2'),
('47', '18'), ('29', '11'), ('12', '47'), ('19', '46'), ('8', '34'), ('41', '11'),
('18', '44'), ('37', '21'), ('30', '37'), ('33', '38'), ('24', '15'), ('4', '39'),
('17', '5'), ('34', '6'), ('5', '1'), ('45', '36'), ('50', '9'), ('11', '50'),
('12', '43'), ('31', '12'), ('47', '41'), ('46', '18'), ('10', '47'), ('2', '23'),
('13', '29'), ('32', '33'), ('28', '26'), ('9', '14'), ('42', '24'), ('38', '48'),
('15', '19'), ('36', '2'), ('22', '10'), ('25', '27'), ('1', '4'), ('3', '22'),
('7', '7'), ('20', '20'), ('19', '13'), ('39', '31'), ('29', '32'), ('35', '28'),
('14', '3'), ('16', '17'), ('49', '30'), ('27', '46'), ('26', '16'), ('43', '35'),
('48', '42'), ('40', '45'), ('23', '40'), ('44', '25'), ('6', '8'), ('21', '49'),
('18', '27'), ('5', '47'), ('35', '46'), ('25', '2'), ('46', '24'), ('48', '35'),
('29', '25'), ('32', '45'), ('34', '38'), ('26', '3'), ('41', '9'), ('19', '49'),
('13', '4'), ('2', '30'), ('20', '43'), ('1', '40'), ('31', '36'), ('45', '17'),
('27', '1'), ('36', '22'), ('39', '29'), ('38', '14'), ('8', '8'), ('4', '5'),
('24', '34'), ('12', '41'), ('23', '33'), ('50', '6'), ('37', '50'), ('15', '13'),
('42', '39'), ('28', '15'), ('17', '42'), ('10', '23'), ('43', '11'), ('14', '48'),
('47', '18'), ('30', '37'), ('9', '26'), ('3', '20'), ('22', '28'), ('11', '32'),
('33', '44'), ('49', '19'), ('7', '31'), ('16', '12'), ('40', '7'), ('6', '21'),
('44', '10'), ('21', '16'), ('26', '44'), ('9', '16'), ('27', '2'), ('24', '23'),
('15', '38'), ('13', '30'), ('2', '50'), ('12', '12'), ('47', '32'), ('37', '41'),
('29', '31'), ('20', '11'), ('44', '9'), ('1', '43'), ('28', '39'), ('19', '36'),
('35', '1'), ('39', '49'), ('7', '17'), ('4', '18'), ('43', '22'), ('30', '5'),
('18', '24'), ('10', '8'), ('40', '47'), ('36', '40'), ('38', '3'), ('46', '27'),
('42', '25'), ('6', '19'), ('14', '48'), ('22', '45'), ('32', '10'), ('50', '7'),
('5', '29'), ('3', '46'), ('45', '13'), ('34', '42'), ('31', '6'), ('23', '15'),
('25', '26'), ('33', '33'), ('41', '35'), ('16', '37');


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


/* User 2 */

/* As a user, I want to be able to create sets from different playlists and gain inspiration to spice up my own sets using the different storage organization methods */
INSERT INTO playlistSong (OrderNum, MusicFileID, PlaylistID)
VALUES ('6', '14','39');

/* As a user, I want to be able to properly have my music as an artist represented for my songs */
INSERT INTO artist
VALUES('33', 'Dante Mirage', 'House');

INSERT INTO musicFile (Title, Artist, Genre, `Key`, Tempo, ReleaseStatus, UserID) VALUES
('Darude Sandstorms', 'Dante Mirage', 'House', 1, 120, TRUE, 1);

/* As a user, I want a software that can be used quickly during live sets to search for music I have already cataloged as well as new music that the crowd may like that comes to mind during the set or they ask for. This way I can cater to the crowd effectively day in and day out. */
SELECT p.Name AS PlaylistName, mf.Title AS TrackTitle
FROM playlist p
JOIN playlistSong pls ON p.PlaylistID = pls.PlaylistID
JOIN musicFile mf on pls.MusicFileID = mf.MusicFileID;

/* As a user, I want to be able to add the trendy songs that are the most popular into my own catalog in order to implement them into my sets every week without having to take out too much time 2.2 */
SELECT c.name AS ChartName, c.Description AS ChartDescription, p.Name AS PlaylistName
FROM charts c
JOIN playlist p ON p.PlaylistID = c.ChartID;

/* Sort music files by artist */
SELECT * FROM musicFile WHERE UserID = 3 ORDER BY Artist;

/* Sort music files by genre */
SELECT * FROM musicFile WHERE UserID = 3 ORDER BY Genre;

/* Sort music files by BPM */
SELECT * FROM musicFile WHERE UserID = 3 ORDER BY Tempo;

/* As a user, I would like to be able to search and filter through his collection of music files. */
/* Search music files by title */
SELECT * FROM musicFile WHERE UserID = 1 AND Title LIKE '%You are my sunshine%';

/* Search music files by artist */
SELECT * FROM musicFile WHERE UserID = 1 AND Artist LIKE '%LeBonBon%';

/* Search music files by genre */
SELECT * FROM musicFile WHERE UserID = 1 AND Genre LIKE '%Happy%';

SELECT * FROM musicFile WHERE UserID = 1 AND `Key` = 1;



SELECT * FROM playlist JOIN playlistOwnership pO on playlist.PlaylistID = pO.PlaylistID join users u on pO.UserID = u.UserID;

SELECT UserID From users where FullName='Giffy Melwall';

SELECT * FROM musicFile WHERE UserID = 1;

SELECT * FROM playlist WHERE PlaylistID = 72;