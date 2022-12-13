import 'package:flutter/material.dart';
import 'package:noteapp/screens/notes_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                alignment: Alignment.bottomLeft,
                padding: const EdgeInsets.only(top: 100, left: 20),
                child: const Text(
                  "Write Your Own Notes",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                alignment: Alignment.bottomLeft,
                padding: const EdgeInsets.only(top: 20, left: 20, right: 100),
                child: const Text(
                  "Capture what's on your mind & get a reminder later at a right place or time. You can also add voice memo & other features",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              Expanded(
                child: Stack(
                  //use stack for easy overlaping of widgets
                  alignment: Alignment.bottomRight,
                  children: [
                    // Container(
                    //   height: MediaQuery.of(context).size.height,
                    //   child: Image.asset(
                    //     'assets/images/image1.png',
                    //   ),
                    // ),
                    Positioned(
                      right: 120,
                      bottom: 260,
                      child: Container(
                        width: 150.0,
                        height: 50.0,
                        child: ElevatedButton(
                            onPressed: () async {
                              await Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) => const NotesScreen()));
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.teal.shade700),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  "Let's Start",
                                  style: TextStyle(fontSize: 16),
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                ),
                              ],
                            )),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
        );
  }
}