CREATE or REPLACE PACKAGE Process_User_Operation AS

    /*
     * Constants defining the required operations
    */
    OPERATION_NORMAL_PURCHASE           CONSTANT NUMBER := 1;
    OPERATION_PURCHASE_WITH_INSTALMENTS CONSTANT NUMBER := 2;
    OPERATION_WITHDRAWAL                CONSTANT NUMBER := 3;
    OPERATION_CREDIT_VOUCHER            CONSTANT NUMBER := 4;

    PROCEDURE Get_Accounts(accountId IN Number, account_id OUT Number, document_number OUT Number);
    PROCEDURE Post_Accounts(document_number IN Number, account_id OUT Number);
    PROCEDURE Post_Transactions(accountId IN Number, operation_type_id IN Number, amount IN Number, Transaction_ID OUT Number);
END Process_User_Operation;
/
