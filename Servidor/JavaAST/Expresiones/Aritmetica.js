"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var Aritmetica = /** @class */ (function () {
    function Aritmetica(izq, der, tipo_op, linea) {
        this.izq = izq;
        this.der = der;
        this.tipo_op = tipo_op;
        this.linea = linea;
    }
    Aritmetica.prototype.operar = function () {
        var izq1 = (this.izq == null) ? null : this.izq.operar();
        var der1 = (this.der == null) ? null : this.der.operar();
        if (this.tipo_op == Aritmetica.tipo_a.SUMA) {
            return Number(izq1) + Number(der1);
        }
        else if (this.tipo_op == Aritmetica.tipo_a.RESTA) {
            return Number(izq1) - Number(der1);
        }
        else if (this.tipo_op == Aritmetica.tipo_a.MULTIPLICACION) {
            return Number(izq1) * Number(der1);
        }
        else if (this.tipo_op == Aritmetica.tipo_a.DIVISION) {
            var div = Number(der1);
            if (div == 0.0) {
                div = 1;
            }
            return Number(izq1) / div;
        }
        else {
            return 1;
        }
    };
    Aritmetica.prototype.getlinea = function () {
        return this.linea;
    };
    return Aritmetica;
}());
exports.Aritmetica = Aritmetica;
(function (Aritmetica) {
    var tipo_a;
    (function (tipo_a) {
        tipo_a[tipo_a["SUMA"] = 0] = "SUMA";
        tipo_a[tipo_a["RESTA"] = 1] = "RESTA";
        tipo_a[tipo_a["MULTIPLICACION"] = 2] = "MULTIPLICACION";
        tipo_a[tipo_a["DIVISION"] = 3] = "DIVISION"; //3
    })(tipo_a = Aritmetica.tipo_a || (Aritmetica.tipo_a = {}));
})(Aritmetica || (Aritmetica = {}));
exports.Aritmetica = Aritmetica;
