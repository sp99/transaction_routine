import sys
import cx_Oracle
from flask import Flask, json, make_response, request

#Database Connection Initialization Section
#Parse input arguments to fetch dynamic db credentals
if len(sys.argv) != 4 :
    print("Invalid Invlocation. Please run the application using following format:")
    print("python3 transaction_interface.py <Database_User> <Database_Password> <Database_Connection>")
    sys.exit()
else:
    db_user = sys.argv[1]
    db_password = sys.argv[2]
    db_conn = sys.argv[3]
# Establish the database connection
connection = cx_Oracle.connect(user=db_user, password=db_password,dsn=db_conn)
# Obtain a cursor
cursor = connection.cursor()


# REST Initialization Section
# Initialize api
api = Flask(__name__)


#Endpoint 1: Get Account Details
@api.route('/accounts/<int:accountId>', methods=['GET'])
def get_accounts(accountId):
    print("Get Account Details for account ID : ", accountId)

    # Cursor variables
    account_id = cursor.var(int);
    document_number = cursor.var(int);

    # Execute the query
    cursor.callproc('Process_User_Operation.Get_Accounts', [accountId, account_id, document_number])
    print('Fetched Document Number: ', document_number.getvalue(), 'Account:', account_id.getvalue())

    #Build JSON Response
    response = [{"account_id": account_id.getvalue(), "document_number": document_number.getvalue()}]
    return json.dumps(response)

#Endpoint 2: Post Account Details
@api.route('/accounts', methods=['POST'])
def create_account():
    if not request.json or not 'document_number' in request.json:
        abort(400)
    print("Creating Account for Document: ", request.json['document_number'])
    
    # Cursor variables
    account_id = cursor.var(int);
    document_number = int(request.json['document_number']);

    # Execute the query
    cursor.callproc('Process_User_Operation.Post_Accounts', [document_number, account_id])
    print('Created New Account for Document Number: ', document_number, ' with new account ID :', account_id.getvalue())

    #Build JSON Response
    response = [{"account_id": account_id.getvalue(), "document_number": document_number}]
    return json.dumps(response)

#Post a new transaction
@api.route('/transactions', methods=['POST'])
def create_transaction():
    if not request.json or not 'account_id' in request.json or not 'operation_type_id' in request.json or not 'amount' in request.json:
        abort(400)
    print("Posting new transaction for accoud id : ", request.json['account_id']," operation id:", request.json['operation_type_id']," Amount:", request.json['amount'])
    # Cursor variables
    account_id = int(request.json['account_id']);
    operation_type_id = int(request.json['operation_type_id']);
    amount = float(request.json['amount']);
    transaction_id = cursor.var(int);

    # Execute the query
    cursor.callproc('Process_User_Operation.Post_Transactions', [account_id, operation_type_id, amount, transaction_id])
    print('Transaction done with transaction id :', transaction_id.getvalue())

    #Build JSON Response
    response = [{"account_id": account_id, "operation_type_id": operation_type_id, "amount": amount, "transaction_id": transaction_id.getvalue()}]
    return json.dumps(response)

@api.errorhandler(404)
def not_found(error):
    return make_response(json.dumps({'error': 'Not found'}), 404)

if __name__ == '__main__':
    api.run(host="0.0.0.0") 





