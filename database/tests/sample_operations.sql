begin
  Insert Into OperationsTypes (OperationType_ID, Description0)
  Values (1, 'Normal Purchase');
  Insert Into OperationsTypes (OperationType_ID, Description0)
  Values (2, 'Purchase with installments');
  Insert Into OperationsTypes (OperationType_ID, Description0)
  Values (3, 'Withdrawal');
  Insert Into OperationsTypes (OperationType_ID, Description0)
  Values (4, 'Credit Voucher');
  commit;
end;
/
