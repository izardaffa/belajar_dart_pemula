import 'dart:io';

class Task {
  String title;
  bool isDone;

  Task(this.title, {this.isDone = false});

  void display() {
    String status = isDone ? '[x]' : '[ ]';
    print('$status $title');
  }
}

List<Task> tasks = [];

void addTask() {
  stdout.write('Masukkan judul task baru: ');
  String title = stdin.readLineSync()!;

  if (title.isNotEmpty) {
    tasks.add(Task(title));
    print('Success! Task "$title" berhasil ditambahkan!');
  } else {
    print('Warning! Judul task tidak boleh kosong.');
  }
}

void viewTasks() {
  print('\n--- Daftar Tugas ---');

  if (tasks.isEmpty) {
    print('Anda belum memiliki tugas!');
  } else {
    for (int i = 0; i < tasks.length; i++) {
      stdout.write('${i + 1}. ');
      tasks[i].display();
    }
  }

  print('--- Selesai ---');
}

void completeTask() {
  viewTasks();
  if (tasks.isEmpty) return;

  stdout.write('Masukkan nomor task yang ingin ditandai selesai: ');
  try {
    int index = int.parse(stdin.readLineSync()!) - 1;

    if (index >= 0 && index < tasks.length) {
      tasks[index].isDone = true;
      print('Task "${tasks[index].title}" telah ditandai selesai!');
    } else {
      print('Error: Nomor tidak valid.');
    }
  } catch (e) {
    print('Error: Input tidak valid. Harap masukkan angka.');
  }
}

void deleteTask() {
  viewTasks();
  if (tasks.isEmpty) return;

  stdout.write('Masukkan nomor task yang ingin dihapus: ');
  try {
    int index = int.parse(stdin.readLineSync()!) - 1;

    if (index >= 0 && index < tasks.length) {
      String removedTitle = tasks[index].title;
      tasks.removeAt(index);
      print('Task "$removedTitle" telah dihapus.');
    } else {
      print('Error: Nomor tidak valid.');
    }
  } catch (e) {
    print('Error: Input tidak valid. Harap masukkan angka.');
  }
}

void main() {
  while (true) {
    print('\n--- To-Do List ---');
    print('1. Tampilkan Semua Task.');
    print('2. Tambah Task');
    print('3. Tandai Selesai');
    print('4. Hapus Task');
    print('5. Keluar');
    stdout.write('Pilih menu (1-5): ');

    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        viewTasks();
        break;
      case '2':
        addTask();
        break;
      case '3':
        completeTask();
        break;
      case '4':
        deleteTask();
        break;
      case '5':
        print('--- Bye ---');
        return;
      default:
        print('Pilihan tidak valid. Silahkan coba lagi.');
    }
  }
}
