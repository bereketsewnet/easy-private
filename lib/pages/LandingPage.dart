import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Easy/pages/HomePage.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Welcome To Whatsapp',
                style: TextStyle(
                  color: Colors.teal,
                  fontSize: 29,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 10,
              ),
              Image.asset(
                'assets/bg.png',
                height: 350,
                width: 350,
                color: Colors.greenAccent[700],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                    ),
                    children: [
                      TextSpan(
                        text: 'Agree and Continue to accept the',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      TextSpan(
                        text: 'WhatsApp Terms of Service and Privacy Policy',
                        style: TextStyle(
                          color: Colors.cyan,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (builder) => const HomePage(),
                    ),
                  );
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 110,
                  height: 50,
                  child: Card(
                    elevation: 8,
                    margin: const EdgeInsets.all(0),
                    color: Colors.greenAccent[700],
                    child: const Center(
                      child: Text(
                        'AGREE AND CONTINUE',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
