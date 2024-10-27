import 'package:flutter/material.dart';
import '../../../../core/ui/app_colors.dart';
import '../../../../core/ui/app_text_styles.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool isActive;
  final VoidCallback onPressed;

  const RoundedButton({
    Key? key,
    required this.text,
    required this.icon,
    required this.isActive,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: isActive ? Colors.white : AppColors.textColor),
      label: Text(
        text,
        style: isActive ? AppTextStyles.filterTextActive : AppTextStyles.filterTextInactive,
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: isActive ? AppColors.activeFilter : AppColors.inactiveFilter,
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 0,
      ),
    );
  }
}
