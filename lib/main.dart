import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

//this allows us to tap into the quiz brain method
QuizBrain quizBrain = QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];
  void checkAnswer(bool userPickedAnswer) {
    //this is gotten by the method from the question brain which had access to the _question bank which is private
    bool correctAnswer = quizBrain.getQuestionAnswer();

    setState(
      () {
        //TODO: Step 4 - Use IF/ELSE to check if we've reached the end of the quiz. If so,
        //On the next line, you can also use if (quizBrain.isFinished()) {}, it does the same thing.
        if (quizBrain.isFinished() == true) {
          //TODO Step 4 Part A - show an alert using rFlutter_alert,

          //This is the code for the basic alert from the docs for rFlutter Alert:
          //Alert(context: context, title: "RFLUTTER", desc: "Flutter is awesome.").show();

          //Modified for our purposes:
          Alert(
            context: context,
            title: 'Finished!',
            desc: 'You\'ve reached the end of the quiz.Clicking cancel will restart',
          ).show();

          //TODO Step 4 Part C - reset the questionNumber,
          quizBrain.reset();

          //TODO Step 4 Part D - empty out the scoreKeeper.
          scoreKeeper = [];
        }

        //TODO: Step 6 - If we've not reached the end, ELSE do the answer checking steps below 👇
        else {
          if (userPickedAnswer == correctAnswer) {
            scoreKeeper.add(Icon(
              Icons.check,
              color: Colors.green,
            ));
          } else {
            scoreKeeper.add(Icon(Icons.close, color: Colors.red));
          }
          quizBrain.nextQuestion();
        }
      },
    );
  }
  /* List <String> questions =[
    'You can lead a cow down stairs but not up stairs',
    'Approximately one quarter of human bones are in the feet.',
    'A slug\'s blood is green.',
  ];

  List <bool> answers =[
    false, true, true
  ];
  //these are created from the question class created
  //the q1 is an object created from the class
  Question q1= Question( q: 'You can lead a cow down stairs but not up stairs', a: false);
  */
  //the question data type is from the question.dart file

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: MaterialButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.
                //to access the question answer from the quoz brain, we use the getter method
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: MaterialButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(false);
                //The user picked false.
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
