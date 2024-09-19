import 'package:calculator_app_flutter/cal_button.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  var userInput = '';
  var answer = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          userInput, // Corrected this line
                          style: const TextStyle(
                              color: Colors.white, fontSize: 30),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          answer, // Corrected this line
                          style: const TextStyle(
                              color: Color.fromARGB(255, 167, 154, 154),
                              fontSize: 24),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CalButton(
                        buttonText: 'AC',
                        onPress: () {
                          userInput = '';
                          answer = '';
                          setState(() {});
                        },
                      ),
                      CalButton(
                        buttonText: 'DEL',
                        onPress: () {
                          setState(() {
                            userInput = userInput.isNotEmpty
                                ? userInput.substring(0, userInput.length - 1)
                                : '';
                          });
                        },
                      ),
                      CalButton(
                        buttonText: '+/-',
                        onPress: () {
                          toggleSign();
                        },
                      ),
                      CalButton(
                        buttonText: '/',
                        buttonColor: const Color(0xffffa00a),
                        onPress: () {
                          userInput += '/';

                          setState(() {
                            answer =
                                userInput.substring(0, userInput.length - 1);
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CalButton(
                        buttonText: '7',
                        onPress: () {
                          userInput += '7';

                          setState(() {});
                        },
                      ),
                      CalButton(
                        buttonText: '8',
                        onPress: () {
                          userInput += '8';

                          setState(() {});
                        },
                      ),
                      CalButton(
                        buttonText: '9',
                        onPress: () {
                          userInput += '9';

                          setState(() {});
                        },
                      ),
                      CalButton(
                        buttonText: 'X',
                        buttonColor: const Color(0xffffa00a),
                        onPress: () {
                          userInput += 'X';

                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CalButton(
                        buttonText: '4',
                        onPress: () {
                          userInput += '4';
                          answer += '';
                          setState(() {});
                        },
                      ),
                      CalButton(
                        buttonText: '5',
                        onPress: () {
                          userInput += '5';
                          answer += '';
                          setState(() {});
                        },
                      ),
                      CalButton(
                        buttonText: '6',
                        onPress: () {
                          userInput += '6';
                          answer += '';
                          setState(() {});
                        },
                      ),
                      CalButton(
                        buttonText: '-',
                        buttonColor: const Color(0xffffa00a),
                        onPress: () {
                          userInput += '-';

                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CalButton(
                        buttonText: '1',
                        onPress: () {
                          userInput += '1';

                          setState(() {});
                        },
                      ),
                      CalButton(
                        buttonText: '2',
                        onPress: () {
                          userInput += '2';

                          setState(() {});
                        },
                      ),
                      CalButton(
                        buttonText: '3',
                        onPress: () {
                          userInput += '3';

                          setState(() {});
                        },
                      ),
                      CalButton(
                        buttonText: '+',
                        buttonColor: const Color(0xffffa00a),
                        onPress: () {
                          userInput += '+';

                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CalButton(
                        buttonText: '%',
                        onPress: () {
                          userInput += '%';

                          setState(() {});
                        },
                      ),
                      CalButton(
                        buttonText: '0',
                        onPress: () {
                          userInput += '0';

                          setState(() {});
                        },
                      ),
                      CalButton(
                        buttonText: '.',
                        onPress: () {
                          userInput += '.';

                          setState(() {});
                        },
                      ),
                      CalButton(
                        buttonText: '=',
                        buttonColor: const Color(0xffffa00a),
                        onPress: () {
                          equalPress();
                        },
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void equalPress() {
    var finalUserInput = userInput.replaceAll('X', '*');

    try {
      Parser p = Parser();
      Expression exp = p.parse(finalUserInput);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      setState(() {
        answer = eval.toString();
      });
    } catch (e) {
      setState(() {
        answer = "Error";
      });
    }
  }

  void toggleSign() {
    if (userInput.isNotEmpty) {
      // Find the last operator in the input
      int lastOperatorIndex = userInput.lastIndexOf(RegExp(r'[\+\-\*\/%]'));

      // Get the last number
      String lastNumber = (lastOperatorIndex != -1)
          ? userInput.substring(lastOperatorIndex + 1)
          : userInput;

      // Toggle the sign of the last number
      if (lastNumber.startsWith('-')) {
        lastNumber = lastNumber.substring(1);
      } else {
        lastNumber = '(-$lastNumber)';
      }

      // Replace the old number with the toggled one
      userInput = (lastOperatorIndex != -1)
          ? userInput.substring(0, lastOperatorIndex + 1) + lastNumber
          : lastNumber;

      setState(() {});
    }
  }
}
