"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var express = require("express");
var cors = require("cors");
var bodyParser = require("body-parser");
var gramatica = require("./AnalizadorJava/GramaticaJava");
var Errores_1 = require("./JavaAST/Errores");
var app = express();
app.use(bodyParser.json());
app.use(cors());
app.use(bodyParser.urlencoded({ extended: true }));
app.post('/Calcular/', function (req, res) {
    var entrada = req.body.text;
    var resultado = parser(entrada);
    Errores_1.Errores.clear();
    res.send(resultado.toString());
});
/*---------------------------------------------------------------*/
var server = app.listen(8080, function () {
    console.log('Servidor escuchando en puerto 8080...');
});
/*---------------------------------------------------------------*/
function parser(texto) {
    try {
        return gramatica.parse(texto);
    }
    catch (e) {
        return "Error en compilacion de Entrada: " + e.toString();
    }
}
