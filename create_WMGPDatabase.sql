​​DROP DATABASE IF EXISTS WMGPDatabase
 
GO
 
CREATE DATABASE WMGPDatabase
 
GO
 
USE WMGPDatabase
 
GO
 
IF EXISTS (SELECT NAME FROM SYS.TABLES WHERE NAME = 'Menu')
  	DROP TABLE Menu;
 
IF EXISTS (SELECT NAME FROM SYS.TABLES WHERE NAME = 'Recipes')
  	DROP TABLE Recipes;
 
IF EXISTS (SELECT NAME FROM SYS.TABLES WHERE NAME = 'Inventory')
  	DROP TABLE Inventory;
 
IF EXISTS (SELECT NAME FROM SYS.TABLES WHERE NAME = 'RecipesInventory')
  	DROP TABLE RecipesInventory;
 
IF EXISTS (SELECT NAME FROM SYS.TABLES WHERE NAME = 'Employee')
  	DROP TABLE Employee
 
IF EXISTS (SELECT NAME FROM SYS.TABLES WHERE NAME = 'Schedule')
  	DROP TABLE Schedule;
 
 
 
GO
 
CREATE TABLE Menu
  	(MenuItemID varchar(5) NOT NULL PRIMARY KEY,
  	MenuItemName varchar(30) NULL,
  	MenuItemPrice decimal(9, 2) NULL,
  	MenuItemCalories decimal(4, 0) NULL)
 
GO
 
CREATE TABLE Recipes
  	(RecipeID varchar(5) NOT NULL PRIMARY KEY,
  	MenuItemID varchar(5) NOT NULL,
  	RecipeInstruction varchar(500) NULL)
 
GO
 
CREATE TABLE RecipesInventory
  	(ItemNumber varchar(10) NOT NULL,
  	RecipeID varchar(5) NOT NULL,
  	ItemAmount varchar(10) NOT NULL)
 
GO
 
CREATE TABLE Inventory
  	(ItemNumber varchar(10) NOT NULL PRIMARY KEY,
  	ItemName varchar(30) NULL,
  	ItemPrice decimal(9, 2) NULL,
  	ItemStock decimal(5, 0) NULL,
  	StockLevelForReorder decimal(5, 0) NULL,
  	CHECK (ItemStock > StockLevelForReorder))
 
GO
 
CREATE TABLE Employee
  	(EmployeeID varchar(5) NOT NULL PRIMARY KEY,
  	FirstName varchar(15) NULL,
  	LastName varchar(20) NULL,
  	HireDate smalldatetime NULL,
  	ReleaseDate smalldatetime NULL)
 
GO
 
CREATE TABLE Schedule
  	(ShiftID varchar(5) NOT NULL PRIMARY KEY,
  	EmployeeID varchar(5) NOT NULL,
  	ShiftDate smalldatetime NULL,
  	ShiftStart time NULL,
  	ShiftEnd time NULL,
  	CHECK (ShiftStart < ShiftEnd))
 
GO
 
ALTER TABLE Recipes ADD CONSTRAINT Recipes_Menu_FK FOREIGN KEY (MenuItemID) REFERENCES Menu (MenuItemID)
 
ALTER TABLE RecipesInventory ADD CONSTRAINT RecipesInventory_Inventory_FK FOREIGN KEY (ItemNumber) REFERENCES Inventory (ItemNumber)
 
ALTER TABLE RecipesInventory ADD CONSTRAINT RecipesInventory_Recipes_FK FOREIGN KEY (RecipeID) REFERENCES Recipes (RecipeID)
 
ALTER TABLE Schedule ADD CONSTRAINT Schedule_Employee_FK FOREIGN KEY (EmployeeID) REFERENCES Employee (EmployeeID)
  
INSERT INTO Menu (MenuItemID, MenuItemName, MenuItemPrice, MenuItemCalories)
VALUES
	('COF01', 'Americano', 3.50, 200),
	('COF02', 'Caffe Mocha', 5.49, 450),
	('COF03', 'Caffe Latte', 4.75, 240),
  	('COF04', 'Expresso', 4.85, 150),
	('COF05', 'Ice Coffee', 3.85, 250),
	('PAS01', 'Cinnamon Roll', 3.10, 670),
  	('PAS02', 'Oatmeal Cookie', 2.95, 570),
  	('PAS03', 'Danish', 3.00, 310);
 
INSERT INTO Recipes (RecipeID, MenuItemID, RecipeInstruction)
VALUES
	('REC01', 'COF01', 'Brew espresso shot using beans, heat water, pour together, stir'),
	('REC02', 'COF02', 'Brew espresso, steam milk, add cocoa powder and cinnamon mix together, pour espresso and steam milk into cup, stir'),
	('REC03', 'COF03', 'Brew espresso, steam milk, pour together, stir, add foam on top'),
  	('REC04', 'COF04', 'Brew espresso shot, heat water, pour together, stir'),
  	('REC05', 'COF05', 'Brew coffee with water, chill coffee, add ice, pour coffee into ice, stir'),
	('REC06', 'PAS01', 'Mix ingredients, roll dough, add sugar, shape, and bake'),
	('REC07', 'PAS02', 'Mix ingredients, scoop into small balls, and bake'),
	('REC08', 'PAS03', 'Mix ingredients, shape, add jam, and bake');
 
