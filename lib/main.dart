import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hero Animation with Radial Expansion',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HeroAnimation(),
    );
  }
}

class HeroAnimation extends StatelessWidget {
  const HeroAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.0; // Slows down animation for demonstration
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hero Animation'),
      ),
      body: Center(
        child: PhotoHero(
          photo: 'download.jpg',
          width: 600.0,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (context) {
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text('Zoomed Page'),
                    ),
                    body: Container(
                      color: Colors.lightBlueAccent,
                      padding: const EdgeInsets.all(16),
                      alignment: Alignment.topLeft,
                      child: PhotoHero(
                        photo: 'download.jpg',
                        width: 400.0,
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class PhotoHero extends StatelessWidget {
  const PhotoHero({
    super.key,
    required this.photo,
    this.onTap,
    required this.width,
  });

  final String photo;
  final VoidCallback? onTap;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Hero(
        tag: photo,
        flightShuttleBuilder: (flightContext, animation, flightDirection, fromHeroContext, toHeroContext) {
          return AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              double scale = flightDirection == HeroFlightDirection.push
                  ? animation.value
                  : 1.0 - animation.value;
              return Transform.scale(
                scale: scale,
                child: child,
              );
            },
            child: Image.asset(photo, fit: BoxFit.contain),
          );
        },
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: RadialExpansion(
              maxRadius: width / 2,
              child: Image.asset(
                photo,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RadialExpansion extends StatelessWidget {
  const RadialExpansion({
    super.key,
    required this.maxRadius,
    required this.child,
  }) : clipRectSize = 2.0 * (maxRadius / math.sqrt2);

  final double maxRadius;
  final double clipRectSize;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Center(
        child: SizedBox(
          width: clipRectSize,
          height: clipRectSize,
          child: ClipRect(
            child: child,
          ),
        ),
      ),
    );
  }
}
