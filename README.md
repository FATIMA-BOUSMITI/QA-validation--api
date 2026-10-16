# Robot Framework API Automation Testing

API test automation for [JSONPlaceholder](https://jsonplaceholder.typicode.com),
a public REST API used for testing and prototyping. The project uses Robot
Framework and RequestsLibrary to exercise resource retrieval and simulated
write operations, and validates collection responses against JSON Schemas.

This repository is an adaptation of
[Thiago Nogueira dos Santos' Robot-API-Tests](https://github.com/thinogueiras/Robot-API-Tests),
which originally tested the Barriga REST API. The API-specific resources, test
scenarios, fixtures, schemas, and CI workflow have been adapted for
JSONPlaceholder. The original MIT license and copyright notice are retained in
[LICENSE](LICENSE).

## Project Overview

The suite verifies documented JSONPlaceholder response behavior without API
credentials. It covers HTTP status codes and response data for `posts`, `users`,
and `comments`, plus schema checks for all three collection endpoints.

JSONPlaceholder simulates write operations rather than persisting changes.
POST, PUT, PATCH, and DELETE tests therefore validate the responses returned by
the API; they do not expect later requests to observe modified data.

## Tech Stack

- Python 3.11 (the version configured for CI)
- Robot Framework 7
- RequestsLibrary for HTTP requests
- JSONLibrary and JSON Schema for response validation
- GitHub Actions for continuous integration

Dependencies are pinned in [requirements.txt](requirements.txt). No API keys or
GitHub secrets are needed.

## Test Architecture

```text
.
├── .github/workflows/continuous-testing.yml
├── resources/
│   ├── base.resource          # API URL and reusable HTTP session
│   ├── services.resource      # Generic GET, POST, PUT, PATCH, DELETE keywords
│   ├── helpers.resource       # Fixture loading and JSON field helpers
│   ├── fixtures/              # Request payloads and resource IDs
│   └── schemas/               # Collection response JSON Schemas
├── tests/
│   ├── posts.robot
│   ├── users.robot
│   ├── comments.robot
│   └── schema.robot
├── requirements.txt
└── README.md
```

Service keywords issue requests with `expected_status=any`. Test cases own the
status and response assertions, keeping HTTP operations separate from
verification. Fixtures hold test data outside the test logic.

## API Endpoints Tested

| Resource | Endpoints |
| --- | --- |
| Posts | `GET /posts`, `GET /posts/{id}`, `POST /posts`, `PUT /posts/{id}`, `PATCH /posts/{id}`, `DELETE /posts/{id}` |
| Users | `GET /users`, `GET /users/{id}` |
| Comments | `GET /comments`, `GET /comments/{id}` |

For each resource, a GET by a known missing ID also checks the not-found
response. Collection GETs for posts, users, and comments are validated against
their respective JSON Schemas.

## Test Scenarios

- Retrieve post, user, and comment collections and individual resources.
- Verify a not-found response for a nonexistent resource ID.
- Create, replace, partially update, and delete a post; assert status and
  response content.
- Validate collection JSON structures against the posts, users, and comments
  schemas.
- Use `smoke`, `regression`, `positive`, `negative`, and `schema` tags to select
  relevant scenarios.

## Test Execution

### Windows PowerShell

From the project root, check Python, create and activate a virtual
environment, then install the pinned dependencies:

```powershell
python --version
python -m venv .venv
.\.venv\Scripts\Activate.ps1
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
```

Use Python 3.11 locally if you want to match CI. To run tests without
activating the environment:

```powershell
.\.venv\Scripts\robot.exe --outputdir reports tests
```

Run one suite or select by tag:

```powershell
robot --outputdir reports tests\posts.robot
robot --outputdir reports --include smoke tests
```

### Linux and macOS

```bash
python3.11 -m venv .venv
source .venv/bin/activate
python -m pip install -r requirements.txt
robot --outputdir reports tests
```

Robot Framework returns a non-zero exit code when tests fail.

## GitHub Actions CI Pipeline

The workflow at
[.github/workflows/continuous-testing.yml](.github/workflows/continuous-testing.yml)
runs on pushes and pull requests targeting `main`. It uses `ubuntu-latest`,
sets up Python 3.11, installs `requirements.txt`, and executes all test suites.
A test failure fails the workflow job.

The setup-python pip cache is enabled and keyed from `requirements.txt`, so the
cache is refreshed when the dependency manifest changes. This speeds up
dependency installation without changing the test environment's declared
dependencies.

## Pip Cache Management

GitHub Actions caches pip's package download cache using the dependency file as
the cache key input. There is no committed virtual environment or local
dependency cache. To update dependencies, edit `requirements.txt`; the CI cache
will then be refreshed for the new manifest.

## Test Reports

The workflow writes `report.html`, `log.html`, and `output.xml` under `reports/`.
It uploads them as the `robot-framework-reports` artifact even if tests fail.
Open the workflow run on GitHub and download the artifact from its **Artifacts**
section. Locally generated reports are excluded from Git by `.gitignore`.

## Future Improvements

- Add further endpoint and query-parameter coverage where behavior is
  documented by JSONPlaceholder.
- Add negative request-body scenarios without asserting undocumented business
  rules.

## Credits and License

Adapted from
[thinogueiras/Robot-API-Tests](https://github.com/thinogueiras/Robot-API-Tests),
created by Thiago Nogueira dos Santos. The original MIT license and its
copyright notice are preserved in [LICENSE](LICENSE).

## Publishing This Project

Create a **public, empty** repository named `robot-framework-api-automation`
under the GitHub account `FATIMA-BOUSMITI`. After reviewing the changes and
authorizing publication, connect this local branch to the new repository and
push it:

```powershell
git remote set-url origin https://github.com/FATIMA-BOUSMITI/robot-framework-api-automation.git
git remote -v
git push -u origin main
```

The remote change and push are intentionally not performed as part of preparing
this repository.
