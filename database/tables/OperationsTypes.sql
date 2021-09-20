-- OperationsTypes Table: Contains set of operations that are permitted
-- Author: Sarav Sandhu
-- Version: 1.0
-- Created On: 2021-09-19

CREATE TABLE OperationsTypes (
    OperationType_ID Number(4),
    Description0 VarChar2(50)
);

ALTER TABLE OperationsTypes ADD CONSTRAINT OperationsTypes_PK PRIMARY KEY (OperationType_ID);