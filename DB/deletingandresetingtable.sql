ALTER TABLE Orders
DROP CONSTRAINT fk_PerOrders


TRUNCATE TABLE Areas
DBCC CHECKIDENT (Areas, RESEED, 1)

Insert into Areas
values ('123-244', '2.4')