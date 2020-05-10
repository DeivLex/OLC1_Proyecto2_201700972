import * as express from "express";
import * as cors from "cors";
import * as bodyParser from "body-parser";
import * as gramatica from "./AnalizadorJava/GramaticaJava";
import { Errores } from "./JavaAST/Errores";

var app=express();
app.use(bodyParser.json());
app.use(cors());
app.use(bodyParser.urlencoded({ extended: true }));

app.post('/Calcular/', function (req, res) {
    var entrada=req.body.text;
    var resultado=parser(entrada);
    Errores.clear();
    res.send(resultado.toString());
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
