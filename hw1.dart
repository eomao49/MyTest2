import 'dart:io';

void main() {
  stdout.write('정수를 입력하세요: ');
  final input = stdin.readLineSync();
  if (input == null) {
    print('입력이 없습니다.');
    return;
  }
  final n = int.tryParse(input.trim());
  if (n == null) {
    print('정수를 입력해야 합니다.');
    return;
  }
  if (n < 0) {
    print(n);
    return;
  }
  int sum = 0;
  int x = n;
  while (x > 0) {
    sum += x % 10;
    x ~/= 10;
  }
  if (n == 0) sum = 0;
  print(sum);
}
