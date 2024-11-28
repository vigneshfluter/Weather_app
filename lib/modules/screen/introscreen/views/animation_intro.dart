import 'package:animated_introduction/animated_introduction.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated Introduction Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ExamplePage(),
    );
  }
}

final List<SingleIntroScreen> pages = [
  const SingleIntroScreen(
    title: 'Welcome to the Event Management App !',
    description:
        'You plans your Events, Well do the rest and will be the best! Guaranteed!',
    imageAsset: 'assets/image 16.png',
  ),
  const SingleIntroScreen(
    title: 'Book tickets to cricket matches and events',
    description:
        'Tickets to the latest movies, crickets matches, concerts, comedy shows, plus lots more !',
    imageAsset: 'assets/image 12.png',
  ),
  const SingleIntroScreen(
    title: 'Grabs all events now only in your hands',
    description: 'All events are now in your hands, just a click away ! ',
    imageAsset: 'assets/image 13.png',
  ),
];

class ExamplePage extends StatelessWidget {
  const ExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedIntroduction(
      slides: pages,
      indicatorType: IndicatorType.circle,
      onDone: () {
        /// TODO: Go to desire page -like login or home
      },
    );
  }
}
