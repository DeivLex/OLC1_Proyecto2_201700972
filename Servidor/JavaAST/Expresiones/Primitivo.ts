import { Expresion } from "../Expresion";

class Primitivo implements Expresion {
        
    private valor:Object;
    private linea:number;
    private tipo:Primitivo.tipo_p;

    constructor(tipo:Primitivo.tipo_p,valor:object,linea:number){
        this.valor=valor;
        this.linea=linea;
        this.tipo=tipo;
    }

    operar(): Object {
        if(this.tipo==Primitivo.tipo_p.DOUBLE || this.tipo==Primitivo.tipo_p.INT){
            return Number(this.valor);
        }
        return 0;
    }

    getlinea(): number {
        return this.linea;
    }
}

module Primitivo{
    export enum tipo_p{
        DOUBLE,//0
        INT//1
    }
}
export{Primitivo};