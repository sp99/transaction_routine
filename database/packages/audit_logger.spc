CREATE or REPLACE PACKAGE Audit_logger AS

    /*
     * Constants defining the log levels
     */
    LOG_LEVEL_INFO      CONSTANT NUMBER := 1;
    LOG_LEVEL_WARNING   CONSTANT NUMBER := 2;
    LOG_LEVEL_ERROR     CONSTANT NUMBER := 3;
    LOG_LEVEL_DEBUG     CONSTANT NUMBER := 4;

    /*
     * Constants defining the log markers
     */
    MARK_START      CONSTANT NUMBER := 1;
    MARK_END        CONSTANT NUMBER := 2;
    MARK_EXCEPTION  CONSTANT NUMBER := 3;
    MARK_OTHERS     CONSTANT NUMBER := 4;

    PROCEDURE Put_Log ( aLogId IN NUMBER, aLog_Type IN NUMBER, aObject_Name IN VarChar2, aLog_Marker IN NUMBER,
                aKey_Identifier IN NUMBER, aStatus_Code IN NUMBER, aStatus_Message IN VarChar2, aKey_Metadata IN VarChar2);
END Audit_logger;
/
