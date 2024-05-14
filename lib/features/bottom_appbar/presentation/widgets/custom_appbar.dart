import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class CustomBottomAppBar extends StatefulWidget {
  const CustomBottomAppBar({
    Key? key,
    this.color,
    this.elevation,
    this.clipBehavior = Clip.none,
    this.notchMargin = 4.0,
    this.child,
    this.positionInHorizontal = 0.0,
  }) : super(key: key);

  final Widget? child;
  final Color? color;
  final double? elevation;
  final Clip clipBehavior;
  final double notchMargin;
  final double positionInHorizontal;

  @override
  State createState() => _CustomBottomAppBarState();
}

class _CustomBottomAppBarState extends State<CustomBottomAppBar> {
  late ValueListenable<ScaffoldGeometry> geometryListenable;
  static const double _defaultElevation = 8.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    geometryListenable = Scaffold.geometryOf(context);
  }

  @override
  Widget build(BuildContext context) {
    final BottomAppBarTheme babTheme = BottomAppBarTheme.of(context);
    final bool hasFab = Scaffold.of(context).hasFloatingActionButton;
    final CustomClipper<Path> clipper = _BottomAppBarClipper(
      geometry: geometryListenable,
      hasFab: hasFab,
      position2MoveHorizontal: widget.positionInHorizontal,
      context: context,
    );
    final double elevation =
        widget.elevation ?? babTheme.elevation ?? _defaultElevation;
    final Color color =
        widget.color ?? babTheme.color ?? Theme.of(context).bottomAppBarColor;
    final Color effectiveColor =
        ThemeData.estimateBrightnessForColor(color) == Brightness.light
            ? Color.alphaBlend(color.withOpacity(0.12), Colors.black)
            : Color.alphaBlend(color.withOpacity(0.12), Colors.white);
    return PhysicalShape(
      clipper: clipper,
      elevation: elevation,
      color: effectiveColor,
      clipBehavior: widget.clipBehavior,
      child: Material(
        type: MaterialType.transparency,
        child: widget.child == null ? null : SafeArea(child: widget.child!),
      ),
    );
  }
}

class _BottomAppBarClipper extends CustomClipper<Path> {
  const _BottomAppBarClipper({
    required this.geometry,
    required this.hasFab,
    required this.position2MoveHorizontal,
    required this.context,
  }) : super(reclip: geometry);

  final ValueListenable<ScaffoldGeometry> geometry;
  final bool hasFab;
  final double position2MoveHorizontal;
  final BuildContext context;

  double get bottomNavigationBarTop {
    final double? bottomNavigationBarTop =
        geometry.value.bottomNavigationBarTop;
    if (bottomNavigationBarTop != null) {
      return bottomNavigationBarTop;
    }
    final RenderBox? box = context.findRenderObject() as RenderBox?;
    return box?.localToGlobal(Offset.zero).dy ?? 0;
  }

  @override
  Path getClip(Size size) {
    final double radius = 16.0;
    final double top = size.height - radius;

    final Path path = Path()
      ..moveTo(0, top)
      ..lineTo(position2MoveHorizontal, top)
      ..arcToPoint(
        Offset(position2MoveHorizontal + radius, top + radius),
        radius: Radius.circular(radius),
      )
      ..lineTo(size.width - radius, size.height)
      ..arcToPoint(
        Offset(size.width, size.height - radius),
        radius: Radius.circular(radius),
        clockwise: false,
      )
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(_BottomAppBarClipper oldClipper) {
    return oldClipper.geometry != geometry || oldClipper.hasFab != hasFab;
  }
}
