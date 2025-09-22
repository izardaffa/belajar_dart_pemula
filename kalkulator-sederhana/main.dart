import 'dart:io';

void main() {
  print('--- Kalkulator Sederhana ---');

  stdout.write('Masukkan angka pertama: ');
  double angka1 = double.parse(stdin.readLineSync()!);

  stdout.write('Masukkan angka kedua: ');
  double angka2 = double.parse(stdin.readLineSync()!);

  stdout.write('Pilih operasi (+, -, *, /): ');
  String operasi = stdin.readLineSync()!;

  double? hasil;

  switch (operasi) {
    case '+':
      hasil = angka1 + angka2;
      break;
    case '-':
      hasil = angka1 - angka2;
      break;
    case '*':
      hasil = angka1 * angka2;
      break;
    case '/':
      if (angka2 != 0) {
        hasil = angka1 / angka2;
      } else {
        print('Error: Tidak bisa melakukan pembagian dengan angka nol.');
      }

      break;
    default:
      print('Operasi yang Anda masukkan tidak valid!');
  }

  if (hasil != null) {
    print('Hasil dari $angka1 $operasi $angka2 = $hasil');
  }

  print('--- Selesai ---');
}
