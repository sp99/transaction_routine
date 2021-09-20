CREATE or REPLACE PACKAGE BODY Audit_logger AS

    PROCEDURE Put_Log( aLogId IN Number,
                    aLog_Type IN Number,
                    aObject_Name IN VarChar2,
                    aLog_Marker IN Number,
                    aKey_Identifier IN Number,
                    aStatus_Code IN Number,
                    aStatus_Message IN VarChar2,
                    aKey_Metadata IN VarChar2)
    IS
        OBJECT_NAME VarChar2(30) := 'Put_Log';
    BEGIN
        Insert Into AuditLog ( LogId, Log_Type, Object_Name, Log_Marker, Key_Identifier, Status_Code, Status_Message, Key_Metadata)
        Values ( aLogId, aLog_Type, aObject_Name, aLog_Marker, aKey_Identifier, aStatus_Code, aStatus_Message, aKey_Metadata);
        Commit;
    END Put_Log;

END Audit_logger;
/
