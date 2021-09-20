-- Accounts Table: Contains account related information
-- Author: Sarav Sandhu
-- Version: 1.0
-- Created On: 2021-09-19

CREATE TABLE Accounts (
    Account_ID Number(12),
    Document_Number Number(20) Not Null,
    Balance_Amount Number(10,1) Default 0.0
);

ALTER TABLE Accounts ADD CONSTRAINT Accounts_PK PRIMARY KEY (Account_ID);