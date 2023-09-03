/**
 * @description       : 
 * @author            : Mandeep Mann
 * @group             : 
 * @last modified on  : 09-03-2023
 * @last modified by  : Mandeep Mann
**/
public with sharing class HelloWorld {
    public HelloWorld() {
        print('Hello World Feature 1');
    }

    public static void print(String s){
        System.debug(s);
    }
}
