/**
 * @description       :
 * @author            : Mandeep Mann
 * @group             :
 * @last modified on  : 09-06-2023
 * @last modified by  : Mandeep Mann
 **/
public with sharing class HelloWorld {
  public HelloWorld() {
    print('This is a feature!');
  }

  public static void print(String s) {
    System.debug(s);
  }
}
