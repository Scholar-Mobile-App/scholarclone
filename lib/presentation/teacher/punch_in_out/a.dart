import 'dart:developer';

import 'package:flutter/material.dart';

class RippleButtonDemo extends StatefulWidget {
  const RippleButtonDemo({super.key, required this.title, this.onTap});

  final String title;
  final VoidCallback? onTap;

  @override
  _RippleButtonDemoState createState() => _RippleButtonDemoState();
}

class _RippleButtonDemoState extends State<RippleButtonDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.0, end: 20.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildRippleButton() {
    final bool isEnabled = widget.onTap != null;
    final Color textColor = isEnabled ? Colors.green : Colors.grey;
    log("isEnabled $isEnabled ");
    log("widget.onTap ${widget.onTap}");
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return GestureDetector(
          onTap: isEnabled ? widget.onTap : null,
          child: Container(
            width: 150 + (isEnabled ? _animation.value : 0),
            height: 150 + (isEnabled ? _animation.value : 0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Colors.white,
                  Colors.grey.shade300,
                ],
                center: Alignment.center,
                radius: 0.9,
              ),
              boxShadow: [
                if (isEnabled)
                  BoxShadow(
                    color: Colors.green.withValues(alpha: 0.3),
                    blurRadius: 30,
                    spreadRadius: _animation.value,
                  )
                else
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.1),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
              ],
            ),
            child: Center(child: child),
          ),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isEnabled) ...[
            Icon(Icons.touch_app, size: 30, color: textColor),
            SizedBox(height: 8),
          ],
          Text(
            widget.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: _buildRippleButton()),
    );
  }
}
