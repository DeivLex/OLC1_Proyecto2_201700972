"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var NodoError = /** @class */ (function () {
    function NodoError(tipo, descripcion, linea) {
        this.tipo = tipo;
        this.descripcion = descripcion;
        this.linea = (linea + 1);
    }
    NodoError.prototype.gettipo = function () {
        return this.tipo;
    };
    NodoError.prototype.getdescripcion = function () {
        return this.descripcion;
    };
    NodoError.prototype.getlinea = function () {
        return this.linea;
    };
    return NodoError;
}());
exports.NodoError = NodoError;
