import 'package:flight_ui/ui/flight_rutes.dart';
import 'package:flutter/material.dart';

const _airplaneSize = 30.0;
const _dotSize = 18.0;

class FlightTimeLine extends StatefulWidget {
  @override
  _FlightTimeLineState createState() => _FlightTimeLineState();
}

bool animated = false;
bool animatedCard = false;
bool animateButton = false;

class _FlightTimeLineState extends State<FlightTimeLine> {
  void initAnimation() async {
    setState(() {
      animated = !animated;
    });
    await Future.delayed(const Duration(milliseconds: 1400));
    setState(() {
      animatedCard = !animatedCard;
    });
    await Future.delayed(const Duration(milliseconds: 600));
    setState(() {
      animateButton = !animateButton;
    });
  }

  void _onRutePressed() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, animation1, __) {
          return FadeTransition(
            opacity: animation1,
            child: FlightRutes(),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initAnimation();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return LayoutBuilder(builder: (context, constrain) {
      final centerDot = constrain.maxWidth / 2 - _dotSize / 2;
      return Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 600),
            left: constrain.maxWidth / 2 - _airplaneSize / 2,
            top: animated ? 10 : constrain.maxHeight - _airplaneSize / 2,
            bottom: 15.0,
            child: AircraftAndLine(),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 800),
            left: centerDot,
            top: animated ? 80 : constrain.maxHeight,
            child: TimelineDots(
              selected: true,
              displayCard: animatedCard,
              delay: Duration(milliseconds: 800),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1000),
            right: centerDot,
            top: animated ? 160 : constrain.maxHeight,
            child: TimelineDots(
              selected: false,
              displayCard: animatedCard,
              left: true,
              delay: Duration(milliseconds: 1000),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1200),
            left: centerDot,
            top: animated ? 280 : constrain.maxHeight,
            child: TimelineDots(
              displayCard: animatedCard,
              selected: false,
              delay: Duration(milliseconds: 1200),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1400),
            right: centerDot,
            top: animated ? 360 : constrain.maxHeight,
            child: TimelineDots(
              selected: true,
              displayCard: animatedCard,
              left: true,
              delay: Duration(milliseconds: 1400),
            ),
          ),
          if (animateButton)
            Align(
              alignment: Alignment.bottomCenter,
              child: TweenAnimationBuilder(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 250),
                builder: (context, value, child) {
                  return Transform.scale(scale: value, child: child);
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: FloatingActionButton(
                      child: Icon(
                        Icons.check,
                      ),
                      backgroundColor: Colors.redAccent,
                      onPressed: _onRutePressed,
                    ),
                  ),
                ),
              ),
            )
        ],
      );
    });
  }
}

class AircraftAndLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _airplaneSize,
      child: Column(
        children: [
          Icon(
            Icons.airplanemode_active,
            color: Colors.redAccent,
            size: _airplaneSize,
          ),
          Expanded(
              child: Container(
            color: Colors.redAccent,
            width: 2,
          )),
        ],
      ),
    );
  }
}

class TimelineDots extends StatefulWidget {
  final bool selected;
  final bool displayCard;
  final bool left;
  final Duration delay;

  const TimelineDots(
      {Key key,
      this.selected = false,
      this.displayCard = false,
      this.left = false,
      this.delay})
      : super(key: key);

  @override
  _TimelineDotsState createState() => _TimelineDotsState();
}

class _TimelineDotsState extends State<TimelineDots> {
  bool animated = false;

  void _animatedWithDelay() async {
    if (widget.displayCard) {
      await Future.delayed(
          Duration(milliseconds: (widget.delay.inMilliseconds - 600)));
      setState(() {
        animated = true;
      });
    }
  }

  @override
  void didUpdateWidget(TimelineDots oldWidget) {
    _animatedWithDelay();
    super.didUpdateWidget(oldWidget);
  }

  Widget _buildCard() => TweenAnimationBuilder(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 150),
      child: Container(
        child: Text("BOG + POP"),
        padding: const EdgeInsets.all(15),
        color: Colors.grey[100],
      ),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          alignment: widget.left ? Alignment.centerRight : Alignment.centerLeft,
          child: child,
        );
      });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (animated && widget.left) ...[
          _buildCard(),
          Container(
            width: 8,
            height: 2,
            color: Colors.grey[100],
          ),
        ],
        Container(
          height: _dotSize,
          width: _dotSize,
//      decoration: BoxDecoration(
//          border: Border.all(color: Colors.grey), shape: BoxShape.circle),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: CircleAvatar(
              backgroundColor:
                  widget.selected ? Colors.redAccent : Colors.lightGreen,
            ),
          ),
        ),
        if (animated && !widget.left) ...[
          Container(
            width: 8,
            height: 2,
            color: Colors.grey[100],
          ),
          _buildCard()
        ]
      ],
    );
  }
}
