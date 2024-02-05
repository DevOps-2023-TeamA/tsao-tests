# tsao tests
## contents
- [install everything](#install-everything)
- [database testing setup](#database-testing-setup)
- [backend testing setup](#backend-testing-setup)
- [frontend testing setup](#frontend-testing-setup)

## install everything
Install all required frameworks for testing frontend, backend, and database.
```sh
pip install -r requirements.txt
```

## database testing setup
### installation
Install RobotFramework, DatabaseLibrary, and Pymysql (the database connector)
```sh
pip install robotframework
pip install robotframework-databaselibrary
pip install pymysql
```

### testing
To run the test, run the following command, replacing `{USERNAME}` and `{PASSWORD}` with your MySQL username and password.
```sh
robot -v DB_NAME:tsao -v DB_USER:{USERNAME} -v DB_PASSWORD:{PASSWORD} tests.robot
```
> [!IMPORTANT]  
> Do not push testing artefacts into this repository.
> 
> Consider adding the `--outputdir` flag to pass in an output directory.

## backend testing setup
### installation
Install RobotFramework, DatabaseLibrary, and Pymysql (the database connector)
```sh
pip install robotframework
pip install robotframework-requests
```

### testing
To run the test, run the following command.
```sh
robot tests.robot
```
> [!IMPORTANT]  
> Do not push testing artefacts into this repository.
> 
> Consider adding the `--outputdir` flag to pass in an output directory.

## frontend testing setup
```sh
pip install robotframework
pip install robotframework-seleniumlibrary
```

### testing
Deploy the frontend site onto `localhost:8080`.
> [!NOTE]  
> You will need the backend and database to be set up.
> - Frontend tests will not work without the full stack set up.

To run the test, run the following command, replacing `{BROWSER}` with the browser.
> Supported browsers
> - Chrome (`BROWSER:chrome`)
> - Firefox (`BROWSER:firefox`)

> [!CAUTION]
> The Firefox implementation is currently broken.

```sh
robot -v BROWSER:{BROWSER} --outputdir results/ tests/test.robot
```

## maintainers
- [Yee Jia Chen](https://github.com/jiachenyee) S10219344C
- [Isabelle Pak Yi Shan](https://github.com/isabellepakyishan) S10222456J
- [Ho Kuan Zher](https://github.com/Kuan-Zher) S10223870D
- [Cheah Seng Jun](https://github.com/DanielCheahSJ) S10227333K
- [Chua Guo Jun](https://github.com/GuojunLoser) S10227743H
