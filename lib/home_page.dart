import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isHoveredHistoria = false; // Untuk mendeteksi hover pada Historia
  bool _isHoveredScience = false; // Untuk mendeteksi hover pada Science

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/img/homepage.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Tombol Historia & Geologi dengan efek hover
              MouseRegion(
                onEnter: (_) => setState(() => _isHoveredHistoria = true),
                onExit: (_) => setState(() => _isHoveredHistoria = false),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 48,
                    vertical: 8,
                  ),
                  width: _isHoveredHistoria ? 360 : 350,
                  height: _isHoveredHistoria ? 60 : 55,
                  decoration: BoxDecoration(
                    color: _isHoveredHistoria
                        ? const Color.fromARGB(255, 94, 68, 3)
                        : const Color.fromARGB(255, 132, 104, 77).withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color.fromARGB(255, 246, 252, 208),
                      width: _isHoveredHistoria ? 3 : 2,
                    ),
                    boxShadow: _isHoveredHistoria
                        ? [
                            BoxShadow(
                              color: const Color.fromARGB(
                                255,
                                0,
                                0,
                                0,
                              ).withOpacity(0.6),
                              blurRadius: 20,
                              spreadRadius: 2,
                            ),
                          ]
                        : [],
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () => Navigator.pushNamed(context, '/social'),
                    child: const Center(
                      child: Text(
                        'Historia',
                        style: TextStyle(
                          fontSize: 24,
                          color: Color.fromARGB(255, 255, 248, 215),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Jarak 1 cm antara tombol (sekitar 40 pixel)
              const SizedBox(height: 20),

              // Tombol Science dengan efek hover
              MouseRegion(
                onEnter: (_) => setState(() => _isHoveredScience = true),
                onExit: (_) => setState(() => _isHoveredScience = false),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 48,
                    vertical: 8,
                  ),
                  width: _isHoveredScience ? 360 : 350,
                  height: _isHoveredScience ? 60 : 55,
                  decoration: BoxDecoration(
                    color: _isHoveredScience
                        ? const Color.fromARGB(255, 98, 140, 44)
                        : const Color.fromARGB(
                            0,
                            132,
                            104,
                            77,
                          ).withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color.fromARGB(255, 252, 234, 208),
                      width: _isHoveredScience ? 3 : 2,
                    ),
                    boxShadow: _isHoveredScience
                        ? [
                            BoxShadow(
                              color: const Color.fromARGB(
                                255,
                                0,
                                0,
                                0,
                              ).withOpacity(0.6),
                              blurRadius: 20,
                              spreadRadius: 2,
                            ),
                          ]
                        : [],
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/science',
                      ); // Tambahkan navigasi untuk Science di sini
                      // Navigator.pushNamed(context, '/science');
                    },
                    child: const Center(
                      child: Text(
                        'Science Geologi',
                        style: TextStyle(
                          fontSize: 24,
                          color: Color.fromARGB(255, 255, 248, 215),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 190),
            ],
          ),
        ),
      ),
    );
  }
}
