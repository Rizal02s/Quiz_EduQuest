import 'package:flutter/material.dart';

class SocialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 🟢 Hapus backgroundColor, karena kita akan pakai background image
      body: SafeArea(
        // 🟣 Tambahkan Container dengan background image
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/img/background.jpg'), // ganti dengan path gambar kamu
              fit: BoxFit.cover, // supaya gambar memenuhi layar
            ),
          ),

          // 🟢 Column dibungkus di dalam background image
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 🟡 Judul
              const Text(
                'Social',
                style: TextStyle(
                  fontSize: 55,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Poppins', // ubah semua ke Poppins
                ),
              ),

              const SizedBox(height: 36),

              // 🟢 Tombol Easy
              GestureDetector(
                onTap: () {
                   Navigator.pushNamed(context, '/quiz_social_easy');// tambahkan aksi jika ingin ke halaman lain
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 48, vertical: 8),
                  width: 350,
                  height: 55,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 183, 238, 67).withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Easy',
                      style: TextStyle(
                        fontSize: 24,
                        color: Color.fromARGB(255, 250, 255, 210),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
              ),

              // 🟢 Tombol Hard
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/quiz_social_hard');// aksi jika ingin ke halaman lain
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 48, vertical: 8),
                  width: 350,
                  height: 55,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 110, 110).withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Hard',
                      style: TextStyle(
                        fontSize: 24,
                        color: Color.fromARGB(255, 250, 255, 210),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 36),

              // 🔙 Tombol Back
              IconButton(
                icon: const Icon(Icons.arrow_back, size: 40, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
