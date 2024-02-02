import 'package:flutter/material.dart';
import 'package:gym_music_app/pages/home_page.dart';
import 'package:lottie/lottie.dart';

class LoadPage extends StatelessWidget {
  const LoadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 25, 28, 30),
              Color.fromARGB(255, 101, 99, 101)
            ], // Change these colors as needed
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 35),
                child: Text(
                  'WELCOME ',
                  style: TextStyle(
                    fontSize: 40,
                    letterSpacing: 7,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 86, 80, 80),
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Align items in the center
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        ),
                        child: Lottie.asset(
                          'assets/animations/bounce.json',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
