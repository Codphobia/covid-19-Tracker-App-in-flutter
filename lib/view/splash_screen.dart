import 'dart:async';

import 'package:covid_19_app/view/world_state_screen.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SlpashScreen extends StatefulWidget {
  const SlpashScreen({Key? key}) : super(key: key);

  @override
  State<SlpashScreen> createState() => _SlpashScreenState();
}

class _SlpashScreenState extends State<SlpashScreen>
    with TickerProviderStateMixin {
  // ignore: prefer_typing_uninitialized_variables
  var controller;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat();
    Timer(
        const Duration(seconds: 6),
        () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const WorldStateScreen(),
            )));
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: controller,
              child: const Center(
                child: SizedBox(
                  width: 200,
                  height: 200,
                  child: Image(
                    image: AssetImage('imagess/virus.gif'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              builder: (BuildContext context, Widget? child) {
                return Transform.rotate(
                  angle: controller.value * 2.0 * math.pi,
                  child: child,
                );
              },
            ),
            const SizedBox(
              height: 50,
            ),
            const Align(
              child: Text(
                'Covid-19 App',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w200,
                ),
              ),
            )
          ],
        ));
  }
}
