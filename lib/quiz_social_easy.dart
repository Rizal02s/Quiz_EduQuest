import 'dart:async'; // ✅ Tambahan: untuk fitur timer
import 'package:flutter/material.dart'; // Mengimpor material design Flutter
import 'soal_easy.dart'; // Mengimpor daftar soal dari file soal_easy.dart

class QuizSocialEasyPage extends StatefulWidget {
  const QuizSocialEasyPage({Key? key}) : super(key: key);

  @override
  State<QuizSocialEasyPage> createState() => _QuizSocialEasyPageState();
}

class _QuizSocialEasyPageState extends State<QuizSocialEasyPage> {
  int currentQuestion = 0;
  int score = 0;
  String? selectedAnswer;
  int lives = 3;

  bool showResultOverlay = false;
  bool lastAnswerCorrect = false;

  final Duration resultDuration = const Duration(milliseconds: 900);

  // ✅ Tambahan: variabel untuk timer
  int timeLeft = 15; // waktu awal setiap stage (10 detik)
  Timer? timer; // untuk mengatur perhitungan waktu mundur

  // ✅ Tambahan: fungsi untuk memulai timer setiap kali soal dimulai
  void startTimer() {
    timer?.cancel(); // batalkan timer lama jika ada
    timeLeft = 15; // reset waktu ke 10 detik
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        timeLeft--;
        if (timeLeft <= 0) {
          // jika waktu habis
          lives--; // kurangi nyawa
          if (lives <= 0) {
            // jika nyawa habis → tampilkan dialog kalah
            timer?.cancel();
            _showGameOverDialog();
          } else {
            // reset waktu untuk ulangi soal yang sama
            timeLeft = 15;
          }
        }
      });
    });
  }

  // ✅ Tambahan: fungsi untuk menghentikan timer
  void stopTimer() {
    timer?.cancel();
  }

  // ✅ Tambahan: tampilkan dialog kalah jika nyawa 0
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
              startTimer(); // restart timer saat mulai ulang quiz
            },
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }

  // ✅ Tambahan: panggil startTimer saat halaman pertama kali dibuka
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  // ✅ Tambahan: hentikan timer ketika widget dihapus dari tree
  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

// animasi transisi soal dan jawaban
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
          stopTimer(); // ✅ hentikan timer di akhir quiz
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
          startTimer(); // ✅ restart timer tiap ganti soal
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
    final questionMap = questions[currentQuestion];
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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Tambahan: pindahkan stage dan timer ke atas soal
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
                    '⏱️ $timeLeft detik', // tampilkan waktu di atas soal
                    style: const TextStyle(
                      color: Colors.yellowAccent,
                      fontSize: 18,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 18),

                  // ✅ Posisi soal tetap di bawah timer sekarang
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
                  _buildLivesRow(), // nyawa tetap di bawah
                  const SizedBox(height: 10),

                  IconButton(
                    icon: const Icon(
                      Icons.flag,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
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
