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

//regras para os operadores - associatividade à ESQUERDA
//precedência aumenta p/ baixo
%left '|' '^'
%left '<' '>' OPERATOR_EQ OPERATOR_DIF OPERATOR_LE OPERATOR_GE
%left '+' '-'
%left '*' '/'
%left '~'
 
%{

int yyerror ();

%}

%%

 /* INÍCIO DO PROGRAMA -> LISTAS DE DECLARAÇÃO */
programa: listaDeDecl
    ;

 /* declaração ou é de variável, ou é função ou é vazia */
listaDeDecl: declVar ';' listaDeDecl
    | declFun ';' listaDeDecl
    |
    ;

 /* declaração de variável ou é simples ou é um vetor */
declVar: varSimples
    | vetor
    ;

 /* declaração de função é um cabeçalho seguido do corpo */
declFun: header bloco
    ;

 /* variáveis que não são vetores devem ter seu valor inicializado */
varSimples: TK_IDENTIFIER '=' tipo ':' valorLiteral
    ;

 /* vetores podem ser inicializados ou não */
vetor: TK_IDENTIFIER '=' tipo '[' LIT_INTEGER ']'
    | TK_IDENTIFIER '=' tipo '[' LIT_INTEGER ']' ':' valorVetor
    ;

tipo: KW_CHAR
    | KW_INT
    | KW_FLOAT
    | KW_BOOL
    ;

valorLiteral: LIT_INTEGER
    | LIT_FLOAT
    | LIT_TRUE
    | LIT_FALSE
    | LIT_CHAR
    ;

valorVetor: valorLiteral
    | valorLiteral valorVetor
    ;

header: TK_IDENTIFIER '(' listaParametros ')' '=' tipo
    |  TK_IDENTIFIER '(' ')' '=' tipo
    ;

bloco: '{' listaCmd '}'
    ;

listaParametros: TK_IDENTIFIER '=' tipo contParametros
    ;

 /* continuação dos parâmetros (tail) */
contParametros: ',' listaParametros
    |
    ;

listaCmd: cmd listaCmd
    | cmd
    ;

cmd: atribuicao
    | controleFluxo
    | cmdRead
    | cmdPrint
    | cmdReturn
    | bloco
    |
    ;

atribuicao: TK_IDENTIFIER '=' expressao
    | TK_IDENTIFIER '[' expressao ']' '=' expressao
    ;

controleFluxo: cmdIf
    | cmdWhile cmd
    | cmdLoop cmd
    ;

cmdRead: KW_READ TK_IDENTIFIER
    ;

cmdPrint: KW_PRINT listaPrint
    ;

listaPrint: LIT_STRING ',' listaPrint
    | LIT_STRING
    | expressao ',' listaPrint
    | expressao
    ;

cmdReturn: KW_RETURN expressao
    ;

cmdIf: KW_IF '(' expressao ')' KW_THEN cmd
    | KW_IF '(' expressao ')' KW_THEN cmd KW_ELSE cmd
    ;

cmdWhile: KW_WHILE '(' expressao ')'
    ;

cmdLoop: KW_LOOP '(' TK_IDENTIFIER ':' expressao ',' expressao ',' expressao ')'
    ;

expressao: valorLiteral
    | TK_IDENTIFIER
    | TK_IDENTIFIER '[' expressao ']'
    | expressao '+' expressao
    | expressao '-' expressao
    | expressao '*' expressao
    | expressao '/' expressao
    | expressao '>' expressao
    | expressao '<' expressao
    | expressao '|' expressao
    | expressao '^' expressao
    | '~' expressao
    | '-' expressao
    | expressao OPERATOR_EQ expressao
    | expressao OPERATOR_DIF expressao
    | expressao OPERATOR_LE expressao
    | expressao OPERATOR_GE expressao
    | '(' expressao ')'
    | chamadaFunc
    ;

chamadaFunc: TK_IDENTIFIER '(' listaArgumentos ')'
    ;

listaArgumentos: expressao contlistaArgumentos
    ;

contlistaArgumentos: ',' listaArgumentos
    |
    ;

%%

int yyerror (){
    fprintf(stderr, "Erro de sintaxe na linha %d.\n", getLineNumber());
    
    //erro de sintaxe - retorna código 3
    exit(3);
}
