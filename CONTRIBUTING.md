## Issue

Open or choose an issue to fix.

## Fork

Fork the project to your own repository.

## Requirements

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
$ docker-compose run --rm npm install
```

## Watch

```console
$ docker-compose run --rm --service-ports npm run watch
```

The application will be available through the IP address: http://127.0.0.1:8000/. Make sure the port `8000` is not already taken by another application before running this command. The server will be live reloaded using the port `35729`.

## Fix the issue

Append changes until the issue is fixed.

## Development

```console
$ docker-compose run --rm npm run development
```

This will allow you to serve the application using your favorite HTTP server to see if everything is OK. The development build will be available in the `docs` folder.

## Format

```console
$ docker-compose run --rm npm run format
```

This will format the `Main.elm` file according to the Elm style.

## Production

```console
$ docker-compose run --rm npm run production
```

This will allow you to serve the application using your favorite HTTP server to see if everything is OK. The optimized build will be available in the `docs` folder.

## Commit

Commit your changes with clear commit message that describe best what you did on each updated files.

## Push

```console
$ git push --set-upstream-to origin branch-name
```

Where `branch-name` is the name of the branch your previously created

## Pull Request

Propose your changes via a pull request. Link your pull request to an issue to fix. Pull requests that do not link to an active issue will not be accepted.
