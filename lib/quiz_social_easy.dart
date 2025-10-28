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

  // === START COUNTDOWN (DITAMBAHKAN) ===
  int startCountdown = 5;
  Timer? startCountdownTimer;
  bool showStartOverlay = true;

  // fungsi untuk memulai hitung mundur start (5..1) lalu memulai quiz
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
          startTimer(); // mulai timer quiz setelah countdown selesai
        }
      });
    });
  }

  // ===== quiz timer functions =====
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
              startStartCountdown(); // restart countdown saat mulai ulang quiz
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
    startStartCountdown(); // panggil countdown sebelum quiz dimulai
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
          setState(() => showResultOverlay = false);
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
          startTimer(); // restart timer untuk soal yang sama
        }
      }
    });
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
            image: AssetImage('assets/img/social.easy.jpg'),
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
                      // DISABLE tombol Check saat overlay start masih aktif
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

              // overlay hasil
              if (showResultOverlay) _buildResultOverlay(),

              // === overlay start countdown (DITAMBAHKAN) ===
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
                  backgroundColor: isSelected
                      ? Colors.lightBlueAccent
                      : Colors.white,
                  foregroundColor: isSelected ? Colors.white : Colors.black,
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                // DISABLE pilihan jawaban saat start overlay aktif
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
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  // ===== START OVERLAY WIDGET (DITAMBAHKAN) =====
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
