"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var Variable = /** @class */ (function () {
    function Variable(valor, linea, tipo) {
        this.valor = valor;
        this.linea = linea;
        this.tipo = tipo;
    }
    Variable.prototype.getlinea = function () {
        return this.linea;
    };
    return Variable;
}());
exports.Variable = Variable;
