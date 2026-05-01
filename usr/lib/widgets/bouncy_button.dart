import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme.dart';

class BouncyButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color shadowColor;
  final bool isSecondary;
  final bool isOutlined;
  final IconData? icon;

  const BouncyButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = AppColors.primary,
    this.shadowColor = AppColors.primaryShadow,
    this.isSecondary = false,
    this.isOutlined = false,
    this.icon,
  });

  @override
  State<BouncyButton> createState() => _BouncyButtonState();
}

class _BouncyButtonState extends State<BouncyButton> {
  bool _isPressed = false;

  void _onPointerDown(PointerDownEvent event) {
    setState(() {
      _isPressed = true;
    });
    HapticFeedback.lightImpact();
  }

  void _onPointerUp(PointerUpEvent event) {
    setState(() {
      _isPressed = false;
    });
    widget.onPressed();
  }

  void _onPointerCancel(PointerCancelEvent event) {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final defaultColor = widget.isSecondary ? AppColors.secondary : widget.color;
    final defaultShadowColor = widget.isSecondary ? AppColors.secondaryShadow : widget.shadowColor;
    
    final bgColor = widget.isOutlined ? AppColors.background : defaultColor;
    final fgColor = widget.isOutlined ? defaultColor : Colors.white;
    final borderColor = widget.isOutlined ? AppColors.border : defaultShadowColor;
    
    final shadowHeight = widget.isOutlined ? 2.0 : 4.0;

    return Listener(
      onPointerDown: _onPointerDown,
      onPointerUp: _onPointerUp,
      onPointerCancel: _onPointerCancel,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 50),
        margin: EdgeInsets.only(top: _isPressed ? shadowHeight : 0),
        padding: EdgeInsets.only(bottom: _isPressed ? 0 : shadowHeight),
        decoration: BoxDecoration(
          color: widget.isOutlined ? AppColors.border : defaultShadowColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(16),
            border: widget.isOutlined ? Border.all(color: AppColors.border, width: 2) : null,
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null) ...[
                Icon(widget.icon, color: fgColor, size: 24),
                const SizedBox(width: 8),
              ],
              Text(
                widget.text.toUpperCase(),
                style: TextStyle(
                  color: fgColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
