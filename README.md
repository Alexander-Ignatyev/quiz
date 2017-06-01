# Quiz

A simple serverless web application written on [Elm](http://elm-lang.org/).

This is trivial implementation of quiz tool. All tests are defined in `public/data/tests.json` file.

The running appliucation is available at: https://quiz.aligus.net/


## Project structure

* public
* * assets
* * data
* src

`public` folder contains all files needed to run the application: html, CSS and JavaScript files.

`src` folder has Elm source code. The source code compiles to `public/assets/js/elm.js` file.


## Build and run app

To build the application simply execute:

```bash
make
```
It will build the application (precisely speaking it will generate a JavaScript file) and start web server. You can access quiz app by http://localhost:8000/public/index.html


To compress the generated JavaScript file and can use [UglifyJS](https://github.com/mishoo/UglifyJS).

You might need to install node.js if you still do not have it: https://nodejs.org/en/download/.

```bash
npm install uglify-js -g   # Install UglifyJS
make compress              # Compress the JS file
```
