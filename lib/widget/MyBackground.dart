import 'package:flutter/material.dart';
import 'dart:math';

class MyBackground extends StatefulWidget {
  final double heightPercentange;

  const MyBackground({Key key, this.heightPercentange}) : super(key: key);
  @override
  _MyBackgroundState createState() => _MyBackgroundState();
}

class _MyBackgroundState extends State<MyBackground> with SingleTickerProviderStateMixin{

  AnimationController _controller;
  Animation<double> _wavePhaseValue;

  final double wavePhase = 10.0;
  final double waveAmplitude = 15;
  final double waveFrequency = 1.6;
//  final double heightPercentange = 0.4;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(vsync: this,duration: Duration(seconds: 2));
    _wavePhaseValue = Tween(begin: wavePhase,end: 360+wavePhase).animate(_controller)..addListener((){
      setState(() {});
    });

    _wavePhaseValue.addStatusListener((s){
      if(s==AnimationStatus.completed){
        _controller.reset();
        _controller.forward();
      }
    });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        size: Size(double.infinity, double.infinity),
        painter: BgPainter(waveAmplitude, _wavePhaseValue.value, waveFrequency, widget.heightPercentange),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }
}

class BgPainter extends CustomPainter{

  double waveAmplitude;//振幅
  double wavePhase;//角度偏移
  double waveFrequency;//频率
  double heightPercentange;

  BgPainter(this.waveAmplitude,this.wavePhase,this.waveFrequency,this.heightPercentange); //x轴位置百分比

  Path path1 = Path();
  Path path2 = Path();
  Path path3 = Path();

  double _tempa = 0.0;
  double _tempb = 0.0;

  double viewWidth = 0.0;

  Paint mPaint = Paint();


  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint

    viewWidth = size.width;
    var viewCenterY = size.height * heightPercentange;

    _fillPath(viewCenterY, size);
    mPaint.color = Color(0xc080D8FF);
    canvas.drawPath(path1, mPaint);

    mPaint.color = Color(0xB080D8FF);
    canvas.drawPath(path2, mPaint);
    mPaint.color = Color(0x8080D8FF);
    canvas.drawPath(path3, mPaint);

  }

  void _fillPath(double viewCenterY, Size size) {
    path1.reset();
    path2.reset();
    path3.reset();
    path1.moveTo(
        0.0,
        viewCenterY -
            waveAmplitude * _getSinY(wavePhase, waveFrequency, -1));
    path2.moveTo(
        0.0,
        viewCenterY -
            1.3 *
                waveAmplitude *
                _getSinY(wavePhase + 90, waveFrequency, -1));
    path3.moveTo(
        0.0,
        viewCenterY +
            waveAmplitude * _getSinY(wavePhase, waveFrequency, -1));

    for (int i = 0; i < size.width - 1; i++) {
      path1.lineTo(
          (i + 1).toDouble(),
          viewCenterY -
              waveAmplitude *
                  _getSinY(wavePhase, waveFrequency, (i + 1)));
      path2.lineTo(
          (i + 1).toDouble(),
          viewCenterY -
              1.3 *
                  waveAmplitude *
                  _getSinY(
                      wavePhase + 90, 0.8 * waveFrequency, (i + 1)));
      path3.lineTo(
          (i + 1).toDouble(),
          viewCenterY +
              waveAmplitude *
                  _getSinY(wavePhase, waveFrequency, -1));
    }
    path1.lineTo(size.width, size.height);
    path2.lineTo(size.width, size.height);
    path3.lineTo(size.width, size.height);

    path1.lineTo(0.0, size.height);
    path2.lineTo(0.0, size.height);
    path3.lineTo(0.0, size.height);

    path1.close();
    path2.close();
    path3.close();
  }

  double _getSinY(
      double startradius, double waveFrequency, int currentposition) {
    //避免重复计算，提取公用值
    if (_tempa == 0) _tempa = pi / viewWidth;
    if (_tempb == 0) {
      _tempb = 2 * pi / 360.0;
    }
    return (sin(
        _tempa * waveFrequency * (currentposition + 1) + startradius * _tempb));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }

}