# Transaction Routine
## _A financial transaction processing application_

Transaction routine is a basic financial accounting application developed for personal and small scale accounts tracking requirement. 

## Features
- Maintaining Multiple Accounts
- Complete record of transactions
- An audit mechanism for tracking the usage of application by various users
- JSON based HTTP API Support for easy integration into frontend applications

## Tech

This application a number of technologies and projects projects to work properly:

- [Oracle_DB] - Highly reliable and commercially used Oracle backend database for maintaining records
- [python] - Pyhon has been used as a glue code between middleware API and backend database
- [cx_Oracle] - cx_Oracle has been utilized for calling Oracle procedures from python middleware
- [Flask] - Flask has been utilized for exposing required JSON endpoints on HTTP protocol
- [Docker] - For dockerizing the application
- [GitHub] - The codebase is mainitained in GitHub and is publically accessible for use
- [VS_Code] - Microsoft Visual Studio code utilized for minitainance of code
- [vi] - The legentary "vi" editor has been used in the development of all modules of this application
- [curl] - curl utility utilized for unit testing of API endpoints
- [DBeaver_CE] - DBeaver Community edition has been utilized for testing and validation of database objects

## Installation

The installation of this module comprises of 2 parts:

### Oracle Database Installation
#### Prerequisites
- Oracle installation a Oralce 12c/19c database as base container. You may request an on-demand AWS RDS instance for testing.
- A Oracle sqlplus instant client needs to be preinstalled for installation steps execution. You may use the official Oracle Instant Client docker image for your ease.
#### Steps
- Checkout the code from git:
```sh
git clone --branch develop https://github.com/sp99/transaction_routine.git transaction_routine_develop
```
- Switch to database directory and execute following installation script:
```sh
cd database/
sqlplus <DB_user>/<DB_Password>@<DB_Connection_String> @install.sql
```

### API Application Installation
#### Prerequisites
- A docker environment is required for building and running the image.
#### Steps
- Checkout the code from git:
```sh
git clone --branch develop https://github.com/sp99/transaction_routine.git transaction_routine_develop
```
- Build docker image from provided [Dockerfile]
```sh
cd app/
docker build -t transaction_routine .
```
- Run the newly created docker image
```sh
docker run -it -p 5000:5000 -e db_user=<DB_User> -e db_password=<DB_Password> -e db_connection=<DB_Host>:<DB_Port>/<DB_Name> transaction_routine
```

## Testing
You may use the following file for testing out the various endpoints exposed by the application: transaction_routine/tests/sample_URLs
Feel free to reach the developer in case you have any question.