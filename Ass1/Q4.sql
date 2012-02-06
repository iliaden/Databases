--1) all web-pages with at least one "good" evaluation

UNIQUE (SELECT URL FROM Evaluation WHERE grade = 'good');

--2) all web-pages with grade "good" or "ok"
UNIQUE (SELECT URL FROM Evaluation WHERE grade = 'good' OR grade = 'ok');

--3)all web-pages linked by the topic 'computer science'

SELECT URL FROM Links WHERE topic-id  IN (SELECT topic-id FROM Topics WHERE name = 'computer science' ); --do I need to traverse the topics???

--4) all web-pages that are linked by ALL top-level topics

SELECT URL FROM Links WHERE topic-id IN (SELECT topic-id FROM Topics WHERE perent-id IS NULL );

--5) all web-pages linked by both 'computer science' and 'database systems'
SELECT URL FROM Links WHERE topic-id IN (SELECT topic-id FROM Topics WHERE name = 'computer science' ) AND topic-id IN (SELECT topic-id FROM Topics WHERE name = 'database systems' );

--6) all web-pages ranked "good" OR linked by Computer Science

UNIQUE( SELECT URL FROM Links WHERE topic-id IN (SELECT topic-id FROM Topics WHERE name = 'computer science' ) UNION ( UNIQUE (SELECT URL FROM Evaluation WHERE grade = 'good') ) );

--7) all web-pages with names linked by topics sharing a name with the web-page

UNIQUE (SELECT Topics.name, Web-Pages.URL FROM Topics INNER JOIN Links ON Links.topic-id = Topics.topic-id INNER JOIN Web-Pages ON Web-Pages.URL = Links.URL AND Web-Pages.title = Topics.name);


--8) names of URLs that are childre of top-level topics

SELECT title FROM Web-Pages WHERE URL IN (SELECT URL FROM Links WHERE topic-id IN (SELECT topic-id FROM Topics WHERE parent-id IN ( SELECT topic-id FROM Topics WHERE parent-id IS NULL ) ) );


--9) emails of all evaluators with "good" ranking
UNIQUE (SELECT email from Evaluation WHERE grade = 'good');
