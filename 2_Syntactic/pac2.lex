import java.io.*;
import java.lang.StringBuilder;
import java_cup.runtime.Symbol;

enum Type {CLASS, VARIABLE, PARAMETER}
enum Visibility {NONE, PUBLIC, PROTECTED, PRIVATE}
enum DataType {INTEGER, FLOAT, BOOLEAN, STRING, CHAR}

class Simbol {
  private String method;
  private Type type;
  private Visibility visibility;
  private DataType dataType;
  private String lexeme;

  public Simbol() {
  }

  public Simbol(String method) {
    this(method, null);
  }

  public Simbol(String method, Type type) {
    this(method, type, null);
  }

  public Simbol(String method, Type type, Visibility visibility) {
    this(method, type, visibility, null);
  }

  public Simbol(String method, Type type, Visibility visibility,
  		DataType dataType) {
    this(method, type, visibility, dataType, null);
  }

  public Simbol(String method, Type type, Visibility visibility,
  		DataType dataType, String lexeme) {
    this.method = method;
    this.type = type;
    this.visibility = visibility;
    this.dataType = dataType;
    this.lexeme = lexeme;
  }

  public String toString() {
    StringBuilder builder = new StringBuilder();
    builder.append(method + "\t\t");
    builder.append(type + "\t");
    if (type == Type.CLASS) {
    	builder.append("\t");
    }
    builder.append(visibility + "\t");
    if (visibility != Visibility.PROTECTED) {
    	builder.append("\t");
    }
    builder.append(dataType + "\t\t");
    builder.append(lexeme + "\t\t");
    return builder.toString();
  }

  public void setMethod(String method) {
  	this.method = method;
  }

  public String getMethod() {
  	return method;
  }

  public void setType(Type type) {
  	this.type = type;
  }

  public Type getType() {
  	return type;
  }

  public void setVisibility(Visibility visibility) {
  	this.visibility = visibility;
  }

  public Visibility getVisibility() {
  	return visibility;
  }

  public void setDataType(DataType dataType) {
  	this.dataType = dataType;
  }

  public DataType getDataType() {
  	return dataType;
  }

  public void setLexeme(String lexeme) {
  	this.lexeme = lexeme;
  }

  public String getLexeme() {
  	return lexeme;
  }
}

%%
%{

%}

%full
%cup
%line
%class lexiClass

%%

[ \t\r\n]+  {/* IGNORE */}
"//"[^\n]*\n  {/* COMMENT */}
"#"[^\n]*\n  {/* COMMENT */} 
/\*[^]*\*/  {/* COMMENT */}                           
\"[^]*\"                            { /* string */  return new Symbol(sym.PRIMITIVE_VALUE); }
"'"[a-zA-Z0-9]"'"                   { /* char */  return new Symbol(sym.PRIMITIVE_VALUE); } 
class          { return new Symbol(sym.CLASS); }
function       { return new Symbol(sym.FUNCTION); }
return         { 
					System.out.println("\nLexical error: Reserved word at "+(yyline+1)+": "+yytext());
                    parser.nLexErrors++;
					return new Symbol(sym.IDENTIFIER);
               }
if             { return new Symbol(sym.IF); }
else           { return new Symbol(sym.ELSE); }
elseif         { return new Symbol(sym.ELSEIF); }
for            { 
					System.out.println("\nLexical error: Reserved word at "+(yyline+1)+": "+yytext());
                    parser.nLexErrors++;
					return new Symbol(sym.IDENTIFIER);
               }
while          { 
					System.out.println("\nLexical error: Reserved word at "+(yyline+1)+": "+yytext());
                    parser.nLexErrors++;
					return new Symbol(sym.IDENTIFIER);
               }
private        { return new Symbol(sym.VISIBILITY, Visibility.PRIVATE); }
protected      { return new Symbol(sym.VISIBILITY, Visibility.PROTECTED); }
public         { return new Symbol(sym.VISIBILITY, Visibility.PUBLIC); }
new            { 
					System.out.println("\nLexical error: Reserved word at "+(yyline+1)+": "+yytext());
                    parser.nLexErrors++;
					return new Symbol(sym.IDENTIFIER);
               }
const          { 
					System.out.println("\nLexical error: Reserved word at "+(yyline+1)+": "+yytext());
                    parser.nLexErrors++;
					return new Symbol(sym.IDENTIFIER);
               }
this           { 
					System.out.println("\nLexical error: Reserved word at "+(yyline+1)+": "+yytext());
                    parser.nLexErrors++;
					return new Symbol(sym.IDENTIFIER);
               }
super          { 
					System.out.println("\nLexical error: Reserved word at "+(yyline+1)+": "+yytext());
                    parser.nLexErrors++;
					return new Symbol(sym.IDENTIFIER);
               }
