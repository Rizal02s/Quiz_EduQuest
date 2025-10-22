import 'package:flutter/material.dart';

class SocialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body pakai background image
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/img/Historia.jpg'), // ganti jika perlu
              fit: BoxFit.cover,
            ),
          ),

          // Column dibungkus di dalam background image
          child: Column(
            // perbaikan: hapus spasi sebelum 'center'
            mainAxisAlignment: MainAxisAlignment.center,

            // =======  Perubahan utama: tambahkan Spacer untuk menurunkan isi =======
            // letakkan Spacer di posisi paling atas agar semua konten terdorong ke bawah
            children: [
              const Spacer(flex: 3), // <- tambahkan/ubah flex untuk menyesuaikan seberapa jauh turun

              // Tombol Easy
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/quiz_social_easy'); // panggil route quiz easy
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

              // Tombol Hard
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/quiz_social_hard'); // panggil route quiz hard
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

              const SizedBox(height: 10),

              // Tombol Back
              IconButton(
                icon: const Icon(Icons.arrow_back, size: 50, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),

              // Spacer tambahan di bawah agar tidak terlalu menempel ke tepi bawah
              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}
