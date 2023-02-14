import 'package:flutter/material.dart';

class NormalButton extends StatelessWidget {

  final Widget child;
  final GestureTapCallback onTap;
  final Border border;
  final BorderRadius borderRadius;
  final double width;
  final double height;
  final Color color;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;

  const NormalButton({
    this.child,
    this.onTap,
    this.border,
    this.borderRadius,
    this.width,
    this.height,
    this.color,
    this.margin,
    this.padding
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      child: InkWell(
        child: Center(child: child,),
        onTap: onTap,
      ),
      height: height,
      width: width,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius,
        border: border
      ),
    );

  }

}