'use strict';

require('./index.html');
require('./media/result-intro.mp4');
import './css/fonts.css';
import './css/style.css';

var Elm = require('./Main.elm');
var embedNode = document.getElementById('elm-app');

var app = Elm.Main.embed(embedNode);
