import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity, // lebar penuh
          height: double.infinity, // tinggi penuh
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/img/bgfix.jpg'),
              fit: BoxFit.cover, // gambar menutupi seluruh layar
            ),
          ),
          // Isi konten di atas background
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end, // tombol di bawah
            children: [
              //  Tombol Social
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/social'),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 48, vertical: 8),
                  width: 350,
                  height: 55,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 160, 211, 200).withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Social',
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

              // Teks "Or"
              const Text(
                'Or',
                style: TextStyle(fontSize: 28, color: Colors.white),
              ),

              const SizedBox(height: 10),

              // Tombol Science
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/science'),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 48, vertical: 8),
                  width: 350,
                  height: 55,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 211, 185, 84).withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Science',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 80), // jarak dari bawah
            ],
          ),
        ),
      ),
    );
  }
}
