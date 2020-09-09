#include "hash.h"

HASH_NODE*Table[HASH_SIZE];

// inicializa os ponteiros da tabela Hash em zero
void hashInit(void){
    int i;
    for(i=0; i<HASH_SIZE; ++i){
        Table[i]=0;
    }
}

// função aleatória que calcula endereço
int hashAddress(char *text){
    int address = 1;
    int i;
    for(i=0; i<strlen(text); ++i){
        // cálculo dá problemas com 0, por isso é somado mais 1
        address = (address * text[i]) % HASH_SIZE + 1;
    }
    // 1 que foi somado é subtraído p/ obter o intervalo final de 0 a HASH_SIZE
    return address-1;
}

HASH_NODE *hashFind(char *text){
    HASH_NODE *node;
    int address = hashAddress(text);
    for(node=Table[address]; node != 0; node = node->next){
        //vai comparar as 2 strings - se iguais (=0), deve-se retornar o nodo
        if (strcmp(node->text, text) == 0)
            return node;
    }
    //caso tenha percorrido toda a lista (node == 0) e não foi encontrado o lexema:
    return 0;
}

HASH_NODE *hashInsert(char *text, int type){
    HASH_NODE *newNode;
    int address = hashAddress(text);
   
    //testa se símbolo já está na tabela p/ não repetir
    if ((newNode = hashFind(text)) != 0)
        return newNode;
    
    newNode = (HASH_NODE*) calloc(1, sizeof(HASH_NODE));
    newNode-> type = type;
    newNode-> text = (char*) calloc(strlen(text)+1, sizeof(char));
    strcpy(newNode->text, text);
    
    // encadeamento --> tabela cresce de baixo para cima
    newNode->next = Table[address];
    Table[address] = newNode;
    
    return newNode;
}

// a fins de testagem
void hashPrint(void){
    int i, j;
    HASH_NODE *node;
    
    for (i=0; i<HASH_SIZE; ++i){
        for(node=Table[i], j=0; node; node = node->next, j++){
            printf("Tabela[%d] possui %s do tipo %d.\n", i, node->text, node->type);
        }
    }
}
