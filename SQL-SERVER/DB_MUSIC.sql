CREATE DATABASE DB_MUSIC

USE DB_MUSIC

-- USERS 

CREATE TABLE Users(
		UserId INT NOT NULL IDENTITY(1,1)
	,	FirstName VARCHAR(30) NOT NULL
	,	LastName VARCHAR(30) NOT NULL
	,	UserName VARCHAR(30) NOT NULL
	,	Email VARCHAR(255) NOT NULL CONSTRAINT UQ_Users_Email UNIQUE CONSTRAINT CHK_Users_Email CHECK(Email LIKE '%_@__%.__%')
	,	Password VARCHAR(20) NOT NULL 
	,	Active BIT CONSTRAINT DF_Users_Active DEFAULT 1
	,	Premium BIT CONSTRAINT DF_Users_Premium DEFAULT 0
	,	CONSTRAINT PK_Users_UserID PRIMARY KEY(UserID) 	
)

-- PROFILE

CREATE TABLE Profile(
		ProfileID INT NOT NULL IDENTITY(1,1)
	,	UserID INT NOT NULL 
	,	Bio TEXT
	,	Picture VARCHAR(30)
	,	Gender CHAR(1) 
	,	CONSTRAINT PK_Pofile_ProfileID PRIMARY KEY(ProfileID) 
	,	CONSTRAINT FK_Users_Profile FOREIGN KEY(UserID) REFERENCES Users(UserID)
	,	CONSTRAINT UQ_Profile_UserID UNIQUE(UserID)
	,	CONSTRAINT CHK_Profile_Gender CHECK(Gender IN('M','F','O'))
)

-- ARTISTS

CREATE TABLE Artists(
		ArtistId INT NOT NULL IDENTITY(1,1)
	,	UserID INT NOT NULL
	,	Name VARCHAR(30) NOT NULL
	,	Active BIT CONSTRAINT DF_Artists_Active DEFAULT 1
	,	CONSTRAINT PK_Artists_ArtistID PRIMARY KEY(ArtistId)
	,	CONSTRAINT FK_Users_Artists FOREIGN KEY(UserID) REFERENCES Users(UserID)
	,	CONSTRAINT UQ_Artists_UserID UNIQUE(UserID)		
)

--ALBUMS

CREATE TABLE Albums(
		AlbumID INT NOT NULL IDENTITY(1,1)
	,	ArtistId INT NOT NULL
	,	Name VARCHAR(30) NOT NULL
	,	Picture VARCHAR(30) NOT NULL
	,	Premium BIT CONSTRAINT DF_Albums_Premium DEFAULT 0
	,	Active BIT CONSTRAINT DF_Albums_Active DEFAULT 1
	,	CONSTRAINT PK_Albums_AlbumID PRIMARY KEY(AlbumID)
	,	CONSTRAINT FK_Artists_Albums FOREIGN KEY(ArtistId) REFERENCES Artists(ArtistId)
)
	
--GENRES

CREATE TABLE Genres(
		GenreId INT NOT NULL IDENTITY(1,1)
	,	Genre VARCHAR(30) NOT NULL		
	,	CONSTRAINT PK_Genres_GenresId PRIMARY KEY(GenreId) 	
)

-- SONGS

CREATE TABLE Songs(
		SongID INT NOT NULL IDENTITY(1,1)
	,	AlbumID INT NOT NULL
	,	GenreId INT NOT NULL
	,	Name VARCHAR(30) NOT NULL
	,	SongFile VARCHAR(30) NOT NULL
	,	Active BIT CONSTRAINT DF_Songs_Active DEFAULT 1
	,	CONSTRAINT PK_Songs_SongID PRIMARY KEY(SongID)
	,	CONSTRAINT FK_Albums_Songs FOREIGN KEY(AlbumID) REFERENCES Albums(AlbumID)
	,	CONSTRAINT FK_Genres_Songs FOREIGN KEY(GenreId) REFERENCES Genres(GenreId)
)

-- PODCAST

CREATE TABLE Podcasts(
		PodcastID INT NOT NULL IDENTITY(1,1)
	,	AlbumID INT NOT NULL
	,	GenreId INT NOT NULL
	,	Name VARCHAR(30) NOT NULL
	,	PodcastFile VARCHAR(30) NOT NULL
	,	Active BIT CONSTRAINT DF_Podcasts_Active DEFAULT 1
	,	CONSTRAINT PK_Podcasts_PodcastID PRIMARY KEY(PodcastID)
	,	CONSTRAINT FK_Albums_Podcasts FOREIGN KEY(AlbumID) REFERENCES Albums(AlbumID)
	,	CONSTRAINT FK_Genres_Podcasts FOREIGN KEY(GenreId) REFERENCES Genres(GenreId)
)

-- LIKES  --- 

CREATE TABLE SongLike(
		UserId INT NOT NULL
	,	SongID INT NOT NULL
	,	CONSTRAINT FK_Users_SongLike FOREIGN KEY(UserID) REFERENCES Users(UserID)
	,	CONSTRAINT FK_Songs_SongLike FOREIGN KEY(SongID) REFERENCES Songs(SongID)
	,	CONSTRAINT PK_Songlike PRIMARY KEY(UserId, SongID)

)

CREATE TABLE PodcastLike(
		UserId INT NOT NULL
	,	PodcastID INT NOT NULL
	,	CONSTRAINT FK_Users_PodcastLike FOREIGN KEY(UserID) REFERENCES Users(UserID)
	,	CONSTRAINT FK_Podcasts_PodcastLike FOREIGN KEY(PodcastID) REFERENCES Podcasts(PodcastID)
	,	CONSTRAINT PK_PodcastLike PRIMARY KEY(UserId, PodcastID)

)

CREATE TABLE AlbumLike(
		UserId INT NOT NULL
	,	AlbumID INT NOT NULL
	,	CONSTRAINT FK_Users_AlbumLike FOREIGN KEY(UserID) REFERENCES Users(UserID)
	,	CONSTRAINT FK_Albums_AlbumLike FOREIGN KEY(AlbumID) REFERENCES Albums(AlbumID)
	,	CONSTRAINT PK_AlbumLike PRIMARY KEY(UserId, AlbumID)

)

-- PLAYLIST

CREATE TABLE Playlists(
		PlaylistID INT NOT NULL IDENTITY(1,1)
	,	UserID INT NOT NULL
	,	Title VARCHAR(30) NOT NULL
	,	CONSTRAINT PK_Playlists_PlaylistID PRIMARY KEY(PlaylistID)
	,	CONSTRAINT FK_Users_Playlists FOREIGN KEY(UserID) REFERENCES Users(UserID)

)

CREATE TABLE PlaylistSongs(
		PlaylistID INT NOT NULL
	,	SongID INT NOT NULL
	,	CONSTRAINT FK_Playlists_PlaylistSongs FOREIGN KEY(PlaylistID) REFERENCES Playlists(PlaylistID)
	,	CONSTRAINT FK_Songs_PlaylistSongs FOREIGN KEY(SongID) REFERENCES Songs(SongID)
	,	CONSTRAINT PK_PlaylistSongs PRIMARY KEY(PlaylistID, SongID)
)

SELECT * FROM SYS.tables





