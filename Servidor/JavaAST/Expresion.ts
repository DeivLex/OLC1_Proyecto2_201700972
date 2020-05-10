import { NodoAST } from "./NodoAST";

interface Expresion extends NodoAST{
    operar():Object;
}
export {Expresion}; 