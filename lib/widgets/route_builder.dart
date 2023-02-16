import 'package:animations/animations.dart';
import 'package:flutter/widgets.dart';

Route createRoute(final Widget widget) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        SharedAxisTransition(
      transitionType: SharedAxisTransitionType.vertical,
      fillColor: Color.fromRGBO(0, 0, 0, 0),
      animation: animation,
      secondaryAnimation: secondaryAnimation,
      child: widget,
    ),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 0.1);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
