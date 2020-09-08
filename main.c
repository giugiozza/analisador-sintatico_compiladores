int main(int argc, char ** argv){
    
    int token;
    
    //caso nome do arquivo não tenha sido informado
    if(argc<2){
        fprintf(stderr, "Call: etapa1 fileName\n");
        exit(1);
    }
    
    yyin = fopen(argv[1], "r");
    if(yyin == 0){
        fprintf(stderr, "Arquivo %s não pode ser aberto.\n", argv[1]);
        exit(2);
    }
    
    initMe();
    
    while(isRunning()){
        
        token = yylex();
        
        printf("LINHA: %d \t TOKEN: %d \t CONTEÚDO: %s\n", getLineNumber(), token, yytext);
    }
    
    hashPrint();
    
}


