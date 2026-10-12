# wonderbound

ADAPT-standard PHP application.

## Structure

- `public/` — web document root, frontend, and API endpoints
- `src/application/` — application logic
- `src/dal/` — database access
- `src/services/` — external services and data files
- `src/support/` — shared support code
- `config/` — application configuration
- `data/` — project data
- `db/` — database scripts
- `infra/` — packaging and deployment files

## Local development

Run `make run` to start PHP's built-in development server on port 8090.
Stop it with Ctrl+C. Container configuration can be added later.
