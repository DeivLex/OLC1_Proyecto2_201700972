import { Expresion } from "../Expresion";

class Aritmetica implements Expresion {

    private linea:number;
    private tipo_op: Aritmetica.tipo_a;
    private izq: Expresion;
    private der: Expresion;

    constructor(izq:Expresion, der:Expresion, tipo_op:Aritmetica.tipo_a, linea:number){
        this.izq=izq;
        this.der=der;
        this.tipo_op=tipo_op;
        this.linea=linea;
    }

    operar(): Object {
        var izq1 = (this.izq==null)?null:this.izq.operar();
        var der1 = (this.der==null)?null:this.der.operar();

        if(this.tipo_op==Aritmetica.tipo_a.SUMA){

            return Number(izq1) + Number(der1);

        }else if(this.tipo_op==Aritmetica.tipo_a.RESTA){

            return Number(izq1) - Number(der1);
            
        }else if(this.tipo_op==Aritmetica.tipo_a.MULTIPLICACION){

            return Number(izq1) * Number(der1);
            
        }else if(this.tipo_op==Aritmetica.tipo_a.DIVISION){

            var div = Number(der1);

            if(div == 0.0){
                div = 1;
            }

            return Number(izq1) / div;
            
        }else{
            return 1;
        }

    }

    getlinea(): number {
        return this.linea;
    }
}

module Aritmetica{
    export enum tipo_a{
        SUMA,//0
        RESTA,//1
        MULTIPLICACION,//2
        DIVISION//3
    }
}
export{Aritmetica};