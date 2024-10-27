import 'package:flutter/material.dart';
import '../../../../core/ui/app_colors.dart';
import '../../../../core/ui/app_text_styles.dart';
import '../../domain/entities/company.dart';
import '../pages/assets_tree_page.dart';

class CompanyItemWidget extends StatelessWidget {
  final Company company;

  const CompanyItemWidget({Key? key, required this.company}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AssetsTreePage(companyId: company.id),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 2,
        ),
        child: Row(
          children: [
            const Icon(
              Icons.business,
              color: Colors.white,
              size: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                company.name,
                style: AppTextStyles.buttonText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
