import 'package:flutter/material.dart'; // Mengimpor material design Flutter

// Widget utama quiz, berbasis StatefulWidget (karena ada perubahan state setiap interaksi)
class QuizSocialEasyPage extends StatefulWidget {
  const QuizSocialEasyPage({Key? key}) : super(key: key); // Konstruktor widget

  @override
  State<QuizSocialEasyPage> createState() => _QuizSocialEasyPageState(); // Membuat instance state
}

// State untuk halaman quiz
class _QuizSocialEasyPageState extends State<QuizSocialEasyPage> {
  int currentQuestion =
      0; // Menyimpan indeks soal yang ditampilkan setelah interaksi
  int score = 0; // Menyimpan skor pemain
  String?
  selectedAnswer; // Menyimpan jawaban yang dipilih user (nullable, bisa kosong)
  int lives = 3; // Nyawa pemain, berkurang tiap jawaban salah

  bool showResultOverlay =
      false; // Apakah overlay hasil jawaban (benar/salah) ditampilkan
  bool lastAnswerCorrect = false; // Status jawaban terakhir (benar/salah)

  final Duration resultDuration = const Duration(
    milliseconds: 900,
  ); // Durasi overlay feedback muncul

  // Daftar soal: tiap soal berupa Map berisi pertanyaan, pilihan jawaban, dan jawaban benar
  final List<Map<String, dynamic>> questions = [
    {
      'question':
          'Pada zaman Mesozoikum, salah satu periode yang ada pada era tersebut adalah …',
      'answers': ['Paleogen', 'Cretaceous', 'Kambrium', 'Protozoikum'],
      'correct': 'Cretaceous',
    },
    {
      'question':
          'Kumpulan bintang yang jumlahnya bermiliar-miliar merupakan pengertian singkat dari …',
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
      'answers': [
        'Kematian Broz Tito',
        'Invasi Serbia',
        'Perang Dunia I',
        'Menganut Sosialis',
      ],
      'correct': 'Kematian Broz Tito',
    },
    {
      'question': 'Kerajaan Tarumanegara dipimpin oleh …',
      'answers': ['Dedi Mulyadi', 'Mulawarman', 'Purnawarman', 'Sima'],
      'correct': 'Purnawarman',
    },
    {
      'question': 'Sultan Malik Al-Saleh pernah memimpin kerajaan …',
      'answers': [
        'Samudra Pasai',
        'Darul Islam/TII',
        'Kerajaan Aceh',
        'Malaka',
      ],
      'correct': 'Samudra Pasai',
    },
    {
      'question': 'Salah satu tokoh Reformasi Gereja adalah …',
      'answers': [
        'Leonardo Bonapartae',
        'Bonmati',
        'Michaelangelo Bunorrotti',
        'Martin Luther',
      ],
      'correct': 'Martin Luther',
    },
    {
      'question':
          'Kerajaan yang berhasil menaklukkan Kota Konstantinopel pada tahun 1453 M adalah …',
      'answers': [
        'Romawi',
        'Kerajaan Inggris',
        'Ottoman (Utsmani)',
        'Kerajaan Mughal',
      ],
      'correct': 'Ottoman (Utsmani)',
    },
    {
      'question': 'Penemu mesin uap adalah …',
      'answers': ['Abraham Darby', 'James Watt', 'Morse', 'Elias Howe'],
      'correct': 'James Watt',
    },
    {
      'question':
          'Perubahan cara produksi barang dari manusia ke mesin disebut juga …',
      'answers': [
        'Revolusi Perancis',
        'Revolusi Industri',
        'Renaissance',
        'Europe Springs',
      ],
      'correct': 'Revolusi Industri',
    },
    {
      'question': 'Salah satu tokoh Renaissance adalah …',
      'answers': ['Leonardo Davinci', 'John Calvin', 'Nico Paz', 'Eren Yeager'],
      'correct': 'Leonardo Davinci',
    },
    {
      'question': 'Orang Belanda pertama yang tiba di Indonesia adalah …',
      'answers': [
        'Pieter Both',
        'Leonardo Bonapartae',
        'Jack Sparrow',
        'Cornelius de Houtman',
      ],
      'correct': 'Cornelius de Houtman',
    },
    {
      'question':
          'Daerah Indonesia yang saat ini masih menganut sistem monarki adalah …',
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
      'answers': [
        'Soekarno',
        'Moh. Hatta',
        'Danudirja Setyabudi',
        'Ki Hajar Dewantara',
      ],
      'correct': 'Danudirja Setyabudi',
    },
    {
      'question':
          'Henk Sneevliet membawa kelompok Social Democratische Partij ke Indonesia dengan paham …',
      'answers': ['Sosialis', 'Ide Marx-Lenin', 'Demokratik', 'Monarki'],
      'correct': 'Ide Marx-Lenin',
    },
    {
      'question': 'Sebab khusus terjadinya Perang Dunia ke-1 adalah …',
      'answers': [
        'Ideologi',
        'Kematian Franz Ferdinan',
        'Revolusi Eropa',
        'Megawati',
      ],
      'correct': 'Kematian Franz Ferdinan',
    },
    {
      'question':
          'Pemimpin reformis yang berperan besar dalam runtuhnya Uni Soviet adalah …',
      'answers': [
        'Vladimir Bahlil',
        'Gibran',
        'Mikhail Gorbachev',
        'Benito Musollini',
      ],
      'correct': 'Mikhail Gorbachev',
    },
    {
      'question':
          'Blok Barat memiliki NATO, sebagai tandingan Uni Soviet membentuk …',
      'answers': ['SEATO', 'AFC', 'Conmebol', 'Pakta Warsawa'],
      'correct': 'Pakta Warsawa',
    },
  ];

