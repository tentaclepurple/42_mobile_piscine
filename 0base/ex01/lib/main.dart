import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

// Cambiamos de StatelessWidget a StatefulWidget porque ahora necesitamos
// mantener un estado que cambiará con el tiempo
// We change from StatelessWidget a StatefulWidget because now we need 
// to keep a state that changes over time
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // createState() is a method that Flutter calls to create the State object
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
// State class contains the logic and the state of our widget
class _MyHomePageState extends State<MyHomePage> {
  // boolean to choos what message to show
  bool isInitialText = true;

  // Function that will change the state when button is pressed
  void _toggleText() {
    setState(() {
      // setState tells Flutter state has changed and needs to 
      // rebuild widget
      isInitialText = !isInitialText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 228, 228, 228),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: const BoxDecoration(
                color: Color(0xFF808000),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Text(
                isInitialText ? 'A simple text' : 'Hello World',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 12),
            GestureDetector(
              // call _toggleText when button is pressed
              onTap: () {
                _toggleText();
                debugPrint('Button pressed');
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: const Text(
                  'Click me',
                  style: TextStyle(
                    color: Color(0xFF808000),
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}