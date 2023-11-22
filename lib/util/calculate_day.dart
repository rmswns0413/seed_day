import 'package:intl/intl.dart';

class CalculateDay{

  DateTime targetDay;

  CalculateDay(this.targetDay);

  bool isBorn(){
    return targetDay.isBefore(DateTime.now());
  }
  int getDigit(){
    Duration difference = targetDay.difference(DateTime.now());
    int number = difference.inDays+1;
    if (number == 0) {
      return 1; // 0은 한 자리
    }
    int count = 0;
    while (number != 0) {
      number ~/= 10; // 정수 나눗셈을 통해 자리수를 하나씩 제거
      count++;
    }
    return count;
  }
  List<int> getDigitNumber(){
    Duration difference = targetDay.difference(DateTime.now());
    int number = difference.inDays+1;
    List<int> digits = [];

    if (number == 0) {
      digits.add(0);
    } else {
      while (number > 0) {
        digits.insert(0, number % 10); // 맨 앞에 자리수 추가
        number ~/= 10; // 다음 자리수로 이동
      }
    }
    return digits;
  }
  int getDay(){
    Duration difference = targetDay.difference(DateTime.now());
    return difference.inDays+1;
  }
  String getCurrentTime() {

    return DateFormat('HH:mm:ss').format(DateTime.now());
  }

  String? getCurrentDate() {
    return DateFormat('yyyy/MM/dd').format(DateTime.now());
  }
}