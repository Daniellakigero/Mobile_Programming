import 'package:calculator/button_values.dart';
import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _number1 = ""; // Number before the operator
  String _operand = ""; // Operator (+, -, *, /)
  String _number2 = ""; // Number after the operator

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: const Size.fromHeight(30),
      //   child: AppBar(
      //     title:
      //         const Text('My Calculator App', style: TextStyle(fontSize: 16)),
      //     centerTitle: true,
      //     elevation: 0,
      //   ),
      // ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildOutputDisplay(),
            _buildButtonsGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildOutputDisplay() {
    return Expanded(
      flex: 1,
      child: SingleChildScrollView(
        reverse: true,
        child: Container(
          alignment: Alignment.bottomRight,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            _formattedOutput,
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.end,
          ),
        ),
      ),
    );
  }

  String get _formattedOutput {
    final output = "$_number1$_operand$_number2";
    return output.isEmpty ? "0" : output;
  }

  Widget _buildButtonsGrid() {
    return Expanded(
      flex: 5,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 1.3,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
        ),
        itemCount: Btn.buttonValues.length,
        itemBuilder: (context, index) {
          final value = Btn.buttonValues[index];
          return _buildButton(value);
        },
      ),
    );
  }

  Widget _buildButton(String value) {
    return Material(
      color: _getButtonColor(value),
      clipBehavior: Clip.hardEdge,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: () => _onButtonTap(value),
        child: Center(
          child: Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
      ),
    );
  }

  Color _getButtonColor(String value) {
    if ([Btn.del, Btn.clr].contains(value)) {
      return Colors.blueGrey;
    } else if ([
      Btn.per,
      Btn.multiply,
      Btn.add,
      Btn.subtract,
      Btn.divide,
      Btn.calculate
    ].contains(value)) {
      return Colors.orange;
    } else {
      return Colors.black87;
    }
  }

  void _onButtonTap(String value) {
    switch (value) {
      case Btn.del:
        _delete();
        break;
      case Btn.clr:
        _clearAll();
        break;
      case Btn.per:
        _convertToPercentage();
        break;
      case Btn.calculate:
        _calculate();
        break;
      default:
        _appendValue(value);
    }
  }

  void _calculate() {
    if (_number1.isEmpty || _operand.isEmpty || _number2.isEmpty) return;

    final num1 = double.parse(_number1);
    final num2 = double.parse(_number2);

    double result;
    switch (_operand) {
      case Btn.add:
        result = num1 + num2;
        break;
      case Btn.subtract:
        result = num1 - num2;
        break;
      case Btn.multiply:
        result = num1 * num2;
        break;
      case Btn.divide:
        result = num1 / num2;
        break;
      default:
        return;
    }

    setState(() {
      _number1 = result.toStringAsPrecision(3).replaceAll(RegExp(r'\.0$'), '');
      _operand = "";
      _number2 = "";
    });
  }

  void _convertToPercentage() {
    if (_number1.isNotEmpty && _operand.isNotEmpty && _number2.isNotEmpty) {
      _calculate();
    }

    if (_operand.isNotEmpty) return;

    final number = double.parse(_number1);
    setState(() {
      _number1 = (number / 100).toString();
      _operand = "";
      _number2 = "";
    });
  }

  void _clearAll() {
    setState(() {
      _number1 = "";
      _operand = "";
      _number2 = "";
    });
  }

  void _delete() {
    setState(() {
      if (_number2.isNotEmpty) {
        _number2 = _number2.substring(0, _number2.length - 1);
      } else if (_operand.isNotEmpty) {
        _operand = "";
      } else if (_number1.isNotEmpty) {
        _number1 = _number1.substring(0, _number1.length - 1);
      }
    });
  }

  void _appendValue(String value) {
    setState(() {
      if (value != Btn.dot && int.tryParse(value) == null) {
        if (_operand.isNotEmpty && _number2.isNotEmpty) {
          _calculate();
        }
        _operand = value;
      } else if (_number1.isEmpty || _operand.isEmpty) {
        if (value == Btn.dot && _number1.contains(Btn.dot)) return;
        if (value == Btn.dot && (_number1.isEmpty || _number1 == Btn.n0)) {
          value = "0.";
        }
        _number1 += value;
      } else if (_number2.isEmpty || _operand.isNotEmpty) {
        if (value == Btn.dot && _number2.contains(Btn.dot)) return;
        if (value == Btn.dot && (_number2.isEmpty || _number2 == Btn.n0)) {
          value = "0.";
        }
        _number2 += value;
      }
    });
  }
}











// import 'package:calculator/button_values.dart';
// import 'package:flutter/material.dart';

// class CalculatorScreen extends StatefulWidget {
//   const CalculatorScreen({super.key});

//   @override
//   State<CalculatorScreen> createState() => _CalculatorScreenState();
// }

// class _CalculatorScreenState extends State<CalculatorScreen> {
//   String number1 = ""; // . 0-9
//   String operand = ""; // + - * /
//   String number2 = ""; // . 0-9

