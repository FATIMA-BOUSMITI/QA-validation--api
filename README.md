# JSONPlaceholder API Automation Tests

Automated REST API tests built with Robot Framework and RequestsLibrary. The
suite targets [JSONPlaceholder](https://jsonplaceholder.typicode.com), a public
test API that does not require credentials.

This project is an adaptation of
[Thiago Nogueira dos Santos' Robot-API-Tests repository](https://github.com/thinogueiras/Robot-API-Tests),
originally created to test the Barriga REST API. It retains the original
project's MIT license; see [LICENSE](LICENSE). The Barriga-specific tests and
support data have been replaced with JSONPlaceholder scenarios.

## Requirements

- Python 3.11
- Internet access to `jsonplaceholder.typicode.com`

## Install on Windows

Run these commands from the project directory in PowerShell:

```powershell
py -3.11 -m venv .venv
.\.venv\Scripts\Activate.ps1
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
```

If PowerShell blocks activation, either adjust the execution policy for your
user or run the project's executables directly:

```powershell
.\.venv\Scripts\python.exe -m pip install -r requirements.txt
.\.venv\Scripts\robot.exe --outputdir reports tests
```

## Run the tests

Run the full suite and generate `output.xml`, `log.html`, and `report.html`
under `reports\`:

```powershell
robot --outputdir reports tests
```

Run a specific suite or tag:

```powershell
robot --outputdir reports tests\posts.robot
robot --outputdir reports --include smoke tests
```

Robot Framework returns a non-zero exit code when tests fail. The reports are
local generated files and are excluded from Git.

## Project structure

```text
.
├── .github\workflows\continuous-testing.yml
├── resources\
│   ├── base.resource
│   ├── services.resource
│   ├── helpers.resource
│   ├── fixtures\              # Request data and existing/missing resource IDs
│   └── schemas\               # JSON Schemas for posts, users, and comments
├── tests\
│   ├── posts.robot            # GET, POST, PUT, PATCH, DELETE and negative GET
│   ├── users.robot            # Collection, item, and not-found GETs
│   ├── comments.robot         # Collection, item, and not-found GETs
│   └── schema.robot           # Response schema validation
├── requirements.txt
└── README.md
```

The base resource creates a reusable HTTP session. Service keywords perform
HTTP operations and accept any status code so the test cases can assert status
and response content themselves. Helpers load JSON fixtures and extract JSON
fields. Schemas and fixtures are kept separate from test cases.

## Test coverage

- Posts: list, fetch by ID, fetch a nonexistent ID, create, replace, partially
  update, and delete.
- Users and comments: list, fetch by ID, and fetch a nonexistent ID.
- JSON Schema validation for the posts, users, and comments collections.
- Tests use `smoke`, `regression`, `positive`, `negative`, and `schema` tags.

JSONPlaceholder simulates write operations: POST, PUT, PATCH, and DELETE return
responses, but changes are not persisted to the API's collections. Accordingly,
the write tests verify the documented response status and representation; they
do not expect a later GET to show the changes.

## Continuous integration

GitHub Actions runs on pushes and pull requests targeting `main`. The workflow
sets up Python 3.11, installs `requirements.txt`, and runs all Robot suites.
The test command's exit code fails the job when a test fails. The
`robot-framework-reports` artifact contains `report.html`, `log.html`, and
`output.xml` and is uploaded even when the tests fail.

To view the reports on GitHub, open the workflow run under **Actions**, then
download **robot-framework-reports** from the run's artifacts section.

## Publish to your GitHub repository

This downloaded project folder currently has no `.git` directory. After
creating an empty repository on GitHub, initialize and connect it from
PowerShell (replace the URL with your own repository URL):

```powershell
git init
git add .
git commit -m "Adapt API automation tests to JSONPlaceholder"
git branch -M main
git remote add origin https://github.com/<YOUR-USERNAME>/<YOUR-REPOSITORY>.git
git push -u origin main
```

No API credentials or GitHub secrets are required to run the tests. GitHub
Actions starts after the first push to `main`; pull requests targeting `main`
also trigger the workflow.
