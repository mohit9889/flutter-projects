import 'package:math_expressions/math_expressions.dart';

String getResult(String exp){
  Parser p = new Parser();
  ContextModel cm = new ContextModel();
  Expression ex = p.parse(exp);
  String result =  ex.evaluate(EvaluationType.REAL, cm).toString();
  int dotIndex= result.indexOf('.',0);
  if (result.length  > dotIndex+3){
    return result.substring(0,dotIndex+4);
  }
  else{
    return result;
  }


}