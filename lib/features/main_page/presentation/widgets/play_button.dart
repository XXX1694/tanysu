import 'package:flutter/material.dart';
import 'dart:math' show pi;

class PlayButton extends StatefulWidget {
  final Icon playIcon;
  final Icon pauseIcon;
  final VoidCallback onPressed;

  const PlayButton({
    super.key,
    required this.onPressed,
    this.playIcon = const Icon(Icons.play_arrow),
    this.pauseIcon = const Icon(Icons.pause),
  });

  @override
  // ignore: library_private_types_in_public_api
  _PlayButtonState createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> with TickerProviderStateMixin {
  static const _kToggleDuration = Duration(milliseconds: 300);
  static const _kRotationDuration = Duration(seconds: 5);

  late bool isPlaying = true;

  // rotation and scale animations
  late AnimationController _rotationController;
  late AnimationController _scaleController;
  double _rotation = 0;
  double _scale = 0.85;

  bool get _showWaves => !_scaleController.isDismissed;

  void _updateRotation() => _rotation = _rotationController.value * 2 * pi;
  void _updateScale() => _scale = (_scaleController.value * 0.2) + 0.85;

  @override
  void initState() {
    _rotationController =
        AnimationController(vsync: this, duration: _kRotationDuration)
          ..addListener(() => setState(_updateRotation))
          ..repeat();

    _scaleController =
        AnimationController(vsync: this, duration: _kToggleDuration)
          ..addListener(() => setState(_updateScale));

    super.initState();
  }

  // void _onToggle() {
  //   if (_scaleController.isCompleted) {
  //     _scaleController.reverse();
  //   } else {
  //     _scaleController.forward();
  //   }

  //   widget.onPressed();
  // }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (_showWaves) ...[
            Blob(
                color: const Color(0XFFD83998).withOpacity(0.5),
                scale: _scale,
                rotation: _rotation),
            Blob(
                color: const Color(0XFF4A2160).withOpacity(0.7),
                scale: _scale,
                rotation: _rotation * 2 - 30),
            Blob(
                color: const Color(0XFFA51336).withOpacity(0.2),
                scale: _scale,
                rotation: _rotation * 3 - 45),
          ],
          Container(
            constraints: const BoxConstraints.expand(),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: AnimatedSwitcher(
              duration: _kToggleDuration,
              child: Container(
                height: 155,
                width: 155,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  image: const DecorationImage(
                    image: AssetImage(
                      'assets/images/tanysu.png',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _rotationController.dispose();
    super.dispose();
  }
}

class Blob extends StatelessWidget {
  final double rotation;
  final double scale;
  final Color color;

  const Blob({
    super.key,
    required this.color,
    this.rotation = 0,
    this.scale = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale,
      child: Transform.rotate(
        angle: rotation,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(150),
              topRight: Radius.circular(240),
              bottomLeft: Radius.circular(220),
              bottomRight: Radius.circular(180),
            ),
          ),
        ),
      ),
    );
  }
}
