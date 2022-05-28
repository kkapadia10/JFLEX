package scanner;
/**
* This file defines a simple lexer for the compilers course 2022.
* Creates a lexer for receipts.
*
* @author Arjun Dixit, Kaden Kapadia, and Bodhi Saha
* @version February 10, 2022
*/
import java.io.*;


%%
/* lexical functions */
/* specify that the class will be called Scanner and the function to get the next
 * token is called nextToken.  
 */
%class Scanner
%unicode
%line
%public
%function nextToken
/*  return String objects - the actual lexemes */
/*  returns the String "END: at end of file */
%type String
%eofval{
return "END";
%eofval}

/**
 * Pattern definitions
 */
LineTerminator = \r|\n|\r\n
WhiteSpace = {LineTerminator} | [ \t\f]
PriceTag = [0-9]{1,5}\.[0-9]{2} 

%%
/**
 * lexical rules
 */

[0-9]{3}-[0-9]{3}-[0-9]{4}      {return "PHONE NUMBER: " + yytext(); } 
[0-9]{2}\/[0-9]{2}\/[0-9]{4}    {return "DATE: " + yytext();}
[0-9]{2}:[0-9]{2}[ ][A|P]M      {return "TIME: " + yytext();}
^(Subtotal)[ ]*{PriceTag}          {return "SUBTOTAL: " + yytext().replaceAll("\\s+", " ").split(" ")[1].trim();}
^(Tax)[ ]*{PriceTag}          {return "TAX: " + yytext().replaceAll("\\s+", " ").split(" ")[1].trim();}
^(Total)[ ]*{PriceTag}          {return "TOTAL: " + yytext().replaceAll("\\s+", " ").split(" ")[1].trim();}
^[a-z|A-Z|\t| ]*{PriceTag}      {return "ITEM: " + yytext();}
{WhiteSpace}                    {}
.                               { /* do nothing */ }
