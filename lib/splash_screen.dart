import 'package:assignemnt/home_screen/home_screen_view.dart';
import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    //Starting the home screen after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeView(),
          ),
          (route) => false);
    });

    return const Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Welcome",
              style: TextStyle(fontSize: 20, color: Colors.pinkAccent),
            ),
            SizedBox(
              height: 20,
            ),
            CircularProgressIndicator(
              color: Colors.pinkAccent,
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
