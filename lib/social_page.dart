import 'package:flutter/material.dart';

// Widget tombol dengan efek hover pop up + box shadow kuat
class HoverableButton extends StatefulWidget {
  final String label;
  final Color color;
  final Color hoverColor;
  final VoidCallback onTap;

  const HoverableButton({
    required this.label,
    required this.color,
    required this.hoverColor,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  _HoverableButtonState createState() => _HoverableButtonState();
}

class _HoverableButtonState extends State<HoverableButton> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovering = true),
      onExit: (_) => setState(() => isHovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
          width: 350,
          height: 55,
          decoration: BoxDecoration(
            color: isHovering ? widget.hoverColor : widget.color,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFF4D7584), width: 2),
            boxShadow: isHovering
                ? [
                    BoxShadow(
                      color: const Color.fromARGB(
                        255,
                        0,
                        0,
                        0,
                      ).withOpacity(0.4),
                      blurRadius: 20,
                      spreadRadius: 5,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: const Color.fromARGB(
                        255,
                        0,
                        0,
                        0,
                      ).withOpacity(0.1),
                      blurRadius: 4,
                      spreadRadius: 1,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          transform: isHovering
              ? (Matrix4.identity()
                  ..translate(0, -5, 0)) // naikkan sedikit saat hover
              : Matrix4.identity(),
          child: Center(
            child: Text(
              widget.label,
              style: const TextStyle(
                fontSize: 24,
                color: Color.fromARGB(255, 246, 238, 180),
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                shadows: [
                  Shadow(
                    blurRadius: 3,
                    color: Color.fromARGB(255, 0, 0, 0),
                    offset: Offset(0, 1),
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

class SocialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/img/Historia.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 3),

              HoverableButton(
                label: 'Easy',
                color: const Color.fromARGB(255, 153, 214, 20).withOpacity(0.9),
                hoverColor: const Color.fromARGB(255, 140, 255, 9),
                onTap: () {
                  Navigator.pushNamed(context, '/quiz_social_easy');
                },
              ),

              HoverableButton(
                label: 'Hard',
                color: const Color.fromARGB(255, 223, 14, 14).withOpacity(0.9),
                hoverColor: const Color.fromARGB(
                  255,
                  255,
                  0,
                  0,
                ).withOpacity(0.9),
                onTap: () {
                  Navigator.pushNamed(context, '/quiz_social_hard');
                },
              ),

              const Spacer(flex: 2),

              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 50,
                    color: Colors.white,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),

              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}
