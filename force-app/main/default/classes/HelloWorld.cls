/**
 * @description       : 
 * @author            : Mandeep Mann
 * @group             : 
 * @last modified on  : 06-26-2023
 * @last modified by  : Mandeep Mann
**/
public with sharing class HelloWorld {
    public HelloWorld() {
        print('Hello World');
    }

    public static void print(String s){
        System.debug(s);
    }
}
