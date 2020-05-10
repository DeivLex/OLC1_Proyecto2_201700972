import { Expresion } from "../Expresion";

class LExpresion implements Expresion{

    private linea:number;
    private exp: Expresion;

    constructor(exp: Expresion, linea:number){
        this.exp=exp;
        this.linea=linea;
    }

    operar(): Object {
        return this.exp.operar();
    }

    getlinea(): number {
        return this.linea;
    }
}
export{LExpresion};