"use strict";
var __extends = (this && this.__extends) || (function () {
    var extendStatics = function (d, b) {
        extendStatics = Object.setPrototypeOf ||
            ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
            function (d, b) { for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p]; };
        return extendStatics(d, b);
    };
    return function (d, b) {
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();
Object.defineProperty(exports, "__esModule", { value: true });
var Errores = /** @class */ (function (_super) {
    __extends(Errores, _super);
    function Errores() {
        return _super.call(this) || this;
    }
    Errores.add = function (err) {
        this.prototype.push(err);
    };
    Errores.verificarerror = function () {
        if (this.prototype.length > 0) {
            return "Se Detectaron Errores de Compilacion";
        }
        return "Compilacion Sin Errores";
    };
    Errores.geterror = function () {
        var cad = "";
        cad += "<html>\n";
        cad += "<header>\n";
        cad += "<title>Reporte Errores</title>\n";
        cad += "</header>\n";
        cad += "<body background=\"gray\">\n";
        cad += "<div align=\"center\">\n";
        cad += "<h1>Reporte de Errores de Compilacion</h1>\n";
        cad += "<table border=\"2\" align=\"center\">\n";
        cad += "<tr>\n";
        cad += "<th>TIPO DE ERROR</th><th>DESCRIPCION</th><th>LINEA</th>\n";
        cad += "</tr>\n";
        for (var i = 0; i < this.prototype.length; i++) {
            cad += "<tr>\n";
            cad += "<td>" + this.prototype[i].gettipo() + "</td><td>" +
                this.prototype[i].getdescripcion() + "</td><td>" +
                this.prototype[i].getlinea() + "</td>\n";
            cad += "</tr>\n";
        }
        cad += "</table>\n";
        cad += "</div>\n";
        cad += "</body>\n";
        cad += "</html>\n";
        return cad;
    };
    Errores.clear = function () {
        while (this.prototype.length > 0) {
            this.prototype.pop();
        }
    };
    return Errores;
}(Array));
exports.Errores = Errores;
