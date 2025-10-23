// 🟣 Tambahan import
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isHovered = false; //  Untuk mendeteksi hover

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/img/munich.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              //  Tombol dengan efek hover
              MouseRegion(
                onEnter: (_) => setState(() => _isHovered = true),
                onExit: (_) => setState(() => _isHovered = false),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  margin: const EdgeInsets.symmetric(horizontal: 48, vertical: 8),
                  width: _isHovered ? 360 : 350, // animasi membesar sedikit
                  height: _isHovered ? 60 : 55,   // animasi tinggi juga
                  decoration: BoxDecoration(
                    color: _isHovered
                        ? const Color.fromARGB(255, 209, 207, 170)
                        : const Color(0xFF4D7584).withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color.fromARGB(255, 246, 252, 208),
                      width: _isHovered ? 3 : 2,
                    ),
                    boxShadow: _isHovered
                        ? [
                            BoxShadow(
                              color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.6),
                              blurRadius: 20,
                              spreadRadius: 2,
                            )
                          ]
                        : [],
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () => Navigator.pushNamed(context, '/social'),
                    child: const Center(
                      child: Text(
                        'Historia & Geologi',
                        style: TextStyle(
                          fontSize: 24,
                          color: Color.fromARGB(255, 24, 24, 27),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 280),
            ],
          ),
        ),
      ),
    );
  }
}
