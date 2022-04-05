// import 'package:flutter/material.dart';

// class UpDownAnime extends StatefulWidget {
//   final Widget child;
//   final double endX, endY;
//   final int seconds;
//   const UpDownAnime({Key key, this.child, this.endX, this.endY, this.seconds})
//       : super(key: key);
//   @override
//   State<UpDownAnime> createState() => _UpDownAnimeState();
// }

// class _UpDownAnimeState extends State<UpDownAnime>
//     with SingleTickerProviderStateMixin {
//   AnimationController _controller = AnimationController(
//     duration: Duration(seconds: widget.seconds),
//     vsync: this,
//   )..repeat(reverse: true);

//   final Animation<Offset> _offsetAnimation = Tween<Offset>(
//     begin: Offset.zero,
//     end: Offset(widget.endX, widget.endY),
//   ).animate(
//     CurvedAnimation(
//       reverseCurve: Curves.easeIn,
//       parent: _controller,
//       curve: Curves.easeOut,
//     ),
//   );

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SlideTransition(
//       position: _offsetAnimation,
//       child: widget.child,
//     );
//   }
// }
