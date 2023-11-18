class DayCalculator {
  DateTime target;
  DayCalculator(this.target);

  getPrefix(){
    Duration duration = target.difference(DateTime.now());
    return duration.isNegative?'+':'-';
  }
  List<int> getDay() {
    Duration duration = target.difference(DateTime.now());
    int number = duration.inDays;
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
}
