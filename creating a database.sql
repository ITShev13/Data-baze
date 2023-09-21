-- создание таблицы Музыкальные жанры
CREATE TABLE IF NOT EXISTS Musical_Genres (
	id SERIAL   PRIMARY KEY,
	name_Genre  VARCHAR(70) NOT NULL UNIQUE,
	description TEXT
);


-- создание таблицы Исполнители
CREATE TABLE IF NOT EXISTS Performers (
	id SERIAL      PRIMARY KEY,
	name_Performer VARCHAR(100) NOT NULL	
);


-- создание связи многие ко многим (между Музыкальными жанрами и Исполнителями)
CREATE TABLE IF NOT EXISTS Ganres_Performers (
	Genre_id     INTEGER REFERENCES Musical_Genres(id),
	Performer_id INTEGER REFERENCES Performers(id),
	             CONSTRAINT pk_Ganres_Performers PRIMARY KEY (Genre_id, Performer_id)
);


-- создание таблицы Альбомы
CREATE TABLE IF NOT EXISTS Albums (
	id SERIAL       PRIMARY KEY,
	name_Albums     VARCHAR(70) NOT NULL,
	year_of_release DATE NOT NULL
					-- ограничение на дату выхода альбома
					CONSTRAINT check_year_of_release 
					CHECK (year_of_release > '1800.01.01'
						   AND year_of_release <= NOW())
);


-- создание связи многие ко многим (между Исполнительями и Альбомами)
CREATE TABLE IF NOT EXISTS Performers_Albums (
	Performer_id INTEGER REFERENCES Performers(id),
	Albums_id    INTEGER REFERENCES Albums(id),
	             CONSTRAINT pk_Performers_Albums 
	             PRIMARY KEY (Performer_id, Albums_id)
);


-- создание таблицы Треки
-- со связью один ко многим с Альбомы
CREATE TABLE IF NOT EXISTS Tracks (
	id SERIAL      PRIMARY KEY,
	albums_id      INTEGER NOT NULL REFERENCES Albums(id),
	name_Treck 	   VARCHAR(100) NOT NULL,
	Treck_duration INT NOT NULL
				   -- ограничение на продолжительность трека (не более 1 дня)
				   CONSTRAINT check_Treck_duration 
				   CHECK (Treck_duration <= 86400)
);



-- создаем таблицу Сборник (со связью один ко многим с Треками)
CREATE TABLE IF NOT EXISTS Сollection (
	id SERIAL 			 PRIMARY KEY,
	name_Collection 	 VARCHAR(100) NOT NULL,
	year_of_release_coll DATE NOT NULL
						 CONSTRAINT check_year_of_release_coll 
						 CHECK (year_of_release_coll > '1800.01.01'
						 	    AND year_of_release_coll <= NOW())
);


-- создание связи многие ко многим (между Треками и Сборниками)
CREATE TABLE IF NOT EXISTS Tracks_Сollection (
	Track_id 		  INTEGER REFERENCES Tracks(id),
	Сollections_id    INTEGER REFERENCES Сollection(id),
	                  CONSTRAINT pk_Tracks_Сollection 
	                  PRIMARY KEY (Track_id, Сollections_id)
);



-- Заполннение таблиц

-- заполняем таблицу Исполнители
INSERT INTO Performers (name_Performer)
VALUES 
	('Би-2'),
	('Слот'),
	('Руки вверх'),
	('B.B. King'),
	('Баста');


-- заполняем таблицу Музыкальные жанры
INSERT INTO Musical_Genres (name_Genre,	description)
VALUES 
	('Рок', 'жанр музыки, характеризующийся ярко выраженным ритмом'),
	('Поп', 'направление современной музыки, вид современной массовой культуры'),
	('Блюз', 'вид афроамериканской светской музыки'),
	('Рэп', 'ритмичный речитатив, обычно читающийся под музыку с тяжёлым битом');


-- заполяем таблицу Альбомы

-- Альбомы исполнителя Би-2
INSERT INTO Albums (name_Albums, year_of_release)
VALUES
	('Горизонт событий', '2018.09.28'),
	('Философский камень', '2019.05.07'),
	('Муза', '2020.02.02');

-- Альбомы исполнителя Слот
INSERT INTO Albums (name_Albums, year_of_release)
VALUES
	('Стадия гнева', '2020.09.13'),
	('200 кВт', '2018.03.25'),
	('На марс', '2018.06.02'),
	('Инстинкт выживания', '2021.02.26');


-- Альбомы исполнителя B.B. King
INSERT INTO Albums (name_Albums, year_of_release)
VALUES
	('Christmas Celebration', '2020.12.16'),
	('You Dont Love Me', '2020.04.19'),
	('Angry Man', '2019.08.21');

-- Альбомы исполнителя Руки вверх
INSERT INTO Albums (name_Albums, year_of_release)
VALUES
	('Сделай погромче!', '1998.08.25'),
	('Маленькие девочки', '2018.02.12'),
	('Здравствуй, это я', '2020.07.09');

-- Альбомы исполнителя Баста
INSERT INTO Albums (name_Albums, year_of_release)
VALUES
	('Осень', '2022.09.22'),
	('Страшно так жить', '2019.05.05'),
	('Музыка, будь со мной', '2019.11.28');


-- заполняем таблицу треки
INSERT INTO Tracks (albums_id, name_Treck,	Treck_duration)
VALUES
	-- треки группы Би-2
	(1, 'Летчик', '351'),
	(2, 'Мой рок-н-ролл', '405'),
	(3, 'Снайпер', '202'),
	
	-- треки группы Слот
	(4, 'Бой', '240'),
	(5, 'Стадия гнева', '248'),
	(6, 'Апокалипсис', '264'),
	(7, 'Круги на воде','273'),
	
	-- треки группы B.B. King
	(8, 'Sweet little angel', '178'),
	(9, 'My blind love', '211'),
	(10, 'Keep it comin', '266'),
	
	-- треки группы Руки вверх
	(11, 'Крошка моя', '250'),
	(12, 'Он тебя целует', '243'),
	(13, '18 мне уже', '247'),
	
	-- треки группы Баста
	(14, 'Сансара', '371'),
	(15, 'Жить', '353'),
	(16, 'Будь со мной', '379'),
	(14, 'Моя игра', '270');

-- заполняем таблицу Сборники
INSERT INTO Сollection (name_Collection, year_of_release_coll)
VALUES
	('Русский рок', '2019.07.03'),
	('О любви', '2020.01.20'),
	('Утренняя','2017.05.13'),
	('Вечеринка','2018.10.25');

-- заполняем таблицу-связь Музыкальные жанры и Исполнители
INSERT INTO Ganres_Performers (Genre_id, Performer_id)
VALUES 
	(1, 1),
	(1, 2),
	(2, 3),
	(3, 4),
	(4, 5);

-- заполняем таблицу-связь Исполнители и Альбомы
INSERT INTO Performers_Albums (Performer_id, Albums_id) 
VALUES
	(1, 1),
	(1, 2),
	(1, 3),
	(2, 4),
	(2, 5),
	(2, 6),
	(2, 7),
	(4, 8),
	(4, 9),
	(4, 10),
	(3, 11),
	(3, 12),
	(3, 13),
	(5, 14),
	(5, 15),
	(5, 16),
	(5, 1),
	(1, 6);
	

-- заполняем таблицу-связь Треки и Сборники
INSERT INTO Tracks_Сollection (Track_id, Сollections_id)
VALUES
	(1, 1),
	(2, 1),
	(3, 1),
	(4, 1),
	(5, 1),
	(6, 1),
	(7, 1),
	(2, 2),
	(9, 2),
	(11, 2),
	(12, 2),
	(1, 3),
	(3, 3),
	(8, 3),
	(9, 3),
	(10, 3),
	(2, 4),
	(4, 4),
	(5, 4),
	(6, 4),
	(7, 4),
	(12, 4),
	(11, 4),
	(13, 4),
	(14, 2),
	(16, 2);