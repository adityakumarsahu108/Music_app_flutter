import 'package:flutter/material.dart';
import 'package:gym_music_app/pages/home_page.dart';
import 'package:lottie/lottie.dart';

class LoadPage extends StatelessWidget {
  const LoadPage({Key? key});

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
              Color.fromARGB(255, 101, 99, 101),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 35),
                child: Text(
                  'WELCOME',
                  style: TextStyle(
                    fontSize: 40,
                    letterSpacing: 7,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 86, 80, 80),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      ),
                      child: Lottie.asset(
                        'assets/animations/bounce.json',
                        height: 200,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Tap to Start',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