INSERT INTO Inventory (ItemNumber, ItemName, ItemPrice, ItemStock, StockLevelForReorder)
VALUES
	('INV01', 'Coffee Beans', 10.00, 50, 10),
	('INV02', 'Milk', 3.00, 20, 10),
	('INV03', 'Butter', 2.50, 15, 8),
	('INV04', 'Flour', 2.00, 40, 10),
  	('INV05', 'Yeast', 4.00, 10, 6),
  	('INV06', 'Sugar', 5.00, 20, 10),
  	('INV07', 'Flour', 2.00, 40, 10),
  	('INV08', 'Eggs', 4.95, 20, 10),
  	('INV09', 'Cocoa Powder', 8.50, 11, 10),
  	('INV10', 'Jam', 3.50, 8, 5),
  	('INV11', 'Cinnamon', 4.50, 20, 10),
  	('INV12', 'Oatmeal', 5.00, 25, 5),
  	('INV13', 'Salt', 5.00, 20, 10),
  	('INV14', 'Baking Soda', 4.00, 10, 6),
  	('INV15', 'Vanilla', 3.5, 8, 5),
  	('INV16', 'Baking Powder', 4.00, 10, 6);
 
INSERT INTO Employee (EmployeeID, FirstName, LastName, HireDate, ReleaseDate)
VALUES
	('EMP01', 'John', 'Reed', '2020-05-15', NULL),
	('EMP02', 'Jane', 'Smith', '2021-06-20', NULL),
  	('EMP03', 'Alice', 'Micheals', '2021-07-05', NULL),
  	('EMP04', 'Nicole', 'Dade', '2021-05-21', NULL),
	('EMP05', 'Kim', 'Lass', '2022-07-10', '2023-12-31'),
  	('EMP06', 'Tom', 'Fordam', '2023-01-08', NULL),
  	('EMP07', 'Alex', 'Gibson', '2023-05-02', NULL);
 
INSERT INTO Schedule (ShiftID, EmployeeID, ShiftDate, ShiftStart, ShiftEnd)
VALUES
  	('SCH01', 'EMP01', '2024-04-08', '00:00', '08:00'),
	('SCH02', 'EMP02', '2024-04-08', '02:00', '10:00'),
	('SCH03', 'EMP03', '2024-04-08', '04:00', '12:00'),
	('SCH04', 'EMP04', '2024-04-08', '06:00', '14:00'),
	('SCH05', 'EMP06', '2024-04-08', '08:00', '16:00'),
	('SCH06', 'EMP07', '2024-04-08', '10:00', '18:00');
 
INSERT INTO RecipesInventory (ItemNumber, RecipeID, ItemAmount)
VALUES
  	('INV01', 'REC01', '2 tsp'),
  	('INV01', 'REC02', '2 tsp'),
  	('INV02', 'REC02', '4 oz'),
  	('INV09', 'REC02', '0.25 tsp'),
  	('INV11', 'REC02', '0.25 tsp'),
  	('INV01', 'REC03', '2 tsp'),
  	('INV02', 'REC03', '4 oz'),
  	('INV01', 'REC04', '2 tsp'),
  	('INV01', 'REC05', '2 tsp'),
     
  	('INV03', 'REC06', '3 tbsp'),
  	('INV04', 'REC06', '2.75 cup'),
  	('INV06', 'REC06', '0.25 cup'),
  	('INV08', 'REC06', '1'),
  	('INV05', 'REC06', '2.25 tsp'),
  	('INV02', 'REC06', '0.75 cup'),
  	('INV13', 'REC06', '0.5 tsp'),
 
  	('INV04', 'REC07', '1.75 cup'),
  	('INV06', 'REC07', '2 cup'),
  	('INV08', 'REC07', '2'),
  	('INV03', 'REC07', '1 cup'),
  	('INV12', 'REC07', '3 cup'),
  	('INV13', 'REC07', '1 tsp'),
  	('INV14', 'REC07', '0.5 tsp'),
  	('INV15', 'REC07', '2 tsp'),
 
  	('INV04', 'REC08', '2 cup'),
  	('INV03', 'REC08', '0.5 cup'),
  	('INV06', 'REC08', '0.5 cup'),
  	('INV16', 'REC08', '3 tsp'),
  	('INV13', 'REC08', '0.5 tsp'),
  	('INV08', 'REC08', '1'),
  	('INV02', 'REC08', '0.5 cup'),
  	('INV10', 'REC08', '7 tsp');

Create Role ProductManagementDH;

Grant Select on Schema:: dbo To ProductManagementDH;

Grant Update on dbo.Menu To ProductManagementDH;

Grant Update on dbo.Recipes To ProductManagementDH;

Grant Update on dbo.Inventory To ProductManagementDH;

