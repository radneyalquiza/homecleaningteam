/* cascade upwards from sub option to quote, in order to remove and re-seed */
DELETE FROM OptionItems
DBCC CHECKIDENT (OptionItems, RESEED, 0)

DELETE FROM AppItems
DBCC CHECKIDENT (AppItems, RESEED, 0)

DELETE FROM RoomItems
DBCC CHECKIDENT (RoomItems, RESEED, 0)

DELETE FROM Quotes
DBCC CHECKIDENT (Quotes, RESEED, 0)

DELETE FROM HouseItems
DBCC CHECKIDENT (HouseItems, RESEED, 0)


/* to change the currency format */
/*ALTER TABLE Persons
ALTER COLUMN DateOfBirth year*/

DELETE FROM Customers
DBCC CHECKIDENT (Customers, RESEED, 0)
DELETE FROM Addresses
DBCC CHECKIDENT (Addresses, RESEED, 0)
DELETE FROM Properties
DBCC CHECKIDENT (Properties, RESEED, 0)
DELETE FROM People
DBCC CHECKIDENT (Properties, RESEED, 0)
