
-- first option - E1 references E2

add table E1
(
    INTEGER k1 NOT NULL AUTOINCREMENT,
    INTEGER k2 NOT NULL,
    FOREIGN KEY (k2) REFERENCES E2(k2),
    UNIQUE(k2)
    PRIMARY KEY (k1)
);
add table E2
(
    INTEGER k2 NOT NULL AUTOINCREMENT,
    PRIMARY KEY (k2)
);  

--second option: E2 references E1
add table E1
(
    INTEGER k1 NOT NULL AUTOINCREMENT,
    PRIMARY KEY (k1)
);
add table E2
(
    INTEGER k2 NOT NULL AUTOINCREMENT,
    INTEGER k1 NOT NULL,
    FOREIGN KEY (k1) REFERENCES E1(k1),
    UNIQUE(k1)
    PRIMARY KEY (k2)
);  

--third option = mutual cross-reference
add table E1
(
    INTEGER k1 NOT NULL AUTOINCREMENT,
    INTEGER k2 NOT NULL,
    FOREIGN KEY (k2) REFERENCES E2(k2),
    UNIQUE(k2)
    PRIMARY KEY (k1)
);
add table E2
(
    INTEGER k2 NOT NULL AUTOINCREMENT,
    INTEGER k1 NOT NULL,
    FOREIGN KEY (k1) REFERENCES E1(k1),
    UNIQUE(k1)
    PRIMARY KEY (k2)
);  

--fourth option - shared PK
--FIXME: actually do it...

add table E1
(
    INTEGER k1 NOT NULL AUTOINCREMENT,
    PRIMARY KEY (k1)
);
add table E2
(
    INTEGER k2 NOT NULL AUTOINCREMENT,
    PRIMARY KEY (k2)
);  
