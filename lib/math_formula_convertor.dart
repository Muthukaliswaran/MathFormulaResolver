import 'package:function_tree/function_tree.dart';

class MathFormulaConvertor{
  static String evaluatedExpr ="";

  static Future<String?> mathFunc(String expr) async{
    evaluatedExpr = expr;
    int addIndex = expr.contains("add") ? expr.indexOf("add") : -1;
    int subtractIndex =
    expr.contains("subtract") ? expr.indexOf("subtract") : -1;
    int multiplyIndex =
    expr.contains("multiply") ? expr.indexOf("multiply") : -1;
    int divideIndex = expr.contains("divide") ? expr.indexOf("divide") : -1;

    List<int> numberIndex = [
      addIndex,
      subtractIndex,
      multiplyIndex,
      divideIndex
    ];
    int minimumValue = -1;
    int minimumIndex = -1;

    for (int j in numberIndex) {
      if (j != -1) {
        if (j < minimumValue || minimumValue == -1) {
          minimumValue = j;
          minimumIndex = numberIndex.indexOf(j);
        }
      }
    }

    if (minimumIndex == -1) {
      evaluatedExpr = evaluatedExpr.replaceAll("@", "(");
      evaluatedExpr = evaluatedExpr.replaceAll("#", ")");
      try {
        if (evaluatedExpr.isNotEmpty) {
          if (evaluatedExpr.interpret().isFinite &&
              !evaluatedExpr.interpret().isNaN) {
            var textVal =
            double.parse(evaluatedExpr.interpret().toStringAsFixed(2))
                .toString();
            if (textVal.contains(".")) {
              var strList = textVal.split(".");
              if (double.parse(strList[1]) > 0) {
                return textVal;
              } else {
                return strList[0];
              }
            } else {
              return textVal;
            }
          } else {
            return "";
          }
        }else{
          return "";
        }
      } on Exception catch (e) {
         return "exception";
      }
    }

    if (minimumIndex == 0) {
      findAndReplaceComma("+", evaluatedExpr.indexOf("add("));
      evaluatedExpr = evaluatedExpr.replaceFirst("add(", "@");
      replaceCloseBracket();
    }

    if (minimumIndex == 1) {
      findAndReplaceComma("-", evaluatedExpr.indexOf("subtract("));
      evaluatedExpr = evaluatedExpr.replaceFirst("subtract(", "@");
      replaceCloseBracket();
    }

    if (minimumIndex == 2) {
      findAndReplaceComma("*", evaluatedExpr.indexOf("multiply("));
      evaluatedExpr = evaluatedExpr.replaceFirst("multiply(", "@");
      replaceCloseBracket();
    }

    if (minimumIndex == 3) {
      findAndReplaceComma("/", evaluatedExpr.indexOf("divide("));
      evaluatedExpr = evaluatedExpr.replaceFirst("divide(", "@");
      replaceCloseBracket();
    }

    return mathFunc(evaluatedExpr);
  }

  static String replaceCharAt(String oldString, int index, String newChar) {
    return oldString.substring(0, index) +
        newChar +
        oldString.substring(index + 1);
  }

  static replaceCloseBracket() {
    int tempOpenBracketCount = 1;
    for (int h = 0; h < evaluatedExpr.length; h++) {
      if (evaluatedExpr[h] == "(") {
        tempOpenBracketCount++;
      } else if (evaluatedExpr[h] == ")") {
        tempOpenBracketCount--;
      }

      if (tempOpenBracketCount == 0) {
        evaluatedExpr = replaceCharAt(evaluatedExpr, h, "#");
        break;
      }
    }
  }

  static findAndReplaceComma(String operatorSymbol, int firstReplaceableIndex) {
    int firstCommaIndex = evaluatedExpr.indexOf(",");
    int parenthesisCount = 0;
    int tempCommaCount = 0;
    int commaIndex = 0;
    //Count parenthesis
    for (int k = 0; k < evaluatedExpr.length; k++) {
      if (k >= firstReplaceableIndex) {
        if (k < firstCommaIndex) {
          if (evaluatedExpr[k] == '(') {
            parenthesisCount++;
          }
          if (evaluatedExpr[k] == ')') {
            parenthesisCount--;
          }
        } else {
          break;
        }
      }
    }

    //Replace exact comma with operator
    for (int k = 0; k < evaluatedExpr.length; k++) {
      if (evaluatedExpr[k] == ',') {
        tempCommaCount++;
      }
      if (evaluatedExpr[k] == ')') {
        parenthesisCount--;
      }

      if (parenthesisCount == tempCommaCount) {
        commaIndex = k;

        String splitString = evaluatedExpr.substring(0, commaIndex);
        int tempOpenBracketCount = 0;
        int tempCloseBracketCount = 0;

        for (int k = 0; k < splitString.length; k++) {
          if (splitString[k] == '(' && k >= firstReplaceableIndex) {
            tempOpenBracketCount++;
          }
          if (splitString[k] == ')' && k >= firstReplaceableIndex) {
            tempCloseBracketCount++;
          }
        }

        if (tempOpenBracketCount - tempCloseBracketCount == 1) {
          // Replace comma until close bracket, because we can give multiple arguments more than two in add and multiply segments.
          int openBracketCount = 1;

          for (int h = commaIndex; h < evaluatedExpr.length; h++) {
            if (evaluatedExpr[h].contains("(")) {
              openBracketCount++;
            }

            if (evaluatedExpr[h].contains(")")) {
              openBracketCount--;
            }

            if (openBracketCount == 1) {
              if (evaluatedExpr[h].contains(",")) {
                evaluatedExpr = replaceCharAt(evaluatedExpr, h, operatorSymbol);
              }
            }

            if (openBracketCount == 0) {
              break;
            }
          }
          break;
        } else {
          parenthesisCount++;
        }
      }
    }
  }
}