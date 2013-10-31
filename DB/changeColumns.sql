ALTER TABLE Areas
DROP COLUMN fromMin

ALTER TABLE Areas
DROP COLUMN ToMax

ALTER TABLE Areas
DROP COLUMN name

ALTER TABLE Areas
ADD fromMin nvarchar(9) null

ALTER TABLE Areas
ADD toMax nvarchar(9) null

ALTER TABLE Areas
ADD areaVal real null