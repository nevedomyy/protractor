import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;


void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      home: Protractor(),
    );
  }
}

class Protractor extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(top: 30.0),
        child: Stack(
          children: <Widget>[
            CustomPaint(
              size: Size.infinite,
              painter: Scale(),
            ),
          ],
        ),
      )
    );
  }
}

class Scale extends CustomPainter{

  _unit(Canvas canvas, String unit, double x, double y){
    TextSpan span = TextSpan(
        style: TextStyle(color: Colors.white, fontSize: 18.0, fontFamily: 'OpenSansCondensed-Light'),
        text: unit
    );
    TextPainter painter = TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.rtl
    );
    painter.layout();
    painter.paint(canvas, Offset(x, y));
  }

  @override
  void paint(Canvas canvas, Size size) {
    final List<Offset> points = List();
    final h = size.width/2 > size.height ? size.height : size.width/2;
    for(int i = 90; i <= 270; i++){
      points.add(Offset(size.width/2+h*math.sin(i*math.pi/180), size.height+h*math.cos(i*math.pi/180)));
    }
    final path = Path();
    path.addPolygon(points, true);
    canvas.drawPath(path, Paint()..color = Color.fromRGBO(49, 51, 53, 1));
    canvas.drawShadow(path, Color.fromRGBO(49, 51, 53, 1), 10, true);
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1;
    canvas.drawLine(Offset(size.width/2, size.height), Offset(size.width/2, size.height-19), paint);
    int iter = 0;
    while(iter <= 180){
      canvas.drawLine(Offset(size.width/2+(h-5)*math.sin((iter+90)*math.pi/180), size.height+(h-5)*math.cos((iter+90)*math.pi/180)),
          Offset(size.width/2+(h-25)*math.sin((iter+90)*math.pi/180), size.height+(h-25)*math.cos((iter+90)*math.pi/180)), paint);
      if(5*iter <= 180) canvas.drawLine(Offset(size.width/2+(h-5)*math.sin((5*iter+90)*math.pi/180), size.height+(h-5)*math.cos((5*iter+90)*math.pi/180)),
          Offset(size.width/2+(h-28)*math.sin((5*iter+90)*math.pi/180), size.height+(h-28)*math.cos((5*iter+90)*math.pi/180)), paint);
      if(2*5*iter <= 180) {
        canvas.drawLine(Offset(size.width/2+(h-5)*math.sin((2*5*iter+90)*math.pi/180), size.height+(h-5)*math.cos((2*5*iter+90)*math.pi/180)),
            Offset(size.width/2+(h-32)*math.sin((2*5*iter+90)*math.pi/180), size.height+(h-32)*math.cos((2*5*iter+90)*math.pi/180)), paint);
        _unit(canvas, (180-2*5*iter).toString(), size.width/2-12+(h-50)*math.sin((2*5*iter+90)*math.pi/180), size.height-20+(h-60)*math.cos((2*5*iter+90)*math.pi/180));
      }
      iter++;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
