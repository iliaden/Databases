CREATE TABLE Participants
(
    INTEGER unique_key NOT NULL AUTOINCRMENT,
    VARCHAR(20) first_name NOT NULL,
    VARCHAR(20) last_name NOT NULL,
    INTEGER address NOT NULL,
    FOREIGN KEY address REFERENCES Address(unique_key),
    PRIMARY KEY (unique_key)
);

CREATE TABLE Trainers
(
    INTEGER unique_key NOT NULL AUTOINCRMENT,
    VARCHAR(20) first_name NOT NULL,
    VARCHAR(20) last_name NOT NULL,
    INTEGER hourly_wage NOT NULL,
    INTEGER address NOT NULL,
    FOREIGN KEY address REFERENCES Address(unique_key),
    PRIMARY KEY (unique_key)
);

CREATE TABLE Address
(
    INTEGER unique_key NOT NULL AUTOINCREMENT,
    VARCHAR(20) street_name NOT NULL,
    VARCHAR(10) street_number NOT NULL, --so 12A can work
    VARCHAR(10) appartment,
    VARCHAR(6) postal_code NOT NULL,
    VARCHAR(20) province NOT NULL,
    VARCHAR(20) country NOT NULL,  
    PRIMARY KEY (unique_key),
    UNIQUE(street_name,street_number, appartment, postal_code, country) --sufficient uniqueness conditions

);

CREATE TABLE Program
(
    INTEGER unique_key NOT NULL AUTOINCREMENT,
    VARCHAR(20) name NOT NULL,
    INTEGER max_participant_count NOT NULL,
    INTEGER cost NOT NULL,
    PRIMARY KEY (unique_key)
);

CREATE TABLE Program_trainers
(
    INTEGER trainer NOT NULL,
    INTEGER program NOT NULL,
    PRIMARY KEY (trainer, program),
    FOREIGN KEY trainer REFERENCES Trainers(unique_key),
    FOREIGN KEY program REFERENCES Programs(unique_key)
);

CREATE TABLE Program_participation
(
    INTEGER participant NOT NULL,
    INTEGER program NOT NULL,
    PRIMARY KEY (participant, program),
    FOREIGN KEY participant REFERENCES Participants(unique_key),
    FOREIGN KEY program REFERENCES Programs(unique_key)
);

CREATE TABLE Documents
(
    INTEGER unique_key NOT NULL AUTOINCREMENT,
    VARCHAR(500) description NOT NULL,
    INTEGER previous_revision,
    FOREIGN KEY previous_revision REFERENCES Documents(unique_key),
    PRIMARY KEY (unique_key)
);

CREATE TABLE Document_authors
(
    INTEGER document NOT NULL,
    INTEGER author NOT NULL,
    PRIMARY KEY (document, author),
    FOREIGN KEY document REFERENCES Documents(qunie_key),
    FOREIGN KEY author REFERENCES Authors(unique_key)
);

CREATE TABLE Program_documents
(
    INTEGER program NOT NULL,
    INTEGER document NOT NULL,
    PRIMARY KEY (program, document),
    FOREIGN KEY document REFERENCES Documents(qunie_key),
    FOREIGN KEY program REFERENCES Programs(unique_key)
);

