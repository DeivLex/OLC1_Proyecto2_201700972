
/*------------------------------------------------IMPORTS----------------------------------------------*/
%{
    
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

<<EOF>>     %{  return 'EOF';   %}

.          console.log("Error lexico:",yytext,"Linea:",yylineno);

/lex

/*--------------------------------------------------SINTACTICO-----------------------------------------------*/
%left tk_and
%left tk_or
%left tk_dist tk_igualdad
%left tk_menor tk_mayor tk_menorig tk_mayorig
%left tk_sum tk_res
%left tk_mul tk_div
%left  parentesis_izq tk_igual punto_coma
%left FUNCIONES 
%right tk_not
%right UMINUS

%start S
%% 

S:EXP EOF {  return "Todo bien"; };

EXP: IMPORTS EXP { }
   | CLASS 
   |;


IMPORTS: IMPORT IMPORTS { }
        | IMPORT;

IMPORT: tk_IMP id punto_coma;


EXPRESION: EXPRESION tk_mayor EXPRESION     {   }
         | EXPRESION tk_menor EXPRESION     {   }
         | EXPRESION tk_menorig EXPRESION   {   }
         | EXPRESION tk_mayorig EXPRESION   {   }
         | EXPRESION tk_igualdad EXPRESION  {   }
         | EXPRESION tk_dist EXPRESION      {   }
         | tk_not EXPRESION                 {   }
         | EXPRESION tk_sum EXPRESION       {   }
         | EXPRESION tk_res EXPRESION       {   }
         | EXPRESION tk_mul EXPRESION       {   }
         | EXPRESION tk_div EXPRESION       {   }
         | EXPRESION tk_pot EXPRESION       {   }
         | EXPRESION tk_incr
         | EXPRESION tk_decr
         | tk_res EXPRESION  %prec UMINUS   {   }
         | parentesis_izq EXPRESION  parentesis_izq   {   }
         | EXPRESION tk_res EXPRESION       {   }
         | id
         | cadena
         | entero
         | decimal
         | char
         | boolean
         | tk_TRUE
         | tk_FALSE
         | CALL_FUNCT;


ASIGNACION: id tk_igual EXPRESION punto_coma      {   };


CALL_FUNCT: id parentesis_izq LISTA_EXP parentesis_der 
          | id parentesis_izq parentesis_der;

LISTA_EXP: EXPRESION tk_coma LISTA_EXP      {   }
         | EXPRESION             {   };



CONDICION: CONDICION OPERADOR CONDICION
         | NUMEROS OPERADORLOG NUMEROS
         | tk_FALSE {   }
         | tk_TRUE  {   }
         | NUMEROS;


OPERADOR: tk_and
        | tk_or;

OPERADORLOG: tk_mayor
           | tk_menor
           | tk_menorig
           | tk_mayorig
           | tk_igualdad
           | tk_dist;
         
NUMEROS: NUMEROS tk_sum NUMEROS       {   }
       | NUMEROS tk_res NUMEROS       {   }
       | NUMEROS tk_mul NUMEROS       {   }
       | NUMEROS tk_div NUMEROS       {   }
       | NUMEROS tk_pot NUMEROS       {   }
       | entero
       | tk_NULL
       | tk_not NUMEROS
       | CALL_FUNCT
       | id;

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
        | DECLARACION;

INC_DEC: id tk_decr
       | id tk_incr
       | tk_incr id
       | tk_decr id;

LIST_PARAM: TIPO id tk_coma LIST_PARAM 
          | TIPO id;

PRINT: tk_SYSTEM tk_punto tk_out tk_punto tk_PRINTLN parentesis_izq EXPRESION parentesis_der punto_coma
     | tk_SYSTEM tk_punto tk_out tk_punto tk_PRINT parentesis_izq EXPRESION parentesis_der punto_coma;

MAIN: tk_VOID tk_MAIN parentesis_izq parentesis_der llave_izq BFUN llave_der;

//EN LOS CASE SIEMPRE DEBEN DE VENIR CON BREAK
SWITCH: tk_SW parentesis_izq EXPRESION parentesis_der llave_izq CASES llave_der;

CASES: tk_CASE EXPRESION tk_dpunt BCASOS CASES
     | tk_DEFA tk_dpunt BCASOS;


BREAK: tk_BRAKE punto_coma;

CONTINUE: tk_CONTINUE punto_coma;


CLASS:  tk_CLASS id llave_izq CUERPO_CLASS llave_der;



CUERPO_CLASS: FUNCIONES CUERPO_CLASS
            | ASIGNACION CUERPO_CLASS
            | MAIN CUERPO_CLASS
            | ;

FUNCIONES: VD_TP parentesis_izq LIST_PARAM parentesis_der llave_izq BFUN llave_der
         | VD_TP parentesis_izq parentesis_der llave_izq BFUN llave_der
         | VD_TP;

VD_TP: tk_VOID
        | TIPO LISTA_ID  punto_coma
        | TIPO LISTA_ID tk_igual EXPRESION punto_coma
        | TIPO id;

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
 | DECLARACION ;
 
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

LISTA_ID:  id tk_coma LISTA_ID      {   };

TIPO: tk_INT        {   }
    | tk_DOUBLE     {   }
    | tk_BOOL       {   }
    | tk_CHAR       {   }
    | tk_STRING     {   };