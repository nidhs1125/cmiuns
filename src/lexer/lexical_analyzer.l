%option noyywrap
%{
/*****************声明和选项设置  begin*****************/
#include <stdio.h>
#include <stdlib.h>

#include "lexical_analyzer.h"

int lines;
int pos_start;
int pos_end;

/*****************声明和选项设置  end*****************/

%}
 

%%

 /******************TODO*********************/
 /****请在此补全所有flex的模式与动作  start******/
 //STUDENT TO DO

\[\] {
	pos_end+=2;
	return ARRAY;
}
"else" {pos_end+=4;return ELSE;}
"if" {pos_end+=2;return IF;}
"int" {pos_end+=3;return INT;}
"float" {pos_end+=5;return FLOAT;}
"return" {pos_end+=6;return RETURN;}
"void" {pos_end+=4;return VOID;}
"while" {pos_end+=5;return WHILE;}
[a-zA-Z]+ {
	int i=0;
	while(1){
		if(yytext[i]=='\0') break;
		pos_end++;i++;
	}
	return IDENTIFIER;
}
[a-zA-Z] {
	int i=0;
	while(1){
		if(yytext[i]=='\0') break;
		pos_end++;i++;
	}
	return LETTER;
}
[0-9]+ {
	int i=0;
	while(1){
		if(yytext[i]=='\0') break;
		pos_end++;i++;
	}
	return INTEGER;
}
[0-9]+\.|[0-9]*\.[0-9]+ {
	int i=0;
	while(1){
		if(yytext[i]=='\0') break;
		pos_end++;i++;
	}
	return FLOATPOINT;
}
\/\*([^\*]|[\*]+[^\/\*])*[\*]+\/ {
	int i=0;
	while(1){
		if(yytext[i]=='\0') break;
		if(yytext[i]=='\n') lines++,pos_end=1;
		else pos_end++;
		i++;
	}
	return COMMENT;
}
"+" {pos_end++;return ADD;}
"-"	{pos_end++;return SUB;}
"*" {pos_end++;return MUL;}
"/" {pos_end++;return DIV;}
"<" {pos_end++;return LT;}
"<=" {pos_end++;pos_end++;return LTE;}
">" {pos_end++;return GT;}
">=" {pos_end++;pos_end++;return GTE;}
"==" {pos_end++;pos_end++;return EQ;}
"!=" {pos_end++;pos_end++;return NEQ;}
";" {pos_end++;return SEMICOLON;}
"," {pos_end++;return COMMA;}
"(" {pos_end++;return LPARENTHESE;}
")" {pos_end++;return RPARENTHESE;}
"[" {pos_end++;return LBRACKET;}
"]" {pos_end++;return RBRACKET;}
"{" {pos_end++;return LBRACE;}
"}" {pos_end++;return RBRACE;}
"=" {pos_end++;return ASSIN;}
"\n" {lines++;pos_start=1;pos_end=1;return EOL;}
[ \f\r\t\v] {pos_start++,pos_end++;return BLANK;}
. {pos_end++;return ERROR;}


 /****请在此补全所有flex的模式与动作  end******/
%%
/****************C代码 start*************/

/// \brief analysize a *.cminus file
///
/// \param input_file, 需要分析的文件路径
/// \param token stream, Token_Node结构体数组，用于存储分析结果，具体定义参考lexical_analyer.h

void analyzer(char* input_file, Token_Node* token_stream){
    lines = 1;
    pos_start = 1;
    pos_end = 1;
    if(!(yyin = fopen(input_file,"r"))){
        printf("[ERR] No input file\n");
        exit(1);
    }
    printf("[START]: Read from: %s\n", input_file);

    int token;
    int index = 0;

    while(token = yylex()){
        switch(token){
            case COMMENT:
                //STUDENT TO DO
                break;
            case BLANK:
                //STUDENT TO DO
                break;
            case EOL:
                //STUDENT TO DO
                break;
            case ERROR:
                printf("[ERR]: unable to analysize %s at %d line, from %d to %d\n", yytext, lines, pos_start, pos_end);
            default :
                if (token == ERROR){
                    sprintf(token_stream[index].text, "[ERR]: unable to analysize %s at %d line, from %d to %d", yytext, lines, pos_start, pos_end);
                } else {
                    strcpy(token_stream[index].text, yytext);
                }
                token_stream[index].token = token;
                token_stream[index].lines = lines;
                token_stream[index].pos_start = pos_start;
                token_stream[index].pos_end = pos_end;
                index++;
                if (index >= MAX_NUM_TOKEN_NODE){
                    printf("%s has too many tokens (> %d)", input_file, MAX_NUM_TOKEN_NODE);
                    exit(1);
                }
        }
        pos_start=pos_end;
    }
    printf("[END]: Analysis completed.\n");
    return;
}
/****************C代码 end*************/
