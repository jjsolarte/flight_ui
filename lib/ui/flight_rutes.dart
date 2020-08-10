import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FlightRutes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          height: MediaQuery.of(context).size.height * 0.25,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFE04148),
                  Color(0xFFD85774),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          child: SafeArea(
              child: BackButton(
            color: Colors.white,
          )),
          top: 10,
          left: 10,
        ),
        Positioned(
            left: 10,
            right: 10,
            top: MediaQuery.of(context).size.height * 0.15,
            child: Column(
              children: [
                RowItem(
                  duration: const Duration(milliseconds: 400),
                ),
                RowItem(
                  duration: const Duration(milliseconds: 600),
                ),
                RowItem(
                  duration: const Duration(milliseconds: 800),
                ),
                RowItem(
                  duration: const Duration(milliseconds: 1000),
                )
              ],
            ))
      ],
    ));
  }
}

class RowItem extends StatelessWidget {
  final Duration duration;

  const RowItem({Key key, this.duration = const Duration(milliseconds: 800)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween(begin: 1.0, end: 0.0),
      duration: duration,
      curve: Curves.decelerate,
      builder: (_, value, child) {
        return Transform.translate(
          offset: Offset(0.0, MediaQuery.of(context).size.height * value),
          child: child,
        );
      },
      child: Card(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Sahara",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "SHA",
                      style: TextStyle(fontSize: 24, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.flight),
                    Text(
                      "658436",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Macao",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "MCA",
                      style: TextStyle(fontSize: 24, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
