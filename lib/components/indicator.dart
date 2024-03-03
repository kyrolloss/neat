import 'package:flutter/cupertino.dart';

class CirclaTabIndicator extends Decoration{
  final Color color ;
   double radius;
  CirclaTabIndicator ({required  this.color , required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    // TODO: implement createBoxPainter
    return CirclePainter(color: color, radius: radius);
  }

  }



  class CirclePainter extends BoxPainter{
    final Color color ;
    double radius;
    CirclePainter({required  this.color , required this.radius});






  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {

    Paint _paint=Paint();
    _paint.color=color;
    _paint.isAntiAlias = true;
    final Offset circleOffset = Offset(configuration.size!.width/2-radius/2,configuration.size!.height-radius );

      canvas.drawCircle(offset+circleOffset , radius, _paint);
  }
  
  }
