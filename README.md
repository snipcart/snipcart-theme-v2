# snipcart-theme

This repository contains everything needed to generate a `snipcart.css` file.
​
## Installation
​
To get started with this project you'll need to install npm packages.
​
```sh
npm install
```
​
## Setup development environment
​
**Gulp** is the build tool used for this project. To setup a development environment, we suggest using the default `gulp` method. It will watch for file changes and recompile the CSS output automatically.
​
```sh
gulp
```
​
You may also use the `sync` task. This can be useful if you are working on a customization for a specific project. You can use the `proxy` flag to specify which URL [Browsersync](https://www.browsersync.io/) should start a proxy over.
​
```sh
gulp sync --proxy https://snipcart.com
```
​
By default, Browsersync will serve the content on `localhost:3006`. If you wish to use this setup on the application you are building you can add `snipcart.css` reference on this path:
​
```html
<link href="http://localhost:3006/themes/base/snipcart.css" rel="stylesheet" type="text/css" />
```
​
## Deploy assets
​
To generate assets to be deployed, you can use the `deploy` gulp task. This task will make sure to copy files needed to `dist` folder and `snipcart.css` + `snipcart.min.css`. Images, fonts, and more will also be copied to the `dist` folder.
​
You may use the `version` flag to create a version directory inside the `dist` folder.
​
```sh
gulp deploy --version 1.2.3
```
​
The example above would generate the following directory structure:
​
```
dist
└───themes
    └───1.2.3
        └───base
            │   snipcart.css
            │   snipcart.min.css
            ├───fonts
            └───img
```
​
## Branches
​
The default branch is `master`. Consider it as the latest stable version.
​
We also keep branches for specific versions:
​
- `v1.0`
