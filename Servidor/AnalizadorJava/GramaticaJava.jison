
/*------------------------------------------------IMPORTS----------------------------------------------*/
%{
    //let CErrores=require('../JavaAST/Errores');
    var lista_token = [];
    var list_var = "";
    var tipo_var = "";
%}

/*------------------------------------------------LEXICO------------------------------------------------*/

%lex
%%


\s+                                 // se ignoran espacios en blanco
"//".*                              // comentario simple línea
[/][*][^*]*[*]+([^/*][^*]*[*]+)*[/] // comentario multiple líneas
\"[^\"]*\"          %{  return 'cadena'; %}

"++"        return 'tk_incr'
"--"        return 'tk_decr'
"=="        return 'tk_igualdad'
"!="        return 'tk_dist'
">="     return 'tk_mayorig'
"<="     return 'tk_menorig' 
">"         return 'tk_mayor'
"<"         return 'tk_menor'
"*"     return 'tk_mul'
"/"     return 'tk_div'
"-"     return 'tk_res'
"+"     return 'tk_sum'

"("     return 'parentesis_izq'
")"     return 'parentesis_der'
"{"         return 'llave_izq'
"}"         return 'llave_der'
"&&"        return 'tk_and'
"||"        return 'tk_or'
"!"         return 'tk_not'
";"         return 'punto_coma'
","         return 'tk_coma'
":"         return 'tk_dpunt'
"="         return 'tk_igual'
"^"         return 'tk_pot'
"%"         return 'tk_mod' 
"."         return 'tk_punto'

"int"       return 'tk_INT'
"double"    return 'tk_DOUBLE'
"String"    return 'tk_STRING'
"char"      return 'tk_CHAR'
"boolean"   return 'tk_BOOL'

"true"      return 'tk_TRUE'
"false"     return 'tk_FALSE'
"while"     return 'tk_WHILE'
"if"        return 'tk_IF'
"else"      return 'tk_ELSE'
"for"       return 'tk_FOR'
"void"      return 'tk_VOID'
"case"      return 'tk_CASE'
"switch"    return 'tk_SW'
"default"   return 'tk_DEFA'
"break"     return 'tk_BRAKE'
"do"        return 'tk_DO'
"import"    return 'tk_IMP'
"return"    return 'tk_RETURN'
"main"      return 'tk_MAIN'
"System"    return 'tk_SYSTEM'
"out"       return 'tk_out'
"println"   return 'tk_PRINTLN'
"print"     return 'tk_PRINT'
"null"      return 'tk_NULL'


"class"     return 'tk_CLASS'
"continue"  return 'tk_CONTINUE'

[\t\r\n\f] %{ /*se ignoran*/ %}

[0-9]+"."[0-9]+     %{  return 'decimal';  %}
[0-9]+              %{  return 'entero';  %}
[A-Za-z"_"]+["_"0-9A-Za-z]* %{  return 'id' ;   %}
[\'][^\'\n][\']      %{  return 'char';   %}

[ \t\r\n\f] %{ /*se ignoran*/ %}

<<EOF>>     %{  return 'EOF';  %}

.          console.log("Error lexico:",yytext,"Linea:",yylineno);

/lex

/*--------------------------------------------------SINTACTICO-----------------------------------------------*/

%start S
%% 

S:EXP EOF {  return lista_token; };

EXP: IMPORTS EXP { }
   | CLASS EXP
   |;


IMPORTS: IMPORT IMPORTS { }
        | IMPORT;

IMPORT: tk_IMP id punto_coma;

CLASS:  tk_CLASS id llave_izq CUERPO_CLASS llave_der { lista_token.unshift("class-"+$2); } ;


CUERPO_CLASS: FUN_DE CUERPO_CLASS
            | ASIGNACION CUERPO_CLASS
            | MAIN CUERPO_CLASS
            | ;
FIN_FUN: parentesis_der llave_izq BFUN llave_der
        |LIST_PARAM FIN_FUN;

LIST_PARAM: TIPO id tk_coma LIST_PARAM 
          | TIPO id;

FUN_DE: tk_VOID id parentesis_izq FIN_FUN {lista_token.unshift("funcion-"+$2);}
        | TIPO id parentesis_izq FIN_FUN { lista_token.unshift("funcion-"+$2); }
        | TIPO LISTA_ID FIN_DE { tipo_var = $1; lista_token.unshift(tipo_var+"-"+list_var); list_var=""; };

FIN_DE:  punto_coma { }
        | tk_igual EXPRESION punto_coma {};

LISTA_ID:  id tk_coma LISTA_ID  { list_var+="."+$1; }
        | id { list_var+= $1; } ;



ASIGNACION: id tk_igual EXPRESION punto_coma      {   };





EXPRESION: EXPRESION tk_mayor EXPRESION     {   }
         | EXPRESION tk_menor EXPRESION     {   }
         | EXPRESION tk_menorig EXPRESION   {   }
         | EXPRESION tk_mayorig EXPRESION   {   }
         | EXPRESION tk_igualdad EXPRESION  {   }
         | EXPRESION tk_dist EXPRESION      {   }
         | EXPRESION tk_and EXPRESION      {   }
         | EXPRESION tk_or EXPRESION      {   }
         | tk_not EXPRESION                 {   }
         | EXPRESION tk_sum EXPRESION       {   }
         | EXPRESION tk_res EXPRESION       {   }
         | EXPRESION tk_mul EXPRESION       {   }
         | EXPRESION tk_div EXPRESION       {   }
         | EXPRESION tk_pot EXPRESION       {   }
         | EXPRESION tk_incr
         | EXPRESION tk_decr
         | tk_res EXPRESION  %prec UMINUS   {   }
         | parentesis_izq EXPRESION  parentesis_der   {   }
         | EXPRESION tk_res EXPRESION       {   }
         | id
         | tk_NULL
         | cadena
         | entero
         | decimal
         | char
         | boolean
         | tk_TRUE
         | tk_FALSE
         | CALL_FUNCT;


CALL_FUNCT: id parentesis_izq LISTA_EXP parentesis_der 
          | id parentesis_izq parentesis_der;

LISTA_EXP: EXPRESION tk_coma LISTA_EXP      {   }
         | EXPRESION             {   };



CONDICION: CONDICION OPERADOR CONDICION
         | NUMEROS OPERADORLOG NUMEROS
         | parentesis_izq CONDICION parentesis_der
         | tk_FALSE {   }
         | tk_TRUE  {   }
         | NUMEROS;


OPERADOR: tk_and
        | tk_or
        | tk_igualdad;

OPERADORLOG: tk_mayor
           | tk_menor
           | tk_menorig
           | tk_mayorig
           | tk_igualdad
           | tk_dist;
         
NUMEROS:parentesis_izq NUMEROS parentesis_der 
       |NUMEROS tk_sum NUMEROS       {   }
       | NUMEROS tk_res NUMEROS       {   }
       | NUMEROS tk_mul NUMEROS       {   }
       | NUMEROS tk_div NUMEROS       {   }
       | NUMEROS tk_pot NUMEROS       {   }
       | entero
       | tk_NULL
       | tk_not NUMEROS
       | CALL_FUNCT
       | id
       | cadena;

TERMINAL: id
        | cadena
        | entero
        | decimal
        | char
        | boolean;

RETURN: tk_RETURN EXPRESION punto_coma;

//COMPLETO Y REVISADO
IF_ELSE: tk_IF parentesis_izq CONDICION parentesis_der BLOQUE 
       | tk_IF parentesis_izq CONDICION parentesis_der BLOQUE IF_ELSE
       | tk_ELSE tk_IF parentesis_izq CONDICION parentesis_der BLOQUE 
       | tk_ELSE tk_IF parentesis_izq CONDICION parentesis_der BLOQUE IF_ELSE
       | tk_ELSE BLOQUE;


WHILE: tk_WHILE parentesis_izq CONDICION parentesis_der llave_izq CICLOS llave_der;

DO: tk_DO llave_izq CICLOS llave_der tk_WHILE parentesis_izq CONDICION parentesis_der punto_coma;

FOR: tk_FOR parentesis_izq DEC_ASIG  CONDICION punto_coma INC_DEC parentesis_der llave_izq CICLOS llave_der;

DEC_ASIG: ASIGNACION
        | FUN_DE;

INC_DEC: id tk_decr
       | id tk_incr
       | tk_incr id
       | tk_decr id;

PRINT: tk_SYSTEM tk_punto tk_out tk_punto tk_PRINTLN parentesis_izq EXPRESION parentesis_der punto_coma
     | tk_SYSTEM tk_punto tk_out tk_punto tk_PRINT parentesis_izq EXPRESION parentesis_der punto_coma;

MAIN: tk_VOID tk_MAIN parentesis_izq parentesis_der llave_izq BFUN llave_der {lista_token.unshift("funcion-main");};

//EN LOS CASE SIEMPRE DEBEN DE VENIR CON BREAK
SWITCH: tk_SW parentesis_izq EXPRESION parentesis_der llave_izq CASES llave_der;

CASES: tk_CASE EXPRESION tk_dpunt BCASOS CASES
     | tk_DEFA tk_dpunt BCASOS;


BREAK: tk_BRAKE punto_coma;

CONTINUE: tk_CONTINUE punto_coma;

BLOQUEC:llave_izq BM llave_der;

BM: EXPRESION BM        
  | ;

//BLOQUE DE SENNTENCIAS CORRECTO
BLOQUE: llave_izq SENTENCIAS ;

SENTENCIAS: SENTENCIA SENTENCIAS
          | llave_der;

SENTENCIA: IF_ELSE
 | DO
 | WHILE
 | FOR
 | PRINT
 | CALL_FUNCT punto_coma
 | SWITCH
 | ASIGNACION
 | EXPRESION punto_coma
 | FUN_DE 
 | BREAK
 | RETURN;
 
BCASOS: SENTENCIA BCASOS
      | SENTENCIA
      | BREAK
      | ;

BFUN: SENTENCIA BCASOS
      | RETURN
      | ;

CICLOS: SENTENCIA CICLOS
      | BREAK
      | CONTINUE
      |;

//PARECIDA A BLOQUE SOLO QUE SIN LLAVE Y EXCEPTUANDO DECLA FUNT/METOD

TIPO: tk_INT        {   }
    | tk_DOUBLE     {   }
    | tk_BOOL       {   }
    | tk_CHAR       {   }
    | tk_STRING     {   };