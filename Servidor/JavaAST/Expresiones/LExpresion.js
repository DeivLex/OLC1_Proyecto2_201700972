"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var LExpresion = /** @class */ (function () {
    function LExpresion(exp, linea) {
        this.exp = exp;
        this.linea = linea;
    }
    LExpresion.prototype.operar = function () {
        return this.exp.operar();
    };
    LExpresion.prototype.getlinea = function () {
        return this.linea;
    };
    return LExpresion;
}());
exports.LExpresion = LExpresion;
