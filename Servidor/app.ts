import * as express from "express";
import * as cors from "cors";
import * as bodyParser from "body-parser";
import { Errores } from "./JavaAST/Errores";

let lista: Array<string>;

const gramatica = require('./AnalizadorJava/GramaticaJava');
var resultado="";
var resultadoCopia="";
var app=express();
app.use(bodyParser.json());
app.use(cors());
app.use(bodyParser.urlencoded({ extended: true }));

app.post('/Cargar/', function (req, res) {
    var entrada=req.body.text;
    resultado=parser(entrada);
    res.send(resultado.toString()); 
});

app.post('/CargarCopia/', function (req, res) {
    var entrada=req.body.text;
    resultadoCopia=parser(entrada);
    res.send(resultadoCopia.toString()); 
});

app.get('/Arbol/', function (req, res) {
    res.send(resultado.toString()); 
});

app.get('/Copia/', function (req, res) {
    res.send(resultado.toString()+"&_&_&"+resultadoCopia.toString()); 
});

app.get('/Error/', function (req, res) {
    res.send(Errores.geterror()); 
});

/*---------------------------------------------------------------*/
var server = app.listen(8080, function () {
    console.log('Servidor escuchando en puerto 8080...');
});

/*---------------------------------------------------------------*/
function parser(texto:string) {
    try {
        return gramatica.parse(texto);
    } catch (e) {
        return "Error en compilacion de Entrada: "+ e.toString();
    }
}
