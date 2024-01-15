# tsao tests
## contents
- [database testing setup](#database-testing-setup)
- [frontend testing setup](#frontend-testing-setup)

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
> ⚠️ Do not push testing artefacts into this repository.
> 
> Consider adding the `--outputdir` flag to pass in an output directory.

## frontend testing setup
```sh
pip install robotframework
pip install robotframework-seleniumlibrary
```

## testing
Deploy the frontend site onto `localhost:8080`.
> ⚠️ You will need the backend and database to be set up.
> - Frontend tests will not work without the full stack set up.

To run the test, run the following command, replacing `{BROWSER}` with the browser.
> Supported browsers
> - Chrome (`BROWSER:chrome`)
> - Firefox (`BROWSER:firefox`)

```sh
robot -v BROWSER:{BROWSER} --outputdir results/ tests/test.robot
```
