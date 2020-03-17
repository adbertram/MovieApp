BEGIN TRANSACTION;
DROP TABLE IF EXISTS "Movie";
CREATE TABLE "Movie"
(
    "Id" INT NOT NULL IDENTITY PRIMARY KEY,
    "Title" VARCHAR(max),
    "ReleaseDate" VARCHAR(max) NOT NULL,
    "Genre" VARCHAR(max),
    "Price" VARCHAR(max) NOT NULL
);
INSERT INTO "Movie"
    ("Title","ReleaseDate","Genre","Price")
VALUES
    ('Software', '2019-06-03 00:00:00', 'Drama', '20.0');
COMMIT;
