import 'package:flutter/material.dart';

class QuizSocialEasyPage extends StatefulWidget {
  const QuizSocialEasyPage({Key? key}) : super(key: key);

  @override
  State<QuizSocialEasyPage> createState() => _QuizSocialEasyPageState();
}

class _QuizSocialEasyPageState extends State<QuizSocialEasyPage> {
  int currentQuestion = 0;
  int score = 0;
  String? selectedAnswer;

  // Semua 20 soal Social Easy
  final List<Map<String, dynamic>> questions = [
    {
      'question': 'Pada zaman Mesozoikum, salah satu periode yang ada pada era tersebut adalah …',
      'answers': ['Paleogen', 'Cretaceous', 'Kambrium', 'Protozoikum'],
      'correct': 'Cretaceous',
    },
    {
      'question': 'Kumpulan bintang yang jumlahnya bermiliar-miliar merupakan pengertian singkat dari …',
      'answers': ['Tata Surya', 'Planetoid', 'Asteroid', 'Galaksi'],
      'correct': 'Galaksi',
    },
    {
      'question': 'Lapisan atmosfer terbawah adalah …',
      'answers': ['Troposfer', 'Mesosfer', 'Termosfer', 'Stratosfer'],
      'correct': 'Troposfer',
    },
    {
      'question': 'Penghasil kopi terbesar di dunia adalah …',
      'answers': ['Brazil', 'Argentina', 'Chile', 'Colombia'],
      'correct': 'Brazil',
    },
    {
      'question': 'Salah satu penyebab runtuhnya Yugoslavia adalah …',
      'answers': ['Kematian Broz Tito', 'Invasi Serbia', 'Perang Dunia I', 'Menganut Sosialis'],
      'correct': 'Kematian Broz Tito',
    },
    {
      'question': 'Kerajaan Tarumanegara dipimpin oleh …',
      'answers': ['Dedi Mulyadi', 'Mulawarman', 'Purnawarman', 'Sima'],
      'correct': 'Purnawarman',
    },
    {
      'question': 'Sultan Malik Al-Saleh pernah memimpin kerajaan …',
      'answers': ['Samudra Pasai', 'Darul Islam/TII', 'Kerajaan Aceh', 'Malaka'],
      'correct': 'Samudra Pasai',
    },
    {
      'question': 'Salah satu tokoh Reformasi Gereja adalah …',
      'answers': ['Leonardo Bonapartae', 'Bonmati', 'Michaelangelo Bunorrotti', 'Martin Luther'],
      'correct': 'Martin Luther',
    },
    {
      'question': 'Kerajaan yang berhasil menaklukkan Kota Konstantinopel pada tahun 1453 M adalah …',
      'answers': ['Romawi', 'Kerajaan Inggris', 'Ottoman (Utsmani)', 'Kerajaan Mughal'],
      'correct': 'Ottoman (Utsmani)',
    },
    {
      'question': 'Penemu mesin uap adalah …',
      'answers': ['Abraham Darby', 'James Watt', 'Morse', 'Elias Howe'],
      'correct': 'James Watt',
    },
    {
      'question': 'Perubahan cara produksi barang dari manusia ke mesin disebut juga …',
      'answers': ['Revolusi Perancis', 'Revolusi Industri', 'Renaissance', 'Europe Springs'],
      'correct': 'Revolusi Industri',
    },
    {
      'question': 'Salah satu tokoh Renaissance adalah …',
      'answers': ['Leonardo Davinci', 'John Calvin', 'Nico Paz', 'Eren Yeager'],
      'correct': 'Leonardo Davinci',
    },
    {
      'question': 'Orang Belanda pertama yang tiba di Indonesia adalah …',
      'answers': ['Pieter Both', 'Leonardo Bonapartae', 'Jack Sparrow', 'Cornelius de Houtman'],
      'correct': 'Cornelius de Houtman',
    },
    {
      'question': 'Daerah Indonesia yang saat ini masih menganut sistem monarki adalah …',
      'answers': ['Aceh Darussalam', 'Bandung', 'Los Santos', 'Yogyakarta'],
      'correct': 'Yogyakarta',
    },
    {
      'question': 'Pemimpin partai PKI adalah …',
      'answers': ['D.N. Aidit', 'Musso', 'Bahlil Goblins', 'Semaun'],
      'correct': 'Semaun',
    },
    {
      'question': 'Penggagas utama Indische Partij adalah …',
      'answers': ['Soekarno', 'Moh. Hatta', 'Danudirja Setyabudi', 'Ki Hajar Dewantara'],
      'correct': 'Danudirja Setyabudi',
    },
    {
      'question': 'Henk Sneevliet membawa kelompok Social Democratische Partij ke Indonesia dengan paham …',
      'answers': ['Sosialis', 'Ide Marx-Lenin', 'Demokratik', 'Monarki'],
      'correct': 'Ide Marx-Lenin',
    },
    {
      'question': 'Sebab khusus terjadinya Perang Dunia ke-1 adalah …',
      'answers': ['Ideologi', 'Kematian Franz Ferdinan', 'Revolusi Eropa', 'Megawati'],
      'correct': 'Kematian Franz Ferdinan',
    },
    {
      'question': 'Pemimpin reformis yang berperan besar dalam runtuhnya Uni Soviet adalah …',
      'answers': ['Vladimir Bahlil', 'Gibran', 'Mikhail Gorbachev', 'Benito Musollini'],
      'correct': 'Mikhail Gorbachev',
    },
    {
      'question': 'Blok Barat memiliki NATO, sebagai tandingan Uni Soviet membentuk …',
      'answers': ['SEATO', 'AFC', 'Conmebol', 'Pakta Warsawa'],
      'correct': 'Pakta Warsawa',
    },
  ];

