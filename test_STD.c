/*************************************************************
* Program som testar de olika funktionerna i I/O-biblioteket *
*************************************************************/

#include "my_iolib.h"

int main(){

    char headMsg[] = "Start av testprogram. Skriv in 5 tal!";
    char endMsg[] = "Testprogram slut";

    // Skriv ut inledande meddelande
    putText(headMsg);   
    outImage();         

    // Läs in text från användaren
    inImage();      

    // Skriv ut den inlästa texten
    outImage();

    // Testar inImage och outImage funktionerna
    putText("Testing inImage and outImage functions:");
    outImage();
    inImage();
    outImage();

    // Skriv ut avslutande meddelande
    putText(endMsg); 
    outImage();  

    return 0;
}