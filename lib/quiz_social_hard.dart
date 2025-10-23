import 'dart:async';
import 'package:flutter/material.dart';

class QuizSocialHardPage extends StatefulWidget {
  const QuizSocialHardPage({Key? key}) : super(key: key);

  @override
  State<QuizSocialHardPage> createState() => _QuizSocialHardPageState();
}

class _QuizSocialHardPageState extends State<QuizSocialHardPage> {
  int currentQuestion = 0;
  int score = 0;
  String? selectedAnswer;
  int lives = 3;

  bool showResultOverlay = false;
  bool lastAnswerCorrect = false;

  final Duration resultDuration = const Duration(milliseconds: 900);

  // ✅ Timer
  int timeLeft = 15; // waktu awal setiap stage (15 detik)
  Timer? timer;

  void startTimer() {
    timer?.cancel();
    timeLeft = 15;
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        timeLeft--;
        if (timeLeft <= 0) {
          lives--;
          if (lives <= 0) {
            timer?.cancel();
            _showGameOverDialog();
          } else {
            timeLeft = 15;
          }
        }
      });
    });
  }

  void stopTimer() {
    timer?.cancel();
  }

  void _showGameOverDialog() {
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
              startTimer();
            },
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  // ===== SOAL =====
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

  void onCheckPressed() {
    if (selectedAnswer == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih jawaban terlebih dahulu')),
      );
      return;
    }
    final correct = (questions[currentQuestion]['correct'] as String)
        .trim()
        .toLowerCase();
    final selected = selectedAnswer!.trim().toLowerCase();
    final bool isCorrect = selected == correct;

    setState(() {
      lastAnswerCorrect = isCorrect;
      showResultOverlay = true;
      if (isCorrect)
        score += 20;
      else {
        lives = lives - 1;
        if (lives < 0) lives = 0;
      }
    });

    Future.delayed(resultDuration, () {
      if (isCorrect) {
        if (currentQuestion >= questions.length - 1) {
          stopTimer();
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
            currentQuestion++;
            selectedAnswer = null;
            showResultOverlay = false;
          });
          startTimer();
        }
      } else {
        if (lives <= 0) {
          stopTimer();
          _showGameOverDialog();
        } else {
          setState(() {
            showResultOverlay = false;
            selectedAnswer = null;
          });
        }
      }
    });
  }

  Widget _buildLivesRow() {
    List<Widget> hearts = [];
    for (int i = 0; i < 3; i++) {
      hearts.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          child: Icon(
            i < lives ? Icons.favorite : Icons.favorite_border,
            color: i < lives ? Colors.redAccent : Colors.white70,
            size: 28,
          ),
        ),
      );
    }
    return Row(mainAxisSize: MainAxisSize.min, children: hearts);
  }

  @override
  Widget build(BuildContext context) {
    final questionMap = questions[currentQuestion];
    final answers = List<String>.from(questionMap['answers']);

    return Scaffold(
      body: Container(
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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Stage ${currentQuestion + 1} / ${questions.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '⏱️ $timeLeft detik',
                    style: const TextStyle(
                      color: Colors.yellowAccent,
                      fontSize: 18,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 18),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 420),
                    transitionBuilder: (child, anim) {
                      final inAnim = Tween<Offset>(
                        begin: const Offset(1, 0),
                        end: Offset.zero,
                      ).animate(anim);
                      return SlideTransition(position: inAnim, child: child);
                    },
                    child: _buildQuestionCard(
                      questionMap,
                      answers,
                      key: ValueKey(currentQuestion),
                    ),
                  ),
                  const SizedBox(height: 24),
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
                  const SizedBox(height: 18),
                  _buildLivesRow(),
                  const SizedBox(height: 10),
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              if (showResultOverlay) _buildResultOverlay(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionCard(Map<String, dynamic> q, List<String> answers,
      {Key? key}) {
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
              q['question'],
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          const SizedBox(height: 12),
          ...answers.map((ans) {
            final isSelected = selectedAnswer == ans;
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              width: 320,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isSelected ? Colors.lightBlueAccent : Colors.white,
                  foregroundColor: isSelected ? Colors.white : Colors.black,
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: showResultOverlay
                    ? null
                    : () => setState(() => selectedAnswer = ans),
                child: Text(
                  ans,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

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
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color:
                          lastAnswerCorrect ? Colors.green[50] : Colors.red[50],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      lastAnswerCorrect ? Icons.check_circle : Icons.cancel,
                      color:
                          lastAnswerCorrect ? Colors.green : Colors.red,
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: 16),
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
