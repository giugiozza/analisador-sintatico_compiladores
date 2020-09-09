int main(int argc, char ** argv){
    
    int token;
    
    //caso nome do arquivo não tenha sido informado - retorna código 1
    if(argc<2){
        fprintf(stderr, "Call: etapa1 fileName\n");
        exit(1);
    }
    
    //não conseguiu abrir arquivo - retorna código 2
    yyin = fopen(argv[1], "r");
    if(yyin == 0){
        fprintf(stderr, "Arquivo %s não pode ser aberto.\n", argv[1]);
        exit(2);
    }
    
    initMe();
    
    yyparse();
    
    hashPrint();
    
    //concluiu com sucesso - retorna código 0
    exit(0);
    
}


