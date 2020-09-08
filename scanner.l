%{
    #include "tokens.h"
    #include "hash.c"
    
    int Running = 1;
    int lineNumber = 1;
    
    int isRunning(void);
    int getLineNumber(void);
    void initMe(void);
%}

%x COMMENT

%%

 /* IGNORA BRANCOS E TABS */
[ \t]

 /* CONTROLE DE LINHA */
"\n"    ++lineNumber;

 /* CARACTERES ESPECIAIS */
[\,\;\:\(\)\[\]\{\}\+\-\*\/\<\>\=\|\^\~\&\$\#]    return yytext[0];

 /* PALAVRAS RESERVADAS */
"char"  return KW_CHAR;
"int"   return KW_INT;
"float"	return KW_FLOAT;
"bool"	return KW_BOOL;
"if"    return KW_IF;
"then"  return KW_THEN;
"else"  return KW_ELSE;
"while" return KW_WHILE;
"loop"  return KW_LOOP;
"read"  return KW_READ;
"print" return KW_PRINT;
"return"    return KW_RETURN;

 /* OPERADORES COMPOSTOS */
"<="    return OPERATOR_LE;
">="    return OPERATOR_GE;
"=="    return OPERATOR_EQ;
"!="    return OPERATOR_DIF;

 /* BOOLEANOS */
"TRUE"  return LIT_TRUE;
"FALSE" return LIT_FALSE;

 /* LITERAIS INTEIROS */
[A-F0-9]+   {hashInsert(yytext, LIT_INTEGER); return LIT_INTEGER;}

 /* LITERAIS FLOAT */
[A-F0-9]*\.[A-F0-9]+    {hashInsert(yytext, LIT_FLOAT); return LIT_FLOAT;}

 /* STRING */
\"([^"\\\n]|\\.)*\" {hashInsert(yytext, LIT_STRING); return LIT_STRING;}

 /* CARACTERE */
\'(\\.|[^'\n\t])'    {hashInsert(yytext, LIT_CHAR); return LIT_CHAR;}

 /* IDENTIFICADORES */
[a-zA-Z@_]+[0-9A-Za-z@_]*   {hashInsert(yytext, TK_IDENTIFIER); return TK_IDENTIFIER;}

 /* COMENTÁRIOS */
"//".*
"/*"        { BEGIN(COMMENT); }

<COMMENT>"*/"   { BEGIN(INITIAL); }
<COMMENT>"\n"   { ++lineNumber; }
<COMMENT>.

 /* ERRO */
.   return TOKEN_ERROR;

%%

#include "main.c"

int isRunning(void){
    return Running;
}

int yywrap(){
    Running = 0;
    return 1;
}

int getLineNumber(void){
    return lineNumber;
}

void initMe(void){
    hashInit();
}