//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;
//     return Scaffold(
//       body: SafeArea(
//         bottom: false,
//         child: Column(
//           children: [
//             // output
//             Expanded(
//               child: SingleChildScrollView(
//                 reverse: true,
//                 child: Container(
//                   alignment: Alignment.bottomRight,
//                   padding: const EdgeInsets.all(16),
//                   child: Text(
//                     "$number1$operand$number2".isEmpty
//                         ? "0"
//                         : "$number1$operand$number2",
//                     style: const TextStyle(
//                       fontSize: 48,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     textAlign: TextAlign.end,
//                   ),
//                 ),
//               ),
//             ),

//             // buttons
//             Wrap(
//               children: Btn.buttonValues
//                   .map(
//                     (value) => SizedBox(
//                       width: value == Btn.n0
//                           ? screenSize.width / 2
//                           : (screenSize.width / 4),
//                       height: screenSize.width / 5,
//                       child: buildButton(value),
//                     ),
//                   )
//                   .toList(),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildButton(value) {
//     return Padding(
//       padding: const EdgeInsets.all(4.0),
//       child: Material(
//         color: getBtnColor(value),
//         clipBehavior: Clip.hardEdge,
//         shape: OutlineInputBorder(
//           borderSide: const BorderSide(
//             color: Colors.white24,
//           ),
//           borderRadius: BorderRadius.circular(100),
//         ),
//         child: InkWell(
//           onTap: () => onBtnTap(value),
//           child: Center(
//             child: Text(
//               value,
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 24,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // ########
//   void onBtnTap(String value) {
//     if (value == Btn.del) {
//       delete();
//       return;
//     }

//     if (value == Btn.clr) {
//       clearAll();
//       return;
//     }

//     if (value == Btn.per) {
//       convertToPercentage();
//       return;
//     }

//     if (value == Btn.calculate) {
//       calculate();
//       return;
//     }

//     appendValue(value);
//   }

//   // ##############
//   // calculates the result
//   void calculate() {
//     if (number1.isEmpty) return;
//     if (operand.isEmpty) return;
//     if (number2.isEmpty) return;

//     final double num1 = double.parse(number1);
//     final double num2 = double.parse(number2);

//     var result = 0.0;
//     switch (operand) {
//       case Btn.add:
//         result = num1 + num2;
//         break;
//       case Btn.subtract:
//         result = num1 - num2;
//         break;
//       case Btn.multiply:
//         result = num1 * num2;
//         break;
//       case Btn.divide:
//         result = num1 / num2;
//         break;
//       default:
//     }

//     setState(() {
//       number1 = result.toStringAsPrecision(3);

//       if (number1.endsWith(".0")) {
//         number1 = number1.substring(0, number1.length - 2);
//       }

//       operand = "";
//       number2 = "";
//     });
//   }

//   // ##############
//   // converts output to %
//   void convertToPercentage() {
//     // ex: 434+324
//     if (number1.isNotEmpty && operand.isNotEmpty && number2.isNotEmpty) {
//       // calculate before conversion
//       calculate();
//     }

//     if (operand.isNotEmpty) {
//       // cannot be converted
//       return;
//     }

//     final number = double.parse(number1);
//     setState(() {
//       number1 = "${(number / 100)}";
//       operand = "";
//       number2 = "";
//     });
//   }

//   // ##############
//   // clears all output
//   void clearAll() {
//     setState(() {
//       number1 = "";
//       operand = "";
//       number2 = "";
//     });
//   }

//   // ##############
//   // delete one from the end
//   void delete() {
//     if (number2.isNotEmpty) {
//       // 12323 => 1232
//       number2 = number2.substring(0, number2.length - 1);
//     } else if (operand.isNotEmpty) {
//       operand = "";
//     } else if (number1.isNotEmpty) {
//       number1 = number1.substring(0, number1.length - 1);
//     }

//     setState(() {});
//   }

//   // #############
//   // appends value to the end
//   void appendValue(String value) {
//     // number1 opernad number2
//     // 234       +      5343

//     // if is operand and not "."
//     if (value != Btn.dot && int.tryParse(value) == null) {
//       // operand pressed
//       if (operand.isNotEmpty && number2.isNotEmpty) {
//         // TODO calculate the equation before assigning new operand
//         calculate();
//       }
//       operand = value;
//     }
//     // assign value to number1 variable
//     else if (number1.isEmpty || operand.isEmpty) {
//       // check if value is "." | ex: number1 = "1.2"
//       if (value == Btn.dot && number1.contains(Btn.dot)) return;
//       if (value == Btn.dot && (number1.isEmpty || number1 == Btn.n0)) {
//         // ex: number1 = "" | "0"
//         value = "0.";
//       }
//       number1 += value;
//     }
//     // assign value to number2 variable
//     else if (number2.isEmpty || operand.isNotEmpty) {
//       // check if value is "." | ex: number1 = "1.2"
//       if (value == Btn.dot && number2.contains(Btn.dot)) return;
//       if (value == Btn.dot && (number2.isEmpty || number2 == Btn.n0)) {
//         // number1 = "" | "0"
//         value = "0.";
//       }
//       number2 += value;
//     }

//     setState(() {});
//   }

//   // ########
//   Color getBtnColor(value) {
//     return [Btn.del, Btn.clr].contains(value)
//         ? Colors.blueGrey
//         : [
//             Btn.per,
//             Btn.multiply,
//             Btn.add,
//             Btn.subtract,
//             Btn.divide,
//             Btn.calculate,
//           ].contains(value)
//             ? Colors.orange
//             : Colors.black87;
//   }
// }
