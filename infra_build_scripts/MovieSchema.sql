BEGIN TRANSACTION;
DROP TABLE IF EXISTS "Movie";
CREATE TABLE "Movie"
(
    "Id" INT NOT NULL IDENTITY PRIMARY KEY,
    "Title" VARCHAR,
    "ReleaseDate" VARCHAR NOT NULL,
    "Genre" VARCHAR,
    "Price" VARCHAR NOT NULL
);
INSERT INTO "Movie"
    ("Title","ReleaseDate","Genre","Price")
VALUES
    ('Software', '2019-06-03 00:00:00', 'Drama', '20.0');
COMMIT;
