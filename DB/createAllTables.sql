-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, and Azure
-- --------------------------------------------------
-- Date Created: 04/29/2013 14:50:16
-- Generated from EDMX file: C:\Users\AtlasSSD\Desktop\HomeCleaningTeamWebsite\App_Code\Model.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [hctDB];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------


-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------


-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'RTQOptions'
CREATE TABLE [dbo].[RTQOptions] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [name] nvarchar(max)  NULL,
    [time] int  NULL,
    [cost] real  NULL,
    [description] nvarchar(max)  NULL,
    [status] nvarchar(max)  NULL,
    [RTQApp_Id] int  NOT NULL
);
GO

-- Creating table 'RTQApps'
CREATE TABLE [dbo].[RTQApps] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [name] nvarchar(max)  NULL,
    [status] nvarchar(max)  NULL,
    [description] nvarchar(max)  NULL,
    [Room_Id] int  NOT NULL
);
GO

-- Creating table 'Rooms'
CREATE TABLE [dbo].[Rooms] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [name] nvarchar(max)  NULL,
    [description] nvarchar(max)  NULL
);
GO

-- Creating table 'Customers'
CREATE TABLE [dbo].[Customers] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [lastName] nvarchar(max)  NULL,
    [firstName] nvarchar(max)  NULL,
    [custID] nvarchar(max)  NULL,
    [status] nvarchar(max)  NULL,
    [joinDate] datetime  NULL,
    [Contact_Id] int  NOT NULL,
    [Address_Id] int  NOT NULL
);
GO

-- Creating table 'Employees'
CREATE TABLE [dbo].[Employees] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [lastName] nvarchar(max)  NULL,
    [firstName] nvarchar(max)  NULL,
    [empID] nvarchar(max)  NULL,
    [status] nvarchar(max)  NULL,
    [hireDate] datetime  NULL,
    [removeDate] datetime  NULL,
    [type] nvarchar(max)  NULL,
    [Contact_Id] int  NOT NULL,
    [Address_Id] int  NOT NULL
);
GO

-- Creating table 'Quotes'
CREATE TABLE [dbo].[Quotes] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [quoteCode] nvarchar(max)  NULL,
    [totalPrice] decimal(18,0)  NULL,
    [totalTime] int  NULL,
    [name] nvarchar(max)  NULL,
    [Order_Id] int  NOT NULL,
    [HouseItem_Id] int  NOT NULL
);
GO

-- Creating table 'Orders'
CREATE TABLE [dbo].[Orders] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [orderID] nvarchar(max)  NULL,
    [name] nvarchar(max)  NULL,
    [dateCreated] datetime  NULL,
    [dateModified] datetime  NULL,
    [paymentStatus] nvarchar(max)  NULL,
    [jobStatus] nvarchar(max)  NULL,
    [paymentMethod] nvarchar(max)  NULL,
    [paymentDate] datetime  NULL,
    [Customer_Id] int  NOT NULL
);
GO

-- Creating table 'Contacts'
CREATE TABLE [dbo].[Contacts] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [phone1] nvarchar(max)  NULL,
    [phone2] nvarchar(max)  NULL,
    [phone3] nvarchar(max)  NULL,
    [email1] nvarchar(max)  NULL,
    [email2] nvarchar(max)  NULL
);
GO

-- Creating table 'Addresses'
CREATE TABLE [dbo].[Addresses] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [bldg] int  NULL,
    [unit] int  NULL,
    [street] nvarchar(max)  NULL,
    [city] nvarchar(max)  NULL,
    [postal] nvarchar(max)  NULL
);
GO

-- Creating table 'Events'
CREATE TABLE [dbo].[Events] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [name] nvarchar(max)  NULL,
    [startDate] datetime  NULL,
    [endDate] datetime  NULL,
    [startTime] int  NULL,
    [endTime] int  NULL,
    [Order_Id] int  NOT NULL
);
GO

-- Creating table 'OptionItems'
CREATE TABLE [dbo].[OptionItems] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [name] nvarchar(max)  NULL,
    [time] int  NULL,
    [cost] real  NULL,
    [AppItem_Id] int  NOT NULL
);
GO

-- Creating table 'AppItems'
CREATE TABLE [dbo].[AppItems] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [name] nvarchar(max)  NULL,
    [RoomItem_Id] int  NOT NULL
);
GO

-- Creating table 'RoomItems'
CREATE TABLE [dbo].[RoomItems] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [nickName] nvarchar(max)  NULL,
    [name] nvarchar(max)  NULL,
    [HouseItem_Id] int  NOT NULL
);
GO

