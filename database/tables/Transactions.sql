-- Transactions Table: Contains record of transactions in accounts
-- Author: Sarav Sandhu
-- Version: 1.0
-- Created On: 2021-09-19

CREATE TABLE Transactions (
    Transaction_ID Number(12),
    Account_ID Number(12),
    OperationType_ID Number(4),
    Amount Number(10,1) NOT NULL,
    EventDate timestamp(9) DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE Transactions ADD CONSTRAINT Transactions_PK PRIMARY KEY (Transaction_ID);
ALTER TABLE Transactions ADD CONSTRAINT Transactions_FK1 FOREIGN KEY (Account_ID) REFERENCES Accounts (Account_ID);
ALTER TABLE Transactions ADD CONSTRAINT Transactions_FK2 FOREIGN KEY (OperationType_ID) REFERENCES OperationsTypes (OperationType_ID);