-- Задание 2
-- 2.1 Название и продолжительность самого длительного трека.
SELECT name_Treck, Treck_duration FROM tracks
WHERE Treck_duration = (SELECT MAX(Treck_duration) FROM tracks);

-- 2.2 Название треков, продолжительность которых не менее 3,5 минут.
SELECT name_Treck FROM tracks
WHERE treck_duration >= 210;

-- 2.3 Названия сборников, вышедших в период с 2018 по 2020 год включительно.
SELECT name_Collection FROM Сollection
WHERE year_of_release_coll >= '2018.01.01' AND year_of_release_coll <= '2020.12.31';

-- 2.4 Исполнители, чьё имя состоит из одного слова.
SELECT name_Performer FROM performers
WHERE name_Performer NOT LIKE '% %';

-- 2.5 Название треков, которые содержат слово «мой» или «my».
SELECT name_Treck FROM	Tracks
WHERE name_treck LIKE '%Мой%' OR name_treck LIKE '%My%';


-- Задание 3
-- 3.1 Количество исполнителей в каждом жанре.
SELECT name_Genre, count(name_Performer) FROM Musical_Genres mg
LEFT JOIN Ganres_Performers gp ON gp.genre_id = mg.id 
LEFT JOIN Performers p ON gp.performer_id = p.id
GROUP BY mg.name_genre
ORDER BY count(p.id) DESC;

-- 3.2 Количество треков, вошедших в альбомы 2019–2020 годов.
SELECT count(name_Treck), year_of_release FROM albums a
LEFT JOIN Tracks t ON a.id  = t.id  
WHERE (year_of_release >= '2019.01.01') AND (year_of_release <= '2020.12.31')
GROUP BY year_of_release;
 
-- 3.3 Средняя продолжительность треков по каждому альбому.
SELECT AVG(Treck_duration), name_Albums FROM tracks t
LEFT JOIN albums a ON t.albums_id = a.id
GROUP BY name_Albums
ORDER BY AVG(Treck_duration) DESC;

-- 3.4 Все исполнители, которые не выпустили альбомы в 2020 году.
SELECT DISTINCT name_Performer FROM Performers
WHERE name_Performer NOT IN (
							 SELECT name_Performer FROM Performers p
							 LEFT JOIN Performers_Albums pa ON p.id = pa.Performer_id
							 LEFT JOIN Albums a ON pa.Albums_id = a.id
							 WHERE year_of_release BETWEEN  '2020.01.01' AND '2020.12.31'
							);
						
-- 3.5 Названия сборников, в которых присутствует конкретный исполнитель (выберите его сами).
SELECT name_Collection FROM Сollection c
LEFT JOIN Tracks_Сollection tc ON c.id = tc.Сollections_id
LEFT JOIN Tracks t ON tc.Track_id = t.id
LEFT JOIN Performers_Albums pa ON t.albums_id = pa.albums_id
LEFT JOIN Performers p ON pa.Performer_id = p.id
WHERE name_Performer LIKE '%Слот%'
GROUP BY name_Collection;


-- Задание 4
-- 4.1 Названия альбомов, в которых присутствуют исполнители более чем одного жанра.
SELECT name_Albums FROM Albums a
LEFT JOIN Performers_Albums pa ON a.id = pa.Albums_id
LEFT JOIN Performers p ON pa.Performer_id = p.id
LEFT JOIN Ganres_Performers gp ON p.id = gp.Performer_id
LEFT JOIN Musical_Genres mg ON gp.Genre_id = mg.id
GROUP BY name_Albums
HAVING count(DISTINCT name_Genre) > 1;


-- 4.2 Наименования треков, которые не входят в сборники.
SELECT name_Treck FROM tracks
WHERE name_Treck NOT IN (
						SELECT name_Treck FROM Tracks_Сollection tc
						LEFT JOIN tracks t ON  tc.Track_id = t.id
						LEFT JOIN Сollection c ON tc.Сollections_id = c.id
						);
					
-- 4.3 Исполнитель или исполнители, написавшие самый короткий по продолжительности трек, — теоретически таких треков может быть несколько.
SELECT name_Performer, name_Treck FROM Performers p
LEFT JOIN Performers_Albums pa ON p.id = pa.Performer_id
LEFT JOIN Albums a ON pa.Albums_id = a.id
LEFT JOIN tracks t ON a.id =t.Albums_id
WHERE Treck_duration = (SELECT min(Treck_duration) FROM tracks)
GROUP BY name_Performer, name_Treck;

-- 4.4 Названия альбомов, содержащих наименьшее количество треков.
SELECT name_Albums, count(name_Treck) FROM Albums a
LEFT JOIN Tracks t ON a.id = t.albums_id
WHERE t.albums_id IN (
					  SELECT albums_id FROM Tracks
					  GROUP	BY albums_id
					  HAVING count(id) = (
					  					 SELECT count(id) FROM Tracks
					  					 GROUP BY albums_id
					  					 ORDER BY count
					  					 LIMIT 1
					  					 ) 
					  )
GROUP BY name_Albums;