int            { return new Symbol(sym.DATA_TYPE, DataType.INTEGER); }
float          { return new Symbol(sym.DATA_TYPE, DataType.FLOAT); }
string         { return new Symbol(sym.DATA_TYPE, DataType.STRING); }
char           { return new Symbol(sym.DATA_TYPE, DataType.CHAR); }
bool           { return new Symbol(sym.DATA_TYPE, DataType.BOOLEAN); }
print          { 
					System.out.println("\nLexical error: Reserved word at "+(yyline+1)+": "+yytext());
                    parser.nLexErrors++;
					return new Symbol(sym.IDENTIFIER);
               }
read           { 
					System.out.println("\nLexical error: Reserved word at "+(yyline+1)+": "+yytext());
                    parser.nLexErrors++;
					return new Symbol(sym.IDENTIFIER);
               }
"{"            { return new Symbol(sym.L_BRACE); }
"}"            { return new Symbol(sym.R_BRACE); }
"("            { return new Symbol(sym.L_PARENTHESIS); }
")"            { return new Symbol(sym.R_PARENTHESIS); }
","            { return new Symbol(sym.COMMA); }
";"            { return new Symbol(sym.SEMICOLON); }
"."            { 
					System.out.println("\nLexical error: Reserved sign at "+(yyline+1)+": "+yytext()+
						"\nMaybe you wanted to use a comma: ','");
                    parser.nLexErrors++;
					return new Symbol(sym.COMMA);
               }
"+"            { return new Symbol(sym.OPERATOR); }
"++"           { 
					System.out.println("\nLexical error: Reserved sign at "+(yyline+1)+": "+yytext()+
						"\nMaybe you wanted to use a simple plus: '+'");
                    parser.nLexErrors++;
					return new Symbol(sym.OPERATOR);
               }
"-"            { return new Symbol(sym.OPERATOR); }
"--"           { 
					System.out.println("\nLexical error: Reserved sign at "+(yyline+1)+": "+yytext()+
						"\nMaybe you wanted to use a simple minus: '-'");
                    parser.nLexErrors++;
					return new Symbol(sym.OPERATOR);
               }
"*"            { return new Symbol(sym.OPERATOR); }
"/"            { return new Symbol(sym.OPERATOR); }
"^"            { return new Symbol(sym.OPERATOR); }
"=="           { return new Symbol(sym.OPERATOR); }
">"            { return new Symbol(sym.OPERATOR); }
"<"            { return new Symbol(sym.OPERATOR); }
">="           { return new Symbol(sym.OPERATOR); }
"<="           { return new Symbol(sym.OPERATOR); }
"&&"           { return new Symbol(sym.OPERATOR); }
"||"           { return new Symbol(sym.OPERATOR); }
"!"            { return new Symbol(sym.UNARY_OPERATOR); }
"!="           { return new Symbol(sym.OPERATOR); }
"="            { return new Symbol(sym.EQUALS); }
true|false     { return new Symbol(sym.PRIMITIVE_VALUE); }
[-+]?[0-9]+    { return new Symbol(sym.PRIMITIVE_VALUE); }
[-+]?[0-9]+\.[0-9]+    { return new Symbol(sym.PRIMITIVE_VALUE); }                                                 
[a-zA-Z_][a-zA-Z_0-9]* { /* identifier */
                              return new Symbol(sym.IDENTIFIER, new String(yytext()));
                        }
[-+]?[0-9]+\.[^0-9]     {
                              System.out.println("\nLexical error: Unexpected input at "+(yyline+1)+": "+yytext());
                              parser.nLexErrors++;
                              return new Symbol(sym.PRIMITIVE_VALUE);
                        }
[-+]?[^0-9]\.[0-9]+     {
                              System.out.println("\nLexical error: Unexpected input at "+(yyline+1)+": "+yytext());
                              parser.nLexErrors++;
                              return new Symbol(sym.PRIMITIVE_VALUE);
                        }                               
[-+]?\.[0-9]+           {
                              System.out.println("\nLexical error: Unexpected input at "+(yyline+1)+": "+yytext());
                              parser.nLexErrors++;
                              return new Symbol(sym.PRIMITIVE_VALUE);
                        }
[-+]?[0-9]+\.           {
                              System.out.println("\nLexical error: Unexpected input at "+(yyline+1)+": "+yytext());
                              parser.nLexErrors++;
                              return new Symbol(sym.PRIMITIVE_VALUE);
                        }                   
.                       {
                              System.out.println("\nLexical error: Unexpected input at "+(yyline+1)+": "+yytext());
                              parser.nLexErrors++;
                            }