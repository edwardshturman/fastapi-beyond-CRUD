# CS 486 Assignment 7: FastAPI Beyond CRUD

This is the source repository for my implementation of Assignment 7, which was to add a GitHub Actions workflow to [FastAPI Beyond CRUD](https://github.com/jod35/fastapi-beyond-CRUD) that verifies a PR against the Conventional Commits standard, runs `pytest` test cases, and builds the container image.

## Features

- Verifies a PR to `main` adheres to Conventional Commits and closes the PR if it doesn't
- Nightly builds at 12am PDT
- Runs the test suite as specified by `pytest`
- Auto-fails the workflow if either Conventional Commits or `pytest` fails
- Sends an email in addition to the GitHub notification on failure
- Builds a Docker image on success

## Challenges

- The usual Docker vs. localhost stuff: ironically, it did not, in fact, "work on my machine". Docker was much nicer.
- I kept running into issues around the `psycopg2` module and requiring an async database driver. The fix was using `postgresql+asyncpg://...` in my `DATABASE_URL` connection string.
- `pydantic` is set up to *expect* an `.env` file, rather than just reading system environment variables, so simply passing GitHub Secrets did not work. Instead, I appended to an `.env` before running `pytest:`

    ```bash
    echo "DATABASE_URL=${{ secrets.DATABASE_URL }}" >> .env
    ```

- I spent way more time on PR closing than was necessary. I searched around for an Action that could do it, until I remembered runners ship with the GitHub CLI, which has a `pr close` subcommand.

## Getting Started

```bash
git clone https://github.com/edwardshturman/fastapi-beyond-CRUD.git
cd fastapi-beyond-CRUD/
cp .env.example .env
docker compose up
```

It just works.
