import 'dart:io';
import 'dart:math';

const int subjectCount = 3;
const int passThreshold = 60;

class Student {
  final String name;
  final List<int> scores;
  Student(this.name, this.scores) {
    if (scores.length != subjectCount) {
      throw ArgumentError('scores length must be $subjectCount');
    }
  }
  double get average => scores.reduce((a, b) => a + b) / subjectCount;
  String get passFail => average >= passThreshold ? 'PASS' : 'FAIL';
  @override
  String toString() => 'Student(name: $name, scores: $scores, avg: ${average.toStringAsFixed(1)}, $passFail)';
}

final _rand = Random();

final List<String> fixedNames = [
  '김가온','이도윤','박서연','최하준','정지우',
  '한서윤','조민준','윤서현','장예린','송주원'
];

String randomFixedKoreanName() => fixedNames[_rand.nextInt(fixedNames.length)];

List<int> randomScores() => List.generate(subjectCount, (_) => _rand.nextInt(101));

void printTable(List<Student> list) {
  print(''.padRight(72, '-'));
  print('| ${'Name'.padRight(12)} | ${'Sub1'.padLeft(4)} | ${'Sub2'.padLeft(4)} | ${'Sub3'.padLeft(4)} | ${'Avg'.padLeft(5)} | ${'Result'.padRight(6)} |');
  print(''.padRight(72, '-'));
  for (final s in list) {
    print('| ${s.name.padRight(12)} |'
        ' ${s.scores[0].toString().padLeft(4)} |'
        ' ${s.scores[1].toString().padLeft(4)} |'
        ' ${s.scores[2].toString().padLeft(4)} |'
        ' ${s.average.toStringAsFixed(1).padLeft(5)} |'
        ' ${s.passFail.padRight(6)} |');
  }
  print(''.padRight(72, '-'));
}

void main() {
  stdout.write('생성할 학생 수를 입력하세요 (예: 10): ');
  final nStr = stdin.readLineSync();
  final n = int.tryParse(nStr ?? '');
  if (n == null || n <= 0) {
    print('유효한 학생 수를 입력해야 합니다.');
    return;
  }
  final List<Student> students = List.generate(n, (_) => Student(randomFixedKoreanName(), randomScores()));
  print('\n정렬 기준을 선택하세요:');
  print('1) 이름  2) 평균  3) 과목1  4) 과목2  5) 과목3');
  stdout.write('번호 입력: ');
  final keyStr = stdin.readLineSync();
  final key = int.tryParse(keyStr ?? '');
  if (key == null || key < 1 || key > 5) {
    print('유효한 정렬 기준을 선택해야 합니다.');
    return;
  }
  print('\n정렬 방향을 선택하세요:');
  print('1) 오름차순  2) 내림차순');
  stdout.write('번호 입력: ');
  final dirStr = stdin.readLineSync();
  final dir = int.tryParse(dirStr ?? '');
  final ascending = (dir == 1);
  students.sort((a, b) {
    int cmp;
    switch (key) {
      case 1:
        cmp = a.name.compareTo(b.name);
        break;
      case 2:
        cmp = a.average.compareTo(b.average);
        break;
      case 3:
        cmp = a.scores[0].compareTo(b.scores[0]);
        break;
      case 4:
        cmp = a.scores[1].compareTo(b.scores[1]);
        break;
      case 5:
        cmp = a.scores[2].compareTo(b.scores[2]);
        break;
      default:
        cmp = 0;
    }
    return ascending ? cmp : -cmp;
  });
  print('\n정렬 결과');
  printTable(students);
  final averages = students.map((s) => s.average).toList();
  final classAvg = averages.reduce((a, b) => a + b) / averages.length;
  final best = averages.reduce(max);
  final worst = averages.reduce(min);
  final passCount = students.where((s) => s.passFail == 'PASS').length;
  print('전체 평균: ${classAvg.toStringAsFixed(2)}');
  print('최고 평균: ${best.toStringAsFixed(2)}');
  print('최저 평균: ${worst.toStringAsFixed(2)}');
  print('PASS 인원: $passCount / ${students.length}');
}
