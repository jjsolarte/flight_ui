import 'package:flight_ui/ui/flight_form.dart';
import 'package:flight_ui/ui/flight_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

enum FlightView { form, timeline }

class _MyHomePageState extends State<MyHomePage> {
  FlightView flightView = FlightView.form;

  void _onFlightPressed() {
    setState(() {
      flightView = FlightView.timeline;
    });
  }

  @override
  Widget build(BuildContext context) {
    final headerHeight = MediaQuery.of(context).size.height * 0.32;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            right: 0,
            left: 0,
            height: headerHeight,
            child: DecoratedBox(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    Color(0xFFE04148),
                    Color(0xFFD85774),
                  ])),
              child: SafeArea(
                child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Text(
                          "Air Colombia",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            HeaderButton(title: "One Way"),
                            HeaderButton(title: "One Way"),
                            HeaderButton(
                              title: "One Way",
                              selected: true,
                            ),
                          ],
                        )
                      ],
                    )),
              ),
            ),
          ),
          Positioned(
              left: 10,
              right: 10,
              top: headerHeight / 2,
              bottom: -3,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: TapButton(
                          title: "Flight",
                          selected: true,
                        )),
                        Expanded(
                            child: TapButton(
                          title: "Train",
                        )),
                        Expanded(
                            child: TapButton(
                          title: "Bus",
                        )),
                      ],
                    ),
                    Expanded(
                        child: flightView == FlightView.form
                            ? FlightForm(
                                onTap: _onFlightPressed,
                              )
                            : FlightTimeLine())
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

class TapButton extends StatelessWidget {
  final String title;
  final bool selected;

  const TapButton({
    Key key,
    this.title,
    this.selected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Column(
        children: [
          Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 15, color: selected ? Colors.black : Colors.grey),
              )),
          if (selected)
            Container(
              height: 2,
              color: Colors.redAccent,
            )
        ],
      ),
    );
  }
}

class HeaderButton extends StatelessWidget {
  final String title;
  final bool selected;

  const HeaderButton({
    Key key,
    this.title,
    this.selected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        border: Border.all(color: Colors.white),
        color: selected ? Colors.white : null,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 13.0),
        child: Text(
          title.toUpperCase(),
          style: TextStyle(color: selected ? Colors.redAccent : Colors.white),
        ),
      ),
    );
  }
}
