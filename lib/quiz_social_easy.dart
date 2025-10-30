import 'dart:async';
import 'package:flutter/material.dart';
import 'social_easy.dart';

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

  // ===== timer quiz =====
  int timeLeft = 20;
  Timer? timer;

  // === START COUNTDOWN ===
  int startCountdown = 5;
  Timer? startCountdownTimer;
  bool showStartOverlay = true;

  void startStartCountdown() {
    startCountdownTimer?.cancel();
    startCountdown = 5;
    setState(() {
      showStartOverlay = true;
    });
    startCountdownTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        startCountdown--;
        if (startCountdown <= 0) {
          t.cancel();
          setState(() {
            showStartOverlay = false;
          });
          startTimer();
        }
      });
    });
  }

  void startTimer() {
    timer?.cancel();
    timeLeft = 20;
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        timeLeft--;
        if (timeLeft <= 0) {
          lives--;
          if (lives <= 0) {
            timer?.cancel();
            _showGameOverDialog();
          } else {
            timeLeft = 20;
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
              startStartCountdown();
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
    startStartCountdown();
  }

  @override
  void dispose() {
    timer?.cancel();
    startCountdownTimer?.cancel();
    super.dispose();
  }

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
    });

    if (isCorrect) {
      stopTimer();
      // Popup penjelasan jawaban benar
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => Dialog(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          child: Container(
            width: 400,
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              color: const Color(0xFFF9ECD4),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Jawaban Benar!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  questions[currentQuestion]['explanation'] ??
                      'Penjelasan tidak tersedia',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      setState(() {
                        showResultOverlay = false;
                        selectedAnswer = null;
                        score += 20;
                        if (currentQuestion < questions.length - 1) {
                          currentQuestion++;
                          startTimer();
                        } else {
                          // ==== Jika soal terakhir, munculkan dialog rangkuman ====
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) => Dialog(
                              backgroundColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(22),
                              ),
                              child: Container(
                                width: 400,
                                padding: const EdgeInsets.all(28),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(22),
                                  color: const Color(0xFFEDE6D6),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.12),
                                      blurRadius: 16,
                                      offset: const Offset(0, 6),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      'Kesimpulan Quiz',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.brown,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      'Selamat! Kamu telah menyelesaikan seluruh ${questions.length} soal.\n'
                                      'Skormu: $score\n'
                                      'Rangkuman: Topik utama meliputi sejarah, geografi, sosial, dan penjelasan penting tiap soal. Terus belajar dan tingkatkan pemahamanmu!',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black87,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 30),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(
                                          context,
                                        ).popUntil((route) => route.isFirst);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.brown[300],
                                        foregroundColor: Colors.white,
                                        shape: const StadiumBorder(),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 14,
                                          horizontal: 32,
                                        ),
                                      ),
                                      child: const Text(
                                        'Home',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown[300],
                      foregroundColor: Colors.white,
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 28,
                      ),
                    ),
                    child: const Text(
                      'Next',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      setState(() {
        lives = lives - 1;
        if (lives < 0) lives = 0;
        showResultOverlay = false;
        selectedAnswer = null;
      });

      // Tampilkan dialog untuk jawaban salah
      if (lives > 0) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => Dialog(
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22),
            ),
            child: Container(
              width: 400,
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: const Color(0xFFF9ECD4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Jawaban Salah!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Jawaban yang benar: ${questions[currentQuestion]['correct']}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    questions[currentQuestion]['explanation'] ??
                        'Penjelasan tidak tersedia',
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  const SizedBox(height: 24),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        startTimer();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[300],
                        foregroundColor: Colors.white,
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 28,
                        ),
                      ),
                      child: const Text(
                        'Lanjut',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      } else {
        _showGameOverDialog();
      }
    }
  }

  Widget _buildLivesRow() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (i) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Icon(
            i < lives ? Icons.favorite : Icons.favorite_border,
            color: i < lives ? Colors.redAccent : Colors.white70,
            size: 28,
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final questionMap = questions[currentQuestion];
    final answers = List<String>.from(questionMap['answers']);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/img/social.easy.jpg',
            ), // ✅ Perbaiki nama file
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
                      onPressed:
                          selectedAnswer == null ||
                              showResultOverlay ||
                              showStartOverlay
                          ? null
                          : onCheckPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedAnswer == null
                            ? const Color.fromARGB(255, 237, 248, 203)
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
                    icon: const Icon(Icons.flag, color: Colors.white, size: 30),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),

              // === overlay start countdown ===
              if (showStartOverlay) _buildStartOverlay(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionCard(
    Map<String, dynamic> q,
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
              color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.92),
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
              softWrap: true,
            ),
          ),
          const SizedBox(height: 12),
          ...answers.map((ans) {
            final isSelected = selectedAnswer == ans;
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isSelected
                      ? Colors.lightBlueAccent
                      : Colors.white,
                  foregroundColor: isSelected ? Colors.white : Colors.black,
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 16,
                  ),
                  minimumSize: const Size(
                    double.infinity,
                    50,
                  ), // ✅ Tambahkan minimumSize
                ),
                onPressed: showResultOverlay || showStartOverlay
                    ? null
                    : () => setState(() => selectedAnswer = ans),
                child: Text(
                  ans,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  softWrap: true,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildStartOverlay() {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.45),
        child: Center(
          child: AnimatedOpacity(
            opacity: showStartOverlay ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: AnimatedScale(
              scale: showStartOverlay ? 1.0 : 0.8,
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeOutBack,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.symmetric(
                  vertical: 18,
                  horizontal: 22,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Quiz akan dimulai dalam',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$startCountdown',
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Siapkan dirimu!',
                      style: TextStyle(fontSize: 14, fontFamily: 'Poppins'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
