"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var Primitivo = /** @class */ (function () {
    function Primitivo(tipo, valor, linea) {
        this.valor = valor;
        this.linea = linea;
        this.tipo = tipo;
    }
    Primitivo.prototype.operar = function () {
        if (this.tipo == Primitivo.tipo_p.DOUBLE || this.tipo == Primitivo.tipo_p.INT) {
            return Number(this.valor);
        }
        return 0;
    };
    Primitivo.prototype.getlinea = function () {
        return this.linea;
    };
    return Primitivo;
}());
exports.Primitivo = Primitivo;
(function (Primitivo) {
    var tipo_p;
    (function (tipo_p) {
        tipo_p[tipo_p["DOUBLE"] = 0] = "DOUBLE";
        tipo_p[tipo_p["INT"] = 1] = "INT"; //1
    })(tipo_p = Primitivo.tipo_p || (Primitivo.tipo_p = {}));
})(Primitivo || (Primitivo = {}));
exports.Primitivo = Primitivo;