  void checkAnswer() {
    if (selectedAnswer == null) {
      // safety (seharusnya tombol Check disabled bila belum pilih)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih jawaban terlebih dahulu')),
      );
      return;
    }

    final correct = questions[currentQuestion]['correct'] as String;
    final bool isCorrect = selectedAnswer == correct;

    setState(() {
      if (isCorrect) {
        score += 20;
      } else {
        score -= 5;
      }
    });

    // tampilkan dialog hasil lalu lanjut
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        content: Text(
          isCorrect ? '✅ Jawaban benar! +20 poin' : '❌ Jawaban salah! -5 poin',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // tutup dialog
              nextQuestion();
            },
            child: const Text('Lanjut', style: TextStyle(fontFamily: 'Poppins')),
          ),
        ],
      ),
    );
  }

  void nextQuestion() {
    if (currentQuestion < questions.length - 1) {
      setState(() {
        currentQuestion++;
        selectedAnswer = null;
      });
    } else {
      // quiz selesai -> tampilkan skor akhir
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Text('🏁 Quiz Selesai!', style: TextStyle(fontFamily: 'Poppins')),
          content: Text('Skor akhir kamu: $score', style: const TextStyle(fontFamily: 'Poppins')),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // tutup dialog
                Navigator.of(context).pop(); // kembali ke halaman sebelumnya
              },
              child: const Text('Kembali ke Home', style: TextStyle(fontFamily: 'Poppins')),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestion];

    return Scaffold(
      // gunakan SafeArea jika ingin menjaga notch, tapi biarkan body full-screen
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img/background.jpg'), // sesuaikan path gambar
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // pertanyaan
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.92),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  question['question'] as String,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // jawaban
              ...((question['answers'] as List<String>).map((answer) {
                final bool isSelected = selectedAnswer == answer;
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  width: 320,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isSelected ? Colors.lightBlueAccent : Colors.white,
                      foregroundColor: isSelected ? Colors.white : Colors.black,
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      setState(() {
                        selectedAnswer = answer;
                      });
                    },
                    child: Text(
                      answer,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              })).toList(),

              const SizedBox(height: 18),

              // tombol Check (disabled jika belum pilih jawaban)
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: selectedAnswer == null ? null : checkAnswer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedAnswer == null ? Colors.grey : Colors.greenAccent,
                    foregroundColor: Colors.black,
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    'Check',
                    style: TextStyle(fontSize: 18, fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // indikator soal
              Text(
                'Soal ${currentQuestion + 1} / ${questions.length}',
                style: const TextStyle(color: Colors.white, fontFamily: 'Poppins'),
              ),

              const SizedBox(height: 18),

              // tombol back kecil
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
