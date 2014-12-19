//Compiladores I
//Universitat Oberta de Catalunya
//
//Ejercicio Tabla de símbolos.
import java.io.*;
import java.lang.Object;
import java.util.Hashtable;
import java.util.Enumeration;
import java.util.ArrayList;

abstract class Simbol { 
	String lexema; 
	int tipus; 
	ArrayList<Integer> linies; 

	public abstract void add(int l);
	public abstract String toString();
} 

class Identificador extends Simbol {

	public Identificador (String n, int l) { 
		lexema = new String(n); 
		linies = new ArrayList<Integer>();
		linies.add(l); 
	} 

	public void add(int l) {
		linies.add(l);
	}

	public String toString() { 
		String repr = lexema + ": lines ";
		int i = 0;
		for (i=0; i<linies.size()-1; i++) {
			repr = repr + linies.get(i) + ",";
		}
		repr = repr + linies.get(i) + "\n";
		return repr; 
	} 
}

class ParaulaClau extends Simbol {

	public ParaulaClau (String n) { 
		lexema = new String(n); 
		linies = null; 
	} 

	public void add(int l) {

	}

	public String toString() { 
		return "";
	} 
}

// Tabla de símbolos, implementada con una tabla de dispersión.
class MyHashtable extends Hashtable<String, Simbol> { 
	public String toString() { 
		String str = "";
		for (Enumeration<Simbol> elems = this.elements(); elems.hasMoreElements();) {
			str = str + elems.nextElement().toString();
		}
		return str;
	}
}

%% 
%{ 
//Llista de keywords
static String KWs[]={"class", "function", "return", "if", "else", "elseif", "for", "while", "private", "public", "protected", "new",
	"const", "this", "super", "int", "float", "string", "char", "bool", "return", "print", "read"}; 

//Fitxer d'entrada
static FileInputStream FInStr = null; 

//Taula de simbolos
public static MyHashtable mySymbolTable = new MyHashtable(); 

// Errors totals
public static int lexErrors =0; 

String simbol;
Simbol auxSimbol;

public static void main (String argv[]) throws java.io.IOException { 
	//Obtenció del nom del fitxer d'entrada
	if (argv.length !=1) { 
		 System.out.println ("Ús:"); 
		 System.out.println ("\tjava -cp <CLASSPATH> lexiClass <fitxer>"); 
		 return; 
	 } 
	//Càrrega del fitxer
	try { 
		FInStr = new FileInputStream(argv[0]);
	} catch (FileNotFoundException e){ 
		System.out.println ("No es pot obrir el fitxer"); 
		return; 
	} 
	//Inicialització de la taula de símbols amb les paraules clau
	for (int i=0; i<KWs.length; i++) { 
		mySymbolTable.put (KWs[i], new ParaulaClau(KWs[i]));
	} 
	//Crida a yylex
	lexiClass yy = new lexiClass(FInStr); 
	System.out.println("\nProcessant l'arxiu " + argv[0] + "..."); 
	while (yy.yylex() != -1) ; 
	System.out.println("\n"); 
	System.out.println(mySymbolTable.toString());
	System.out.println("\n"); 
	System.out.println("Errors totals: " + lexErrors); 
} //Fi main
%} 
%class lexiClass
%unicode
%integer
%line 
%% 
"//"(.)* { }
"/*"([^"*/"]*[\r\n\t]?)+"*/" { }
"#"(.)* { }
"+" { } 
"++" { } 
"-" { } 
"--" { } 
"*" { } 
"/" { } 
"^" { } 
"==" { } 
">" { } 
"<" { }
">=" { } 
"<=" { } 
"&&" { } 
"||" { } 
"!" { } 
"!=" { } 
"=" { } 

"{" { } 
"}" { } 
"(" { } 
")" { } 
"," { } 
";" { } 
"." { } 

[\r\n \t]+ { } 
(true|false) { }
[a-zA-Z_][a-zA-Z0-9_]* {
	//Identificador
	simbol = yytext();
	if (!mySymbolTable.containsKey (simbol)) { 
		//L'afegim per primera vegada
		mySymbolTable.put(simbol,new Identificador(simbol, (yyline+1))); 
	} else {
		auxSimbol = mySymbolTable.get(simbol);
		auxSimbol.add(yyline+1);
		mySymbolTable.put(simbol, auxSimbol);
	}
}
("+"|"-")?[0-9]+ { }
("+"|"-")?([0-9]+)(".")([0-9]+) { }
"'"[a-zA-Z0-9]"'" { }
\"[a-zA-Z0-9]*\" { }
\"[^\"\r\n \t]* {System.out.println ("ERROR: "+yytext()+". String incomplet."); lexErrors++; }
\'[^\'\r\n \t]* {System.out.println ("ERROR: "+yytext()+". Caràcter incomplet o massa llarg."); lexErrors++; }

. { System.out.println ("ERROR: "+yytext()+". Caràcter no permés."); lexErrors++; }