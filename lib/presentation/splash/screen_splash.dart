import 'package:flutter/material.dart';
import 'package:news_app_rv/core/constants/const.dart';
import 'package:news_app_rv/presentation/home/screen_home.dart';

class ScreenSplash extends StatelessWidget {
  const ScreenSplash({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 4),
      () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) {
            return ScreenMain();
          },
        ));
      },
    );

    return Scaffold(
    
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo.png',
              ),
              const Text('News App',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold)),
              const Text(' by Rahul Vijay',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w400)),
              space20,
              const Center(
                child: LinearProgressIndicator(
                  color: Colors.purple,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
