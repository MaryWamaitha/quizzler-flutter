//the class can be called by importing this file in the main.dart
class Question {
  String questionText;
  bool questionsAnswer;

  //this is the constructor that is invoked when one wants to call the class
  /*Question (
    String q,bool a
){
    questionText=q;
    questionsAnswer=a;
  } */

  //a shorter version of the above would be
  Question ( this.questionText, this.questionsAnswer);
}
