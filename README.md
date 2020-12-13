# GitHub Repo Starter Template

A starter repo for new projects. Adds CI and build/release defaults, and setup instructions using good practices.

It currently includes:

- Setup instructions for a new repo
- Repo configurations for
    - Having a protected and clean `main` branch
    - Disabling undesirable GitHub features (i.e. wiki, etc.)
- GitHub Actions for 
    - Pull request status checks, at PR creation and update (i.e. where you might want to run tests)
    - Automatically tag changes to the `main` branch based on auto-incremented [SemVer](https://semver.org) version numbers
    - ^ Then publish your build artifacts for that version tag
- For web apps:
    - Dockerfile and Docker Compose (with PostgreSQL and Redis commented out defaults)
- For native mobile apps:
    - (nothing yet)

## Instructions

This will guide you through getting setup with this repo's default files and practices. Skip a step or remove config files as relevant to your own workflows and needs.

### Getting started / Creating a new repo

This will setup a new repo with the files from within this one.

1. [Create a new repo via import](https://github.com/new/import)
1. In **Your old repository's clone URL** enter this repo's HTTPS URL: `https://github.com/jeffmaher/github-starter-template.git`
1. Add an owner, repo name, and privacy level; then click **Begin Import**.
1. Wait a moment; take a quick tea break. ☕️

### Repo configuration

#### Configure pull request merging

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

Additionally, all of the provided pull request steps rely on CI script skeletons that are stored in the `ci` folder. It's a good practice to use these scripts, which makes for easier and consistent runs between GitHub Actions and local runs before committing.

Lastly, these instructions assume you're using a web application via Docker container. If that's not the case (i.e. mobile apps, not using Docker, etc.), remove the following text from each step to just leverage the shell script skeletons: `docker-compose -f docker-compose.yml -f ci/docker-compose.ci.yml run app` (i.e. leave `sh ci/<script>.sh`).

_Note: To make the next section easier for requiring status checks, create one pull request to trigger the PR checks._

#### Protect your `main` Branch

To ensure that anything that gets merged to your `main` branch goes through peer review, perform the following steps:

1. In your web browser, go to your repo
1. Go to your repo's **Settings** section
1. Go to **Branches**
1. Choose **Add rule** in the **Branch protection rules** section
1. Configure the following settings, then click **Create** (leave a setting as the default if not mentioned):
    - Branch name pattern: `main`
    - [X] Require pull request reviews before merging
        - [X] Dismiss stale pull request approvals when new commits are pushed
        - [X] Requre review from Code Owners (TODO: Add instructions for this)
    - [X] Require status checks to pass before merging
        - [X] Require branches to be up to date before merging
            - _(After your first pull request, come back here and select required checks)_
    - [X] Require signed commits _(Optional: if you want your commits to be end-to-end encrypted in transit)_
    - [X] Include administrators

#### Automate versioning of your `main` branch and publish build artifacts

Doing these steps will automatically version your `main` branch whenever you merge a pull request to it (i.e. cut a version whenever the code changes) using a [SemVer-style versioning scheme](https://semver.org). This will help with the creation and labeling of build artifacts, make it easier for release processes and managers to deploy deliberate versions of the codebase, and make investigation and fixing of the issues simpler since you'll know exactly what the code looked like for any deployed artifact.

Start by adding some release labels:

1. In your web browser, go to your repo
1. Go to the **Issues** tab
1. Go to the **Labels** tab
1. Add the following **New label**s:
    - `release-major`
    - `release-minor`
    - `release-patch`
1. Enable the `one_release_label` PR status check as mandatory on any PRs to your `main` branch (see [Protect your `main` branch for instructions](#protect-your-main-branch)).
1. Create a `0.0.0` tag on your repo (you can do this from the **Releases** section of your repo on GitHub)
1. Next time you merge a PR to `main`, a new version tag will get cut incrementing from the last highest version number AND it will run the [build/publish script](ci/publish_build.sh) (which you should setup with the appropriate commands).

#### Turn off GitHub Wiki

Wikis created via GitHub Wiki's tab aren't easy to backup, aren't version controlled in the same stream as the code (i.e. which version of the code does your wiki doc belong to?), and don't have pull requests as a change control mechanism. The feature is better left off and documentation can be stored in the `docs` folder and referenced images for documentation can be put into `docs/images`.

To make sure folks don't use the GitHub Wiki feature, turn it off with the following steps:

1. From your repository's page, go to **Settings**.
1. From the **Features** section, uncheck **Wikis**.

### For web applications

These next instructions 

#### Use PostgreSQL and Redis

Lots of web applications use PostgreSQL and Redis for their database and session stores, respetively. If this is your case, see [`docker-compose.yml`](docker-compose.yml) to uncomment lines that include this in your Docker Compose setup.

