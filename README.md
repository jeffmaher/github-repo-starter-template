# GitHub Repo Starter Template

A starter repo for new projects. Adds CI and build/release defaults, and setup instructions using good practices.

It currently includes:

- Instructions to get started
- Pull request creation and updates (i.e. where you might want to run tests)
- Protecting your `main` branch
- Dockerfile and Docker Compose (with PostgreSQL and Redis commented out defaults)

## Instructions

This will guide you through getting setup with this repo's default files and practices. Skip a step or remove config files as relevant to your own workflows and needs.

### Create a new repo

This will setup a new repo with the files from within this one.

1. [Create a new repo via import](https://github.com/new/import)
1. In **Your old repository's clone URL** enter this repo's HTTPS URL: `https://github.com/jeffmaher/github-starter-template.git`
1. Add an owner, repo name, and privacy level; then click **Begin Import**.
1. Wait a moment; take a quick tea break. ☕️


### Configure Pull Request Merging

By only allowing squash merging in pull requests, your changes will only be merged in as atomic commits and reduces the amount of noise in your commit log. This makes it easier to rollback changes and see when your `main` branch definitely changed.

To do this, follow these steps:

1. From your repository's page, go to **Settings**.
2. From the **Merge button** section, have the following settings:
    - [ ] Allow merge commits
    - [X] Allow squash merging
    - [ ] Allow rebase merging
    - [X] Automatically delete head branches

The last checkbox makes sure you don't have a lot of dead branches lingering in your repository. 

### Configure pull requests checks

You'll likely be running tests or running static analysis tools when pull requests are created, updated (i.e. a new commit comes in), or re-opened (after being closed). For any job that you want GitHub Actions to run at pull request time, either modify or add steps to the [`.github/workflows/pull_request.yml`](.github/workflows/pull_request.yml) file. Commands in the file say how to do this.

Additionally, all of the provided pull request steps rely on CI script skeletons that are stored in the `/ci` folder. It's a good practice to use this scripts, which makes for easier and consistent runs between GitHub Actions and local runs before committing.

### Use PostgreSQL and Redis

Lots of web applications use PostgreSQL and Redis for their database and session stores, respetively. If this is your case, see [`docker-compose.yml`](docker-compose.yml) to uncomment lines that include this in your Docker Compose setup.

### Turn off GitHub Wiki

Wikis created via GitHub Wiki's tab aren't easy to backup, aren't version controlled in the same stream as the code (i.e. which version of the code does your wiki doc belong to?), and don't have pull requests as a change control mechanism. The feature is better left off and documentation can be stored in the `docs` folder and referenced images for documentation can be put into `docs/images`.

To make sure folks don't use the GitHub Wiki feature, turn it off with the following steps:

1. From your repository's page, go to **Settings**.
1. From the **Features** section, uncheck **Wikis**.