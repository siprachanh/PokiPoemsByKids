--1. What grades are stored in the database?

SELECT * 
FROM grade;

--2. What emotions may be associated with a poem?
SELECT * 
FROM emotion;

--3.How many poems are in the database?
SELECT COUNT(Id) AS 'Number of Poems'
FROM poem;

--4. Sort authors alphabetically by name. What are the 
--names of the top 76 authors?
SELECT TOP 76 *
FROM Author
ORDER BY Name;

SELECT TOP 76 Name
FROM Author
ORDER BY Name;


--5. Starting with the above query, add the grade of each of the authors.

SELECT TOP 76 *
FROM Author a 
LEFT JOIN Grade g ON g.Id = a.GradeId
ORDER BY a.Name;


--6. Starting with the above query, add the recorded gender of each of the authors.

SELECT TOP 76 *
FROM Author a 
LEFT JOIN Grade g ON g.Id = a.GradeId
LEFT JOIN Gender gen ON gen.Id = a.GenderId
ORDER BY a.Name;

--7. What is the total number of words in all poems in the database?
SELECT SUM(WordCount) AS 'Number of Words in All Poems'
FROM poem;


--8. Which poem has the fewest characters?
SELECT *
FROM Poem
ORDER BY CharCount;

SELECT TOP 1 *
FROM Poem
ORDER BY CharCount;

--9. How many authors are in the third grade?
SELECT *
FROM Author a
LEFT JOIN Grade g ON g.Id = a.GradeId
WHERE g.Name = '3rd Grade';

SELECT COUNT(a.Id) AS 'Number of 3rd Graders'
FROM Author a
LEFT JOIN Grade g ON g.Id = a.GradeId
WHERE g.Name = '3rd Grade';

--10. How many total authors are in the first through third grades?
 SELECT *
 FROM Author a
 LEFT JOIN Grade g ON g.Id = a.GradeId
 WHERE g.Name = '3rd Grade' OR g.Name = '1st Grade' OR g.Name = '2nd Grade';

--11. What is the total number of poems written by fourth graders?
SELECT COUNT (p.Id) AS FourthGradePoems
FROM Poem p
LEFT JOIN Author a ON a.Id = p.AuthorId
LEFT JOIN Grade g ON g.Id = a.GradeId 
WHERE g.Name = '4th Grade';


--12. How many poems are there per grade?

SELECT COUNT (p.Id) AS 'Poems By Grade', g.Name
FROM Poem p
LEFT JOIN Author a ON a.Id = p.AuthorId
LEFT JOIN Grade g ON g.Id = a.GradeId 
GROUP BY g.Id, g.Name;

--13. How many authors are in each grade? (Order your results by grade starting with 1st Grade)
SELECT COUNT (a.Id) as 'Authors By Grade', g.Name
FROM Author a
LEFT JOIN Grade g ON g.Id = a.GradeId
GROUP BY g.Name, g.Id
ORDER BY g.Id;


--14. What is the title of the poem that has the most words?
SELECT TOP 1 Title
FROM Poem p
ORDER BY p.WordCount DESC;

--15. Which author(s) have the most poems? (Remember authors can have the same name.)
SELECT DISTINCT Author.Name, Author.Id,
COUNT(Poem.AuthorId) AS 'Poems Per Author'
FROM Poem 
LEFT JOIN Author ON Poem.AuthorId = Author.Id 
GROUP BY Author.Id, Author.Name
ORDER BY'Poems Per Author' DESC;

--16. How many poems have an emotion of sadness?
SELECT COUNT(Poem.Id) AS 'Number of Sad Poems'
FROM Poem
LEFT JOIN PoemEmotion ON PoemEmotion.PoemId = Poem.Id
LEFT JOIN Emotion ON Emotion.Id = PoemEmotion.EmotionId
WHERE Emotion.Name='Sadness';

--17. How many poems are not associated with any emotion?
SELECT COUNT(Poem.Id) AS 'Number of Sad Poems'
FROM Poem
LEFT JOIN PoemEmotion ON PoemEmotion.PoemId = Poem.Id
LEFT JOIN Emotion ON Emotion.Id = PoemEmotion.EmotionId
WHERE Emotion.Name IS NULL;

--18. Which emotion is associated with the least number of poems?
SELECT COUNT(p.Id) AS 'Poems By Emotion', e.Name
FROM Poem p
LEFT JOIN PoemEmotion pe ON pe.PoemId = p.Id
LEFT JOIN Emotion e ON e.Id = pe.EmotionId
GROUP BY e.Id, e.Name
ORDER BY 'Poems By Emotion';

--19. Which grade has the largest number of poems with an emotion of joy?
SELECT COUNT(p.Id) AS 'Joyful Poems by Grade', g.Name, e.Name
FROM Poem p
LEFT JOIN PoemEmotion pe ON pe.PoemId = p.Id
LEFT JOIN Emotion e ON e.Id = pe.EmotionId
LEFT JOIN Author a ON a.Id = p.AuthorId
LEFT JOIN Grade g ON g.Id = a.GradeId
GROUP BY g.Id, g.Name, e.Name
HAVING e.Name = 'Joy' 
ORDER BY 'Joyful Poems by Grade' DESC;


--20. Which gender has the least number of poems with an emotion of fear?
SELECT COUNT(p.Id) AS 'Least Number', g.Name, e.Name
FROM Poem p
LEFT JOIN PoemEmotion pe ON pe.PoemId = p.Id
LEFT JOIN Emotion e ON e.Id = pe.EmotionId
LEFT JOIN Author a ON a.Id = p.AuthorId
LEFT JOIN Gender g ON g.Id = a.GenderId
GROUP BY g.Id, g.Name, e.Name
HAVING e.Name = 'Fear' 
ORDER BY 'Least Number';

