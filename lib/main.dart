import 'package:flutter/material.dart';

void main() {
  runApp(const CounterToggleApp());
}

class CounterToggleApp extends StatefulWidget {
  const CounterToggleApp({super.key});

  @override
  State<CounterToggleApp> createState() => _CounterToggleAppState();
}

class _CounterToggleAppState extends State<CounterToggleApp>
    with SingleTickerProviderStateMixin {
  int counter = 0;
  bool showFirstImage = true;

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  final String firstImageURL =
      "https://www.restart.run/_next/image?url=https%3A%2F%2Fcdn.sanity.io%2Fimages%2Fwii1y9hm%2Fproduction%2F79227347ff57edc321e08a2151e79b03a737c8a2-6301x4037.jpg%3Ffm%3Dwebp%26fit%3Dmax%26dl%3DMarvel%2520Rivals%2520Jeff%2520the%2520Land%2520Shark%2520Art.jpg&w=2120&q=75";
  final String secondImageURL =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQd8BUVgG5qXC01RLnD1nNCUZRWDu4g5yj0yw&s";

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
  }

  void _incrementCounter() {
    setState(() {
      counter++;
    });
  }

  void _toggleImage() {
    setState(() {
      showFirstImage = !showFirstImage;
    });
    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Counter & Image Toggle App"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Counter: $counter',
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _incrementCounter,
                child: const Text('Increment'),
              ),
              const SizedBox(height: 40),
              FadeTransition(
                opacity: _fadeAnimation,
                child: Image.network(
                  showFirstImage ? firstImageURL : secondImageURL,
                  height: 200,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Text('Failed to load image');
                  },
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _toggleImage,
                child: const Text('Toggle Image'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
