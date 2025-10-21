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

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'Masa Mesozoikum terdiri dari tiga periode utama, yaitu …',
      'answers': ['Trias, Jura, Kapur', 'Kambrium, Ordovisium, Silur', 'Paleo, Neo, Keno', 'Devon, Karbon, Perm'],
      'correct': 'Trias, Jura, Kapur',
    },
    {
      'question': 'Hewan dominan pada zaman Mesozoikum adalah …',
      'answers': ['Mamalia', 'Dinosaurus', 'Amfibi', 'Burung'],
      'correct': 'Dinosaurus',
    },
    {
      'question': 'Benua raksasa yang terpecah pada zaman Mesozoikum bernama …',
      'answers': ['Atlantis', 'Laurasia', 'Pangea', 'Gondwana'],
      'correct': 'Pangea',
    },
    {
      'question': 'Penyebab utama kepunahan dinosaurus pada akhir periode Kapur adalah …',
      'answers': ['Letusan gunung berapi global', 'Hujan asam', 'Tabrakan asteroid besar', 'Perubahan magnet bumi'],
      'correct': 'Tabrakan asteroid besar',
    },
    {
      'question': 'Perang Dunia I dimulai pada tahun …',
      'answers': ['1910', '1914', '1918', '1921'],
      'correct': '1914',
    },
    {
      'question': 'Salah satu sebab utama Perang Dunia I adalah …',
      'answers': ['Perang Dingin', 'Pembunuhan Franz Ferdinand', 'Krisis Ekonomi', 'Runtuhnya Romawi'],
      'correct': 'Pembunuhan Franz Ferdinand',
    },
    {
      'question': 'Perang Dunia II berakhir pada tahun …',
      'answers': ['1942', '1944', '1945', '1947'],
      'correct': '1945',
    },
    {
      'question': 'Negara yang menjatuhkan bom atom di Hiroshima dan Nagasaki adalah …',
      'answers': ['Jerman', 'Amerika Serikat', 'Uni Soviet', 'Jepang'],
      'correct': 'Amerika Serikat',
    },
    {
      'question': 'Pemimpin Nazi Jerman selama Perang Dunia II adalah …',
      'answers': ['Adolf Hitler', 'Benito Mussolini', 'Joseph Stalin', 'Winston Churchill'],
      'correct': 'Adolf Hitler',
    },
    {
      'question': 'Tujuan utama pembentukan PBB pada tahun 1945 adalah …',
      'answers': ['Menyatukan Eropa', 'Menciptakan perdamaian dunia', 'Menentang kapitalisme', 'Mendirikan NATO'],
      'correct': 'Menciptakan perdamaian dunia',
    },
    {
      'question': 'Konflik ideologi antara Amerika Serikat dan Uni Soviet disebut …',
      'answers': ['Perang Dunia III', 'Perang Dingin', 'Perang Sipil', 'Revolusi Industri'],
      'correct': 'Perang Dingin',
    },
    {
      'question': 'Blok Barat membentuk organisasi militer bernama …',
      'answers': ['Warsawa Pact', 'NATO', 'ASEAN', 'SEATO'],
      'correct': 'NATO',
    },
    {
      'question': 'Blok Timur membentuk organisasi tandingan bernama …',
      'answers': ['Warsawa Pact', 'UNESCO', 'OPEC', 'G7'],
      'correct': 'Warsawa Pact',
    },
    {
      'question': 'Perlombaan senjata nuklir merupakan ciri khas dari …',
      'answers': ['Perang Dunia I', 'Perang Dunia II', 'Perang Dingin', 'Revolusi Industri'],
      'correct': 'Perang Dingin',
    },
    {
      'question': 'Krisis Misil Kuba terjadi pada tahun …',
      'answers': ['1959', '1962', '1965', '1970'],
      'correct': '1962',
    },
    {
      'question': 'Kebijakan Glasnost dan Perestroika diperkenalkan oleh …',
      'answers': ['Lenin', 'Nikita Khrushchev', 'Mikhail Gorbachev', 'Joseph Stalin'],
      'correct': 'Mikhail Gorbachev',
    },
    {
      'question': 'Perang Dingin berakhir setelah runtuhnya …',
      'answers': ['Tembok Berlin', 'PBB', 'NATO', 'Uni Eropa'],
      'correct': 'Tembok Berlin',
    },
    {
      'question': 'Dampak ekonomi global dari Perang Dunia II adalah …',
      'answers': [
        'Meningkatnya kemiskinan global',
        'Krisis minyak dunia',
        'Munculnya lembaga ekonomi internasional seperti IMF dan Bank Dunia',
        'Perdagangan berhenti total'
      ],
      'correct': 'Munculnya lembaga ekonomi internasional seperti IMF dan Bank Dunia',
    },
    {
      'question': 'Setelah Perang Dunia II, banyak negara Asia-Afrika mengalami …',
      'answers': ['Penjajahan ulang', 'Kemerdekaan', 'Krisis pangan', 'Perang saudara global'],
      'correct': 'Kemerdekaan',
    },
    {
      'question': 'Salah satu dampak politik Perang Dingin adalah …',
      'answers': [
        'Munculnya negara-negara netral dan Non-Blok',
        'Kekuasaan monarki semakin kuat',
        'Kolonialisme semakin luas',
        'Sistem demokrasi hilang'
      ],
      'correct': 'Munculnya negara-negara netral dan Non-Blok',
    },
  ];

  void checkAnswer() {
    if (selectedAnswer == null) {
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
              Navigator.of(context).pop();
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
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Text('🏁 Quiz Selesai!', style: TextStyle(fontFamily: 'Poppins')),
          content: Text('Skor akhir kamu: $score', style: const TextStyle(fontFamily: 'Poppins')),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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

              Text(
                'Soal ${currentQuestion + 1} / ${questions.length}',
                style: const TextStyle(color: Colors.white, fontFamily: 'Poppins'),
              ),
              const SizedBox(height: 18),

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
