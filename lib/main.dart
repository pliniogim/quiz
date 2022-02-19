import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz/model/question.dart';

void main() {
  runApp(new MaterialApp(
    home: Quiz(),
  ));
}

class Quiz extends StatefulWidget {
  const Quiz({Key? key}) : super(key: key);

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  int _currentQuestionIndex = 0;

  List questionBank = [
    Question.name("A Independência do Brasil se deu em 1824.", true),
    Question.name("A vinda da família real se deu por volta de 1808", true),
    Question.name("Dom João VI era louco e casado com Maria", false),
    Question.name("A cerimônia de beija mão existe até hoje", true)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('True Citizen'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      backgroundColor: Colors.blueGrey,
      body: Builder(
        builder: (BuildContext context) =>
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Image.asset(
                      "images/flag.png",
                      width: 250,
                      height: 180,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(14.4),
                          border: Border.all(
                              color: Colors.blueGrey.shade400,
                              style: BorderStyle.solid)),
                      height: 120,
                      child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                questionBank[_currentQuestionIndex]
                                    .questionText,
                                style: TextStyle(fontSize: 16.9,
                                    color: Colors.white)),
                          )),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () => _prevQuestion(),
                        color: Colors.blueGrey.shade900,
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                      RaisedButton(
                        onPressed: () => _checkAnswer(true, context),
                        color: Colors.blueGrey.shade900,
                        child: Text(
                            "TRUE", style: TextStyle(color: Colors.white)),
                      ),
                      RaisedButton(
                        onPressed: () => _checkAnswer(false, context),
                        color: Colors.blueGrey.shade900,
                        child: Text(
                            "FALSE", style: TextStyle(color: Colors.white)),
                      ),
                      RaisedButton(
                        onPressed: () => _nextQuestion(),
                        color: Colors.blueGrey.shade900,
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  Spacer(),
                ],
              ),
            ),
      ),
    );
  }

  _checkAnswer(bool userChoice, BuildContext context) {
    if (userChoice == questionBank[_currentQuestionIndex].isCorrect) {
      final snackBar = SnackBar(
          backgroundColor: Colors.greenAccent,
          duration: Duration(milliseconds: 500),
          content: Text("Correct"));
      Scaffold.of(context).showSnackBar(snackBar);
      _updateQuestion();
    } else {
      final snackBar = SnackBar(
          backgroundColor: Colors.redAccent,
          duration: Duration(milliseconds: 500),
          content: Text("Incorrect"));
      Scaffold.of(context).showSnackBar(snackBar);
      _updateQuestion();
    }
  }

  _nextQuestion() {
    _updateQuestion();
  }

  _updateQuestion() {
    setState(() {
      _currentQuestionIndex = (_currentQuestionIndex + 1) % questionBank.length;
    });
  }

  _prevQuestion() {
    setState(() {
      _currentQuestionIndex = (_currentQuestionIndex - 1) % questionBank.length;
    });
  }
}
