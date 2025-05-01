import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

void main() {
  timeDilation = 2.0; // Optional: Slows down animation
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Hero Animation',
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final String imagePath = 'download.jpg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Custom Hero Home')),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                transitionDuration: const Duration(seconds: 2),
                pageBuilder: (_, __, ___) => DetailScreen(imagePath: imagePath),
              ),
            );
          },
          child: Hero(
            tag: 'hero-image',
            createRectTween: (begin, end) => CustomRectTween(begin: begin!, end: end!),
            child: RadialColorAnimatedContainer(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(60),
              child: ClipOval(
                child: Image.asset(
                  imagePath,
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
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
      appBar: AppBar(title: const Text('Custom Hero Detail')),
      body: Center(
        child: Hero(
          tag: 'hero-image',
          createRectTween: (begin, end) => CustomRectTween(begin: begin!, end: end!),
          child: RadialColorAnimatedContainer(
            color: Colors.red,
            borderRadius: BorderRadius.zero,
            child: ClipRRect(
              borderRadius: BorderRadius.zero,
              child: Image.asset(
                imagePath,
                width: 300,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomRectTween extends RectTween {
  CustomRectTween({required Rect begin, required Rect end}) : super(begin: begin, end: end);

  @override
  Rect lerp(double t) {
    final curve = Curves.elasticOut.transform(t);
    return Rect.lerp(begin, end, curve)!;
  }
}

class RadialColorAnimatedContainer extends StatelessWidget {
  final Widget child;
  final Color color;
  final BorderRadius borderRadius;

  const RadialColorAnimatedContainer({
    super.key,
    required this.child,
    required this.color,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 2),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius,
      ),
      child: child,
    );
  }
}
