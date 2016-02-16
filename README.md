# snipcart-themes

[![Build status](https://ci.appveyor.com/api/projects/status/q0qxt370jxpx1139?svg=true)](https://ci.appveyor.com/project/spektrum/snipcart-themes)

This repository contains everything needed to generate snipcart.css file. Ultimately, it could also contains custom themes.

## Installation

To get started with this project you'll need to install npm packages.

```sh
npm install
```

## Setup development environment

Gulp is the build tool used for this project. To setup a development environment we suggest you using the default `gulp` method. It will watch file changes and recompile the CSS output automatically.

```sh
gulp
```

## Deploy assets

To generate assets to be deployed you can use the `deploy` gulp task. This task will make sure to copy files needed to `dist` folder and also `snipcart.css` and `snipcart.min.css`. Images, fonts, etc will be also copied to the dist folder.

If you need to generate a specific version of the assets, you can use the `--version` arguments.

```sh
gulp deploy --version 1.2.3
```

The example above would generate the following directory structure:

```
themes
└───1.2.3
    └───base
        │   snipcart.css
        │   snipcart.min.css
        ├───fonts
        └───img
```

## Branches

The default branch is `master`. Consider it as the latest stable version.

You can use the `staging` branch to push assets to a non public blob storage account if you need to.

We also keep branches for specific versions.

- `v1.0`

You can push to those branches at any time to update a specific version. You might need to merge the changes you will do to `master` but it's possible that the version branches will diverge with time.

## Deployment

Assets will be deployed to an Azure Blob Storage account.

Production account: *snipcartpublic (cdn.snipcart.com)*
Staging account: *snipcartcdndev (snipcartcdnstaging-10f3.kxcdn.com)*

Both storage accounts are exposed via a CDN endpoint on KeyCDN.com.

Whenever you push to `master` or a version branch, the assets will be deployed.
