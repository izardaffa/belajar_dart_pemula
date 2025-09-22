import 'dart:io';

class Question {
  final String questionText;
  final List<Answer> answers;

  Question(this.questionText, this.answers);
}

class Answer {
  final String answerText;
  final bool isCorrect;

  Answer(this.answerText, this.isCorrect);
}

List<Question> getQuestions() {
  return [
    Question(
      'Dalam industri anime dan game di Jepang, apakah sebutan untuk seorang pengisi suara?',
      [
        Answer('Seiyuu', true),
        Answer('Animator', false),
        Answer('Mangaka', false),
        Answer('Idol', false),
      ],
    ),
    Question(
      'Manakah di antara seri berikut yang TIDAK termasuk dalam "The Big Three" dari anime shonen generasi awal 2000-an?',
      [
        Answer('Naruto', false),
        Answer('Attack on Titan', true),
        Answer('Bleach', false),
        Answer('One Piece', false),
      ],
    ),
    Question(
      'Apa istilah yang digunakan untuk karya seperti manga, novel, atau majalah yang diterbitkan secara independen oleh para penggemar?',
      [
        Answer('Doujinshi', true),
        Answer('Light Novel', false),
        Answer('Fan Fiction', false),
        Answer('Webtoon', false),
      ],
    ),
    Question('Dalam budaya otaku, istilah "waifu" merujuk pada...', [
      Answer('Karakter wanita favorit yang dianggap sebagai koleksi.', false),
      Answer('Jenis genre anime romantis.', false),
      Answer(
        'Karakter wanita fiksi yang dianggap oleh seorang penggemar sebagai istri ideal mereka.',
        true,
      ),
      Answer('Seorang cosplayer wanita terkenal.', false),
    ]),
    Question(
      'Aktivitas mengenakan kostum dan aksesori untuk merepresentasikan karakter tertentu dari anime, manga, atau video game disebut?',
      [
        Answer('Otome', false),
        Answer('Larper', false),
        Answer('Cosplay', true),
        Answer('Crossplay', false),
      ],
    ),
  ];
}

void main() {
  var questions = getQuestions();
  var currentQuestionIndex = 0;
  var score = 0;

  print('--- Welcome to Quiz App! ---');

  while (currentQuestionIndex < questions.length) {
    print('');
    print('Pertanyaan ${currentQuestionIndex + 1} / ${questions.length}:');
    print(questions[currentQuestionIndex].questionText);

    var currentAnswers = questions[currentQuestionIndex].answers;
    for (int i = 0; i < currentAnswers.length; i++) {
      print('${i + 1}. ${currentAnswers[i].answerText}');
    }

    stdout.write('Jawaban Anda (1-${currentAnswers.length}): ');
    int? userAnswer;
    try {
      userAnswer = int.parse(stdin.readLineSync()!);
      if (userAnswer < 1 || userAnswer > currentAnswers.length) {
        print(
          'Pilihan tidak valid. Harap masukkan angka antara 1 sampai ${currentAnswers.length}.',
        );
        continue;
      }
    } catch (e) {
      print('Input tidak valid. Harap masukkan sebuah angka.');
      continue;
    }

    if (currentAnswers[userAnswer - 1].isCorrect) {
      print('Jawaban Anda Benar!');
      score++;
    } else {
      print('Jawaban Anda Salah!');
    }

    currentQuestionIndex++;
  }

  print('\n--- Kuis Selesai ---');
  print('Jawaban benar $score dari ${questions.length} pertanyaan.');
  double percentage = (score / questions.length) * 100;
  print('Skor Anda = ${percentage.toStringAsFixed(1)}%');
  print('--- Exit ---');
}