  // Fungsi ketika tombol Check ditekan
  void onCheckPressed() {
    if (selectedAnswer == null) {
      // Jika user belum memilih jawaban
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pilih jawaban terlebih dahulu'),
        ), // Tampilkan pesan jika tidak ada pilihan
      );
      return; // Langsung keluar dari fungsi
    }
    // Normalisasi dan validasi jawaban
    final correct = (questions[currentQuestion]['correct'] as String)
        .trim()
        .toLowerCase();
    final selected = selectedAnswer!.trim().toLowerCase();
    final bool isCorrect = selected == correct; // Cek apakah jawaban benar

    // Update state: tampilkan overlay hasil, tambah skor/kurangi nyawa
    setState(() {
      lastAnswerCorrect = isCorrect;
      showResultOverlay = true;
      if (isCorrect)
        score += 20;
      else {
        lives = lives - 1;
        if (lives < 0) lives = 0; // Nyawa tidak boleh negatif
      }
    });

    // Setelah overlay muncul, lanjutkan sesuai logika quiz (benar/salah, soal selesai/nyawa habis)
    Future.delayed(resultDuration, () {
      if (isCorrect) {
        // Jika benar
        if (currentQuestion >= questions.length - 1) {
          // Cek apakah soal terakhir
          setState(() {
            showResultOverlay = false;
          });
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => AlertDialog(
              title: const Text('🏁 Quiz Selesai!'),
              content: Text('Skor akhir kamu: $score'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: const Text('Back to Home'),
                ),
              ],
            ),
          );
        } else {
          setState(() {
            currentQuestion++; // Lanjut ke soal berikutnya
            selectedAnswer = null;
            showResultOverlay = false;
          });
        }
      } else {
        // Salah
        if (lives <= 0) {
          // Nyawa habis
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => AlertDialog(
              title: const Text('Your chance is over..'),
              content: const Text('You lost.. try again.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      currentQuestion = 0;
                      score = 0;
                      lives = 3;
                      selectedAnswer = null;
                      showResultOverlay = false;
                    });
                  },
                  child: const Text('Try Again'),
                ),
              ],
            ),
          );
        } else {
          // Nyawa belum habis, boleh coba lagi soal yang sama
          setState(() {
            showResultOverlay = false;
            selectedAnswer = null;
          });
        }
      }
    });
  }

  // Fungsi untuk membangun baris indikator nyawa (ikon hati)
  Widget _buildLivesRow() {
    List<Widget> hearts = [];
    for (int i = 0; i < 3; i++) {
      if (i < lives) {
        hearts.add(
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.0),
            child: Icon(Icons.favorite, color: Colors.redAccent, size: 28),
          ),
        );
      } else {
        hearts.add(
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.0),
            child: Icon(Icons.favorite_border, color: Colors.white70, size: 28),
          ),
        );
      }
    }
    return Row(mainAxisSize: MainAxisSize.min, children: hearts);
  }

  @override
  Widget build(BuildContext context) {
    // Fungsi untuk membangun UI layar quiz
    final questionMap = questions[currentQuestion]; // Ambil soal saat ini
    final List<String> answers = List<String>.from(
      questionMap['answers'] as List<dynamic>,
    );

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Bagian utama tampilan quiz
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 420),
                    transitionBuilder: (child, animation) {
                      final inAnim =
                          Tween<Offset>(
                                begin: const Offset(1, 0),
                                end: Offset.zero,
                              )
                              .chain(CurveTween(curve: Curves.easeOut))
                              .animate(animation);
                      return SlideTransition(position: inAnim, child: child);
                    },
                    child: _buildQuestionCard(
                      questionMap,
                      answers,
                      key: ValueKey<int>(currentQuestion),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Tombol Check
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: selectedAnswer == null || showResultOverlay
                          ? null
                          : onCheckPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedAnswer == null
                            ? Colors.grey
                            : Colors.greenAccent,
                        foregroundColor: Colors.black,
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        'Check',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Indikator nomor soal
                  Text(
                    'Stage ${currentQuestion + 1} / ${questions.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                    ),
                  ),

                  const SizedBox(height: 18),

                  // Row nyawa (ikon hati)
                  _buildLivesRow(),

                  const SizedBox(height: 10),

                  // Tombol kembali
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),

              // Overlay feedback hasil (benar/salah)
              if (showResultOverlay) _buildResultOverlay(),
            ],
          ),
        ),
      ),
    );
  }

  // Fungsi membangun card pertanyaan dan daftar jawaban
  Widget _buildQuestionCard(
    Map<String, dynamic> questionMap,
    List<String> answers, {
    Key? key,
  }) {
    return Container(
      key: key,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.92),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              questionMap['question'] as String,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Opsi jawaban (tombol)
          ...answers.map((answer) {
            final bool isSelected = selectedAnswer == answer;
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              width: 320,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isSelected
                      ? Colors.lightBlueAccent
                      : Colors.white,
                  foregroundColor: isSelected ? Colors.white : Colors.black,
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: showResultOverlay
                    ? null
                    : () {
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
          }).toList(),
        ],
      ),
    );
  }

  // Fungsi overlay feedback jawaban dengan animasi
  Widget _buildResultOverlay() {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.38,
      child: AnimatedOpacity(
        opacity: showResultOverlay ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 250),
        child: AnimatedScale(
          scale: showResultOverlay ? 1.0 : 0.6,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutBack,
          child: Material(
            elevation: 6,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Icon status
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: lastAnswerCorrect
                          ? Colors.green[50]
                          : Colors.red[50],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      lastAnswerCorrect ? Icons.check_circle : Icons.cancel,
                      color: lastAnswerCorrect ? Colors.green : Colors.red,
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Teks feedback
                  Expanded(
                    child: Text(
                      lastAnswerCorrect
                          ? 'Jawaban benar! +20 poin'
                          : 'Jawaban salah! -5 poin',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
