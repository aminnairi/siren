## Issue

Open or choose an issue to fix.

## Fork

Fork the project to your own repository.

## Requirements

- [GNU Make](https://www.gnu.org/software/make/)
- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)

## Installation

```console
$ git clone https://github.com/YOURUSERNAME/siren.git
```

Where `YOURUSERNAME` is your username.

## Branch

```console
$ git checkout -b branch-name
```

Where `branch-name` is the name of the branch that will fix the issue.

## Dependencies installation

```console
$ make
```

Or

```console
$ make install
```

## Reactor

```console
$ make reactor
```

The application will be available through the IP address: http://127.0.0.1:8000/. Make sure the port `8000` is not already taken by another application before running this command.

## Fix the issue

Append changes until the issue is fixed.

## Build

```console
$ make build
```

## Commit

Commit your changes with clear commit message that describe best what you did on each updated files.

## Push

```console
$ git push --set-upstream-to origin branch-name
```

Where `branch-name` is the name of the branch your previously created

## Pull Request

Propose your changes via a pull request. Link your pull request to an issue to fix. Pull requests that do not link to an active issue will not be accepted.
