%token KW_CHAR
%token KW_INT
%token KW_FLOAT
%token KW_BOOL
%token KW_IF
%token KW_THEN
%token KW_ELSE
%token KW_WHILE
%token KW_LOOP
%token KW_READ
%token KW_PRINT
%token KW_RETURN
%token OPERATOR_LE
%token OPERATOR_GE
%token OPERATOR_EQ
%token OPERATOR_DIF
%token TK_IDENTIFIER
%token LIT_INTEGER
%token LIT_FLOAT
%token LIT_TRUE
%token LIT_FALSE
%token LIT_CHAR
%token LIT_STRING

%token TOKEN_ERROR

 
%{

int yyerror ();

%}

%%

programa: listaDeDecl
;
    
listaDeDecl: decl ';' listaDeDecl
    |   decl
;

decl:  KW_INT TK_IDENTIFIER
    | KW_INT TK_IDENTIFIER '(' ')' body
;

body: '{' listaDeCmd '}'
;

listaDeCmd: cmd listaDeCmd
    |
;

cmd: TK_IDENTIFIER '=' LIT_INTEGER
;

%%

int yyerror (){
    fprintf(stderr, "Erro de sintaxe na linha %d.\n", getLineNumber());
    
    //erro de sintaxe - retorna código 3
    exit(3);
}