-- Creating table 'HouseItems'
CREATE TABLE [dbo].[HouseItems] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [houseType] nvarchar(max)  NULL,
    [cleaningType] nvarchar(max)  NULL,
    [area] nvarchar(max)  NULL,
    [name] nvarchar(max)  NULL,
    [otherInfo] nvarchar(max)  NULL
);
GO

-- Creating table 'PresetItems'
CREATE TABLE [dbo].[PresetItems] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [price] decimal(18,0)  NULL,
    [time] int  NULL,
    [description] nvarchar(max)  NULL,
    [title] nvarchar(max)  NULL,
    [startDate] datetime  NULL,
    [endDate] datetime  NULL
);
GO

-- Creating table 'CleaningTypes'
CREATE TABLE [dbo].[CleaningTypes] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [name] nvarchar(max)  NULL,
    [cTypeValue] real  NULL,
    [description] nvarchar(max)  NULL
);
GO

-- Creating table 'HouseTypes'
CREATE TABLE [dbo].[HouseTypes] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [name] nvarchar(max)  NULL,
    [hTypeValue] real  NULL,
    [description] nvarchar(max)  NULL
);
GO

-- Creating table 'Areas'
CREATE TABLE [dbo].[Areas] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [name] nvarchar(max)  NULL,
    [areaValue] real  NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [Id] in table 'RTQOptions'
ALTER TABLE [dbo].[RTQOptions]
ADD CONSTRAINT [PK_RTQOptions]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'RTQApps'
ALTER TABLE [dbo].[RTQApps]
ADD CONSTRAINT [PK_RTQApps]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Rooms'
ALTER TABLE [dbo].[Rooms]
ADD CONSTRAINT [PK_Rooms]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Customers'
ALTER TABLE [dbo].[Customers]
ADD CONSTRAINT [PK_Customers]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Employees'
ALTER TABLE [dbo].[Employees]
ADD CONSTRAINT [PK_Employees]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Quotes'
ALTER TABLE [dbo].[Quotes]
ADD CONSTRAINT [PK_Quotes]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Orders'
ALTER TABLE [dbo].[Orders]
ADD CONSTRAINT [PK_Orders]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Contacts'
ALTER TABLE [dbo].[Contacts]
ADD CONSTRAINT [PK_Contacts]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Addresses'
ALTER TABLE [dbo].[Addresses]
ADD CONSTRAINT [PK_Addresses]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Events'
ALTER TABLE [dbo].[Events]
ADD CONSTRAINT [PK_Events]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'OptionItems'
ALTER TABLE [dbo].[OptionItems]
ADD CONSTRAINT [PK_OptionItems]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'AppItems'
ALTER TABLE [dbo].[AppItems]
ADD CONSTRAINT [PK_AppItems]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'RoomItems'
ALTER TABLE [dbo].[RoomItems]
ADD CONSTRAINT [PK_RoomItems]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'HouseItems'
ALTER TABLE [dbo].[HouseItems]
ADD CONSTRAINT [PK_HouseItems]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'PresetItems'
ALTER TABLE [dbo].[PresetItems]
ADD CONSTRAINT [PK_PresetItems]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'CleaningTypes'
ALTER TABLE [dbo].[CleaningTypes]
ADD CONSTRAINT [PK_CleaningTypes]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'HouseTypes'
ALTER TABLE [dbo].[HouseTypes]
ADD CONSTRAINT [PK_HouseTypes]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Areas'
ALTER TABLE [dbo].[Areas]
ADD CONSTRAINT [PK_Areas]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [RTQApp_Id] in table 'RTQOptions'
ALTER TABLE [dbo].[RTQOptions]
ADD CONSTRAINT [FK_RTQAppRTQOption]
    FOREIGN KEY ([RTQApp_Id])
    REFERENCES [dbo].[RTQApps]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_RTQAppRTQOption'
CREATE INDEX [IX_FK_RTQAppRTQOption]
ON [dbo].[RTQOptions]
    ([RTQApp_Id]);
GO

-- Creating foreign key on [Room_Id] in table 'RTQApps'
ALTER TABLE [dbo].[RTQApps]
ADD CONSTRAINT [FK_RoomRTQApp]
    FOREIGN KEY ([Room_Id])
    REFERENCES [dbo].[Rooms]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_RoomRTQApp'
CREATE INDEX [IX_FK_RoomRTQApp]
ON [dbo].[RTQApps]
    ([Room_Id]);
GO

-- Creating foreign key on [Order_Id] in table 'Quotes'
ALTER TABLE [dbo].[Quotes]
ADD CONSTRAINT [FK_QuoteOrder]
    FOREIGN KEY ([Order_Id])
    REFERENCES [dbo].[Orders]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_QuoteOrder'
