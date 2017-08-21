'use strict';

require('./index.html');
import './css/fonts.css';
import './css/style.css';

var Elm = require('./Main.elm');
var embedNode = document.getElementById('elm-app');

var app = Elm.Main.embed(embedNode);
