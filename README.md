# REST API Test Automation | Robot Framework

A personal QA Automation project focused on testing REST APIs using **Robot Framework and Python**.

I adapted an existing open-source testing framework to work with [JSONPlaceholder](https://jsonplaceholder.typicode.com), with the goal of practicing API testing, reusable test architecture, JSON Schema validation, and CI/CD.

## Tech Stack

- **Automation:** Robot Framework, Python, RequestsLibrary
- **API Testing:** GET, POST, PUT, PATCH, DELETE
- **Validation:** JSONLibrary, JSON Schema, HTTP assertions
- **CI/CD:** GitHub Actions
- **Version Control:** Git & GitHub

## What I Implemented

- Automated functional tests for Posts, Users, and Comments.
- Positive and negative test scenarios, including invalid IDs and HTTP 404 responses.
- JSON Schema validation for API response structures.
- Reusable keywords and external JSON test data.
- Automated test execution through GitHub Actions.
- HTML test reports for analyzing execution results.

## Project Structure

```text
resources/
  base.resource       # API configuration
  services.resource   # Reusable HTTP keywords
  helpers.resource    # JSON utilities
  fixtures/           # Test data
  schemas/            # JSON Schemas

tests/
  posts.robot
  users.robot
  comments.robot
  schema.robot

.github/workflows/     # CI/CD pipeline
requirements.txt
```

## Run the Tests

```powershell
python -m venv .venv
.\.venv\Scripts\Activate.ps1
pip install -r requirements.txt
robot -d reports tests
```

Reports are generated in `reports/`:

- `report.html`
- `log.html`
- `output.xml`

## CI/CD

GitHub Actions runs the automated test suites on pushes and pull requests to `main` and uploads test reports as workflow artifacts.

**Note:** JSONPlaceholder simulates POST, PUT, PATCH, and DELETE operations. Changes are not persisted.

## Credits

This project is adapted from [Thiago Nogueira dos Santos' Robot-API-Tests](https://github.com/thinogueiras/Robot-API-Tests).

The original MIT license and copyright notice are preserved in [LICENSE](LICENSE).

## Author

**Fatima Bousmiti**  
Computer Engineering Student | QA Automation

[LinkedIn](https://linkedin.com/in/fatima-bousmiti-a845292a7 ) · [GitHub](https://github.com/FATIMA-BOUSMITI)

