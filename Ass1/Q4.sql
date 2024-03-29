--1) all web-pages with at least one "good" evaluation

∏ URL (σ grade = 'good' (Evaluation) )
UNIQUE (SELECT URL FROM Evaluation WHERE grade = 'good');

--2) all web-pages with grade "good" or "ok"

∏ URL ( (σ grade = 'good' (Evaluation) ) ∪ (σ grade = 'ok' (Evaluation) )

or

∏ URL (σ grade = 'good' V grade = 'ok' (Evaluation) ) 
UNIQUE (SELECT URL FROM Evaluation WHERE grade = 'good' OR grade = 'ok');

--3)all web-pages linked by the topic 'computer science'
∏ URL ( σ name='computer science' ( Topics ⋈  Links ) )
SELECT URL FROM Links WHERE topic-id  IN (SELECT topic-id FROM Topics WHERE name = 'computer science' ); --do I need to traverse the topics???

--4) all web-pages that are linked by ALL top-level topics
∏ URL ( σ parent-id = NULL ( Topics ⋈  Links ) )
SELECT URL FROM Links WHERE topic-id IN (SELECT topic-id FROM Topics WHERE parent-id IS NULL );

--5) all web-pages linked by both 'computer science' and 'database systems'
∏ URL ( ( σ name='computer science' ( Topics ⋈  Links ) ) ∪ ( σ name='database systems' ( Topics ⋈  Links ) ) )

or
∏ URL ( σ name='computer science' V name='database systems' ( Topics ⋈  Links ) ) 

SELECT URL FROM Links WHERE topic-id IN (SELECT topic-id FROM Topics WHERE name = 'computer science' ) AND topic-id IN (SELECT topic-id FROM Topics WHERE name = 'database systems' );

--6) all web-pages ranked "good" OR linked by Computer Science

∏ URL ( ( σ name='computer science' ( (Topics ⋈  Links) ⋈ Evaluation  ) ) ∪ ( σ grade='good' ( (Topics ⋈  Links) ⋈ Evaluation  ) ) )
or

∏ URL ( σ name='computer science' V grade='good' ( (Topics ⋈  Links) ⋈ Evaluation ) ) 

UNIQUE( SELECT URL FROM Links WHERE topic-id IN (SELECT topic-id FROM Topics WHERE name = 'computer science' ) UNION ( UNIQUE (SELECT URL FROM Evaluation WHERE grade = 'good') ) );

--7) all web-pages with names linked by topics sharing a name with the web-page

∏ name, URL ( σ name=title ( (Topics ⋈  Links) ⋈ Web-Pages ) ) 

UNIQUE (SELECT Topics.name, Web-Pages.URL FROM Topics INNER JOIN Links ON Links.topic-id = Topics.topic-id INNER JOIN Web-Pages ON Web-Pages.URL = Links.URL AND Web-Pages.title = Topics.name);


--8) names of URLs that are children of top-level topics

∏ title ( σ parent-id = ( σ parent-id = NULL ( (Topics ⋈  Links) ⋈ Web-Pages ) )  ( (Topics ⋈  Links) ⋈ Web-Pages )

SELECT title FROM Web-Pages WHERE URL IN (SELECT URL FROM Links WHERE topic-id IN (SELECT topic-id FROM Topics WHERE parent-id IN ( SELECT topic-id FROM Topics WHERE parent-id IS NULL ) ) );


--9) emails of all evaluators with "good" ranking
∏ email ( σ grade='good' (Evaluation) )
UNIQUE (SELECT email from Evaluation WHERE grade = 'good');