CREATE INDEX [IX_FK_QuoteOrder]
ON [dbo].[Quotes]
    ([Order_Id]);
GO

-- Creating foreign key on [HouseItem_Id] in table 'Quotes'
ALTER TABLE [dbo].[Quotes]
ADD CONSTRAINT [FK_QuoteHouseItem]
    FOREIGN KEY ([HouseItem_Id])
    REFERENCES [dbo].[HouseItems]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_QuoteHouseItem'
CREATE INDEX [IX_FK_QuoteHouseItem]
ON [dbo].[Quotes]
    ([HouseItem_Id]);
GO

-- Creating foreign key on [HouseItem_Id] in table 'RoomItems'
ALTER TABLE [dbo].[RoomItems]
ADD CONSTRAINT [FK_HouseItemRoomItem]
    FOREIGN KEY ([HouseItem_Id])
    REFERENCES [dbo].[HouseItems]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_HouseItemRoomItem'
CREATE INDEX [IX_FK_HouseItemRoomItem]
ON [dbo].[RoomItems]
    ([HouseItem_Id]);
GO

-- Creating foreign key on [RoomItem_Id] in table 'AppItems'
ALTER TABLE [dbo].[AppItems]
ADD CONSTRAINT [FK_RoomItemAppItem]
    FOREIGN KEY ([RoomItem_Id])
    REFERENCES [dbo].[RoomItems]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_RoomItemAppItem'
CREATE INDEX [IX_FK_RoomItemAppItem]
ON [dbo].[AppItems]
    ([RoomItem_Id]);
GO

-- Creating foreign key on [AppItem_Id] in table 'OptionItems'
ALTER TABLE [dbo].[OptionItems]
ADD CONSTRAINT [FK_AppItemOptionItem]
    FOREIGN KEY ([AppItem_Id])
    REFERENCES [dbo].[AppItems]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_AppItemOptionItem'
CREATE INDEX [IX_FK_AppItemOptionItem]
ON [dbo].[OptionItems]
    ([AppItem_Id]);
GO

-- Creating foreign key on [Contact_Id] in table 'Employees'
ALTER TABLE [dbo].[Employees]
ADD CONSTRAINT [FK_ContactEmployee]
    FOREIGN KEY ([Contact_Id])
    REFERENCES [dbo].[Contacts]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_ContactEmployee'
CREATE INDEX [IX_FK_ContactEmployee]
ON [dbo].[Employees]
    ([Contact_Id]);
GO

-- Creating foreign key on [Contact_Id] in table 'Customers'
ALTER TABLE [dbo].[Customers]
ADD CONSTRAINT [FK_ContactCustomer]
    FOREIGN KEY ([Contact_Id])
    REFERENCES [dbo].[Contacts]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_ContactCustomer'
CREATE INDEX [IX_FK_ContactCustomer]
ON [dbo].[Customers]
    ([Contact_Id]);
GO

-- Creating foreign key on [Address_Id] in table 'Employees'
ALTER TABLE [dbo].[Employees]
ADD CONSTRAINT [FK_AddressEmployee]
    FOREIGN KEY ([Address_Id])
    REFERENCES [dbo].[Addresses]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_AddressEmployee'
CREATE INDEX [IX_FK_AddressEmployee]
ON [dbo].[Employees]
    ([Address_Id]);
GO

-- Creating foreign key on [Address_Id] in table 'Customers'
ALTER TABLE [dbo].[Customers]
ADD CONSTRAINT [FK_AddressCustomer]
    FOREIGN KEY ([Address_Id])
    REFERENCES [dbo].[Addresses]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_AddressCustomer'
CREATE INDEX [IX_FK_AddressCustomer]
ON [dbo].[Customers]
    ([Address_Id]);
GO

-- Creating foreign key on [Customer_Id] in table 'Orders'
ALTER TABLE [dbo].[Orders]
ADD CONSTRAINT [FK_OrderCustomer]
    FOREIGN KEY ([Customer_Id])
    REFERENCES [dbo].[Customers]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_OrderCustomer'
CREATE INDEX [IX_FK_OrderCustomer]
ON [dbo].[Orders]
    ([Customer_Id]);
GO

-- Creating foreign key on [Order_Id] in table 'Events'
ALTER TABLE [dbo].[Events]
ADD CONSTRAINT [FK_OrderEvent]
    FOREIGN KEY ([Order_Id])
    REFERENCES [dbo].[Orders]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_OrderEvent'
CREATE INDEX [IX_FK_OrderEvent]
ON [dbo].[Events]
    ([Order_Id]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------