require('../scss/styles.scss');

// index.js
'use strict';

var Elm = require('./index.elm');
var mountNode = document.getElementById('elm-app');

// The third value on embed are the initial values for incomming ports into Elm
var app = Elm.Main.embed(mountNode);
