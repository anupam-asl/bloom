import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bloom_health_app/features/bloom/presentation/pages/bloom_home_page.dart';

class BloomSplashScreen extends StatefulWidget {
  @override
  State<BloomSplashScreen> createState() => _BloomSplashScreenState();
}

class _BloomSplashScreenState extends State<BloomSplashScreen>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  late final List<Animation<double>> _angles;

  final List<String> _petalFiles = [
    'assets/images/petals/ellipse1.svg',
    'assets/images/petals/ellipse2.svg',
    'assets/images/petals/ellipse3.svg',
    'assets/images/petals/ellipse4.svg',
  ];

  // Final spread (right → left, ellipse4 rotates the most)
  final List<double> _finalAngles = [-0.1, -0.2, -0.4, -0.8];

  // Z-order: 4 under, 1 top
  final List<int> _zOrder = [3, 2, 1, 0];

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      4,
          (i) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 900),
      ),
    );

    _angles = List.generate(
      4,
          (i) => Tween<double>(begin: 0.0, end: _finalAngles[i]).animate(
        CurvedAnimation(parent: _controllers[i], curve: Curves.easeOutCubic),
      ),
    );

    // stagger animations
    for (int i = 0; i < 4; i++) {
      Future.delayed(Duration(milliseconds: 250 * i), () {
        if (mounted) _controllers[i].forward();
      });
    }

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => BloomHomePage()),
        );
      }
    });
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ellipse size
    const double petalWidth = 64.32;
    const double petalHeight = 125;

    // anchor offset: bottom center of each ellipse
    const Offset anchor = Offset(petalWidth / 2, petalHeight);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Flower
            SizedBox(
              width: 200,
              height: 200,
              child: Stack(
                clipBehavior: Clip.none,
                children: List.generate(4, (layer) {
                  final i = _zOrder[layer];
                  return AnimatedBuilder(
                    animation: _controllers[i],
                    builder: (context, child) {
                      return Align(
                        alignment: Alignment.center, // put anchor at stack center
                        child: Transform.rotate(
                          angle: _angles[i].value,
                          origin: anchor, // rotate around bottom center
                          child: SvgPicture.asset(
                            _petalFiles[i],
                            width: petalWidth,
                            height: petalHeight,
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              "Bloom Health",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
