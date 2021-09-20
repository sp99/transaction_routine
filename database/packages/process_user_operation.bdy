CREATE or REPLACE PACKAGE BODY Process_User_Operation AS
    PROCEDURE Get_Accounts(accountId IN Number,
                        account_id OUT Number,
                        document_number OUT Number)
    IS
        OBJECT_NAME VarChar2(30) := 'Get_Accounts';
        tDocument_Number Number(12);
    BEGIN
        Audit_logger.Put_Log( aLogId=> logid_seq.nextval, aLog_Type => Audit_logger.LOG_LEVEL_INFO,
                            aObject_Name => OBJECT_NAME, aLog_Marker => Audit_logger.MARK_START,
                            aKey_Identifier => NULL, aStatus_Code=> NULL, aStatus_Message => NULL,
                            aKey_Metadata => NULL );

        Select Document_Number
        INTO tDocument_Number
        FROM Accounts
        Where Account_ID = accountId;

        dbms_output.put_line('Document_Number:'||tDocument_Number);
        account_id := accountId;
        document_number := tDocument_Number;

        Audit_logger.Put_Log( aLogId=> logid_seq.nextval, aLog_Type => Audit_logger.LOG_LEVEL_INFO,
                            aObject_Name => OBJECT_NAME, aLog_Marker => Audit_logger.MARK_END,
                            aKey_Identifier => NULL, aStatus_Code=> NULL, aStatus_Message => NULL,
                            aKey_Metadata => NULL );
    exception
      when NO_DATA_FOUND then
        dbms_output.put_line('No data found exception in ['|| OBJECT_NAME ||'] for accountid:[' || accountId || '] Error Details:['|| SQLCODE || '][' || SQLERRM || '].');
        Audit_logger.Put_Log( aLogId=> logid_seq.nextval, aLog_Type => Audit_logger.LOG_LEVEL_ERROR,
                            aObject_Name => OBJECT_NAME, aLog_Marker => Audit_logger.MARK_EXCEPTION,
                            aKey_Identifier => accountId, aStatus_Code=> SQLCODE, aStatus_Message => SQLERRM,
                            aKey_Metadata => NULL );
        account_id := -1;
        document_number := -1;
      when Others then
        dbms_output.put_line('Exception in ['|| OBJECT_NAME ||'] for accountid:[' || accountId || '] Error Details:['|| SQLCODE || '][' || SQLERRM || '].');
        Audit_logger.Put_Log( aLogId=> logid_seq.nextval, aLog_Type => Audit_logger.LOG_LEVEL_ERROR,
                            aObject_Name => OBJECT_NAME, aLog_Marker => Audit_logger.MARK_EXCEPTION,
                            aKey_Identifier => accountId, aStatus_Code=> SQLCODE, aStatus_Message => SQLERRM,
                            aKey_Metadata => NULL );
        account_id := -1;
        document_number := -1;
    END Get_Accounts;
    
    PROCEDURE Post_Accounts(document_number IN Number,
                            account_id OUT Number)
    IS
        OBJECT_NAME VarChar2(30) := 'Post_Accounts';
        New_Account_ID Number(12);
    BEGIN
        Audit_logger.Put_Log( aLogId=> logid_seq.nextval, aLog_Type => Audit_logger.LOG_LEVEL_INFO,
                            aObject_Name => OBJECT_NAME, aLog_Marker => Audit_logger.MARK_START,
                            aKey_Identifier => NULL, aStatus_Code=> NULL, aStatus_Message => NULL,
                            aKey_Metadata => NULL );

        New_Account_ID := account_id_seq.nextval;
        dbms_output.put_line('New accoud id proposed:['|| New_Account_ID ||'].');
        Insert Into Accounts (Account_ID, Document_Number)
        Values (New_Account_ID, document_number);
        commit;

        Audit_logger.Put_Log( aLogId=> logid_seq.nextval, aLog_Type => Audit_logger.LOG_LEVEL_INFO,
                            aObject_Name => OBJECT_NAME, aLog_Marker => Audit_logger.MARK_END,
                            aKey_Identifier => NULL, aStatus_Code=> NULL, aStatus_Message => NULL,
                            aKey_Metadata => NULL );
    exception
      when Others then
        dbms_output.put_line('Exception in ['|| OBJECT_NAME ||'] for document_number:[' || document_number || '] Error Details:['|| SQLCODE || '][' || SQLERRM || '].');
        Audit_logger.Put_Log( aLogId=> logid_seq.nextval, aLog_Type => Audit_logger.LOG_LEVEL_ERROR,
                            aObject_Name => OBJECT_NAME, aLog_Marker => Audit_logger.MARK_EXCEPTION,
                            aKey_Identifier => document_number, aStatus_Code=> SQLCODE, aStatus_Message => SQLERRM,
                            aKey_Metadata => NULL );
        account_id := -1;
    END Post_Accounts;

    PROCEDURE Post_Transactions(accountId IN Number,
                                operation_type_id IN Number,
                                amount IN Number,
                                Transaction_ID OUT Number)
    IS
        OBJECT_NAME VarChar2(30) := 'Post_Transactions';
        New_Transaction_ID Number(12);
        Transaction_Amount Number(10,1);
        Exception_Invalid_Operation EXCEPTION;
    BEGIN
        Audit_logger.Put_Log( aLogId=> logid_seq.nextval, aLog_Type => Audit_logger.LOG_LEVEL_INFO,
                            aObject_Name => OBJECT_NAME, aLog_Marker => Audit_logger.MARK_START,
                            aKey_Identifier => NULL, aStatus_Code=> NULL, aStatus_Message => NULL,
                            aKey_Metadata => NULL );

        New_Transaction_ID := transaction_id_seq.nextval;
        IF operation_type_id = OPERATION_NORMAL_PURCHASE THEN
            Transaction_Amount := amount * -1;
        ELSIF operation_type_id = OPERATION_PURCHASE_WITH_INSTALMENTS THEN
            Transaction_Amount := amount * -1;
        ELSIF operation_type_id = OPERATION_WITHDRAWAL THEN
            Transaction_Amount := amount * -1;
        ELSIF operation_type_id = OPERATION_CREDIT_VOUCHER THEN
            Transaction_Amount := amount;
        ELSE
            Raise Exception_Invalid_Operation;
        END IF;

        Insert Into Transactions (Transaction_ID, Account_ID, OperationType_ID, Amount)
        Values (New_Transaction_ID, accountId, operation_type_id, Transaction_Amount);

        Update Accounts
        Set Balance_Amount = Balance_Amount + Transaction_Amount
        Where Account_ID = accountId;
        Commit;
        Transaction_ID := New_Transaction_ID;

        Audit_logger.Put_Log( aLogId=> logid_seq.nextval, aLog_Type => Audit_logger.LOG_LEVEL_INFO,
                            aObject_Name => OBJECT_NAME, aLog_Marker => Audit_logger.MARK_END,
                            aKey_Identifier => NULL, aStatus_Code=> NULL, aStatus_Message => NULL,
                            aKey_Metadata => NULL );
    exception
      when Exception_Invalid_Operation then
        dbms_output.put_line('Exception for Invalid Operation specified in ['|| OBJECT_NAME ||'] for accountId:[' || accountId || '] operation_type_id:['|| operation_type_id || '] amount:[' || amount || '].');
        Audit_logger.Put_Log( aLogId=> logid_seq.nextval, aLog_Type => Audit_logger.LOG_LEVEL_ERROR,
                            aObject_Name => OBJECT_NAME, aLog_Marker => Audit_logger.MARK_EXCEPTION,
                            aKey_Identifier => accountId, aStatus_Code=> -1 , aStatus_Message => 'Exception_Invalid_Operation',
                            aKey_Metadata => '['||operation_type_id||']['||amount||']' );
        Transaction_ID := -1;
      when Others then
        dbms_output.put_line('Exception in ['|| OBJECT_NAME ||'] for accountId:[' || accountId || '] operation_type_id:['|| operation_type_id || '] amount:[' || amount || '] Error Details:['|| SQLCODE || '][' || SQLERRM || '].');
        Audit_logger.Put_Log( aLogId=> logid_seq.nextval, aLog_Type => Audit_logger.LOG_LEVEL_ERROR,
                            aObject_Name => OBJECT_NAME, aLog_Marker => Audit_logger.MARK_EXCEPTION,
                            aKey_Identifier => accountId, aStatus_Code=> SQLCODE , aStatus_Message => SQLERRM,
                            aKey_Metadata => '['||operation_type_id||']['||amount||']' );
        Transaction_ID := -1;
    END Post_Transactions;

END Process_User_Operation;
/
