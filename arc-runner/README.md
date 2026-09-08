# ARC Runner Image

Based on `ghcr.io/actions/actions-runner:latest` with additional tools installed.

## Installed Tools

- **gh**: GitHub CLI
- **shellcheck**: Shell script static analysis
- **build-essential**: make, gcc, and other compilation tools
- **dirmngr**: GnuPG keyserver access (needed for GPG signature verification, e.g. the SonarQube scanner)
- **docker-compose-v2**: Docker Compose via `docker compose` CLI
- **python-is-python3**: Makes `python` point to `python3`
- **python3-yaml**: Python YAML library
- **python3-venv**: Python virtual environments
- **pipx**: Install Python applications in isolated environments
- **npm**: Node.js package manager
- **s3cmd**: S3 command-line tool
- **yamllint**: YAML linter

## Building Locally

```bash
docker build -t arc-runner:local ./arc-runner
```
