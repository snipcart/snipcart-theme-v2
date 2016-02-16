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
