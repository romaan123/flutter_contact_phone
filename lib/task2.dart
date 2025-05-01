import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

void main() {
  timeDilation = 2.0; // Optional: Slow animation
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Radial Hero Animation',
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<String> imagePaths = const [
    'image1.jpg',
    'image2.jpg',
    'image3.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Radial Hero Home')),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imagePaths.map((path) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 700),
                    pageBuilder: (_, __, ___) => DetailScreen(imagePath: path),
                  ),
                );
              },
              child: Hero(
                tag: path,
                child: RadialExpansion(
                  maxRadius: 60.0,
                  child: Image.asset(
                    path,
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final String imagePath;

  const DetailScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Radial Hero Detail')),
      body: Center(
        child: Hero(
          tag: imagePath,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(0), // Square shape
            child: Image.asset(
              imagePath,
              width: 300,
              height: 300,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

class RadialExpansion extends StatelessWidget {
  final double maxRadius;
  final Widget child;

  const RadialExpansion({super.key, required this.maxRadius, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SizedBox(
        width: maxRadius,
        height: maxRadius,
        child: Center(child: child),
      ),
    );
  }
}
