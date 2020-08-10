import 'package:flutter/material.dart';

class FlightForm extends StatelessWidget {

  final VoidCallback onTap;

  const FlightForm({Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.flight_takeoff,
                    color: Colors.redAccent,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child: TextField(
                    decoration: InputDecoration(labelText: "Form"),
                  ))
                ],
              ),
              SizedBox(
                width: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.flight_land,
                    color: Colors.redAccent,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child: TextField(
                    decoration: InputDecoration(labelText: "To"),
                  ))
                ],
              ),
              Spacer(),
              FloatingActionButton(
                onPressed: onTap,
                backgroundColor: Colors.redAccent,
                child: Icon(Icons.multiline_chart),
              )
            ],
          ),
        ),
      ),
    );
  }
}
