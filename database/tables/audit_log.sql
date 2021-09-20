-- AuditLog Table: Contains audit logs for various user interactions performed including exceptions
-- Author: Sarav Sandhu
-- Version: 1.0
-- Created On: 2021-09-19

CREATE TABLE AuditLog (
    LogId Number(12),
    Log_Type Number(2),
    Object_Name VarChar2(30),
    Log_Marker Number(2),
    Key_Identifier Number(12),
    Status_Code Number(12) Default 0,
    Status_Message VarChar2(200),
    Key_Metadata VarChar2(500),
    LogTime timestamp(9) DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE AuditLog ADD CONSTRAINT AuditLog_PK PRIMARY KEY (LogId);
