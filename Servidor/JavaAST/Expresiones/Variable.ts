class Variable {
        
    private valor:string;
    private linea:number;
    private tipo:string;

    constructor(valor:string,linea:number,tipo:string){
        this.valor=valor;
        this.linea=linea;
        this.tipo=tipo;
    }

    getlinea(): number {
        return this.linea;
    }
}

export{Variable};