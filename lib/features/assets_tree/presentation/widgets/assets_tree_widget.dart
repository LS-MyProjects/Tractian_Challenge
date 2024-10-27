import 'package:flutter/material.dart';
import '../../../../core/ui/app_colors.dart';
import '../../../../core/ui/app_text_styles.dart';
import '../../domain/entities/asset.dart';

class AssetsTreeWidget extends StatelessWidget {
  final List<Asset> assets;

  const AssetsTreeWidget({Key? key, required this.assets}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rootAssets = assets.where((asset) => asset.parentId == null).toList();

    return ListView.builder(
      itemCount: rootAssets.length,
      itemBuilder: (context, index) {
        final asset = rootAssets[index];
        return _buildAssetNode(asset);
      },
    );
  }

  Widget _buildAssetNode(Asset asset) {
    final childAssets = assets.where((child) => child.parentId == asset.id).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ExpansionTile(
        leading: _getIconForAsset(asset),
        title: Row(
          children: [
            Expanded(
              child: Text(
                asset.name,
                style: AppTextStyles.itemTitle,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),

            if (asset.status == 'alert')
              const Icon(
                Icons.circle,
                color: AppColors.errorColor,
                size: 10,
              ),

            if (asset.sensorType?.toLowerCase() == 'energy')
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Icon(
                  Icons.flash_on,
                  color: Colors.green,
                  size: 16,
                ),
              ),
          ],
        ),
        subtitle: asset.sensorType != null ? Text('Sensor: ${asset.sensorType}', style: AppTextStyles.itemSubtitle) : null,
        trailing: asset.status != null
            ? Text(
          'Status: ${asset.status}',
          style: asset.status == 'Critical' ? const TextStyle(color: AppColors.errorColor) : AppTextStyles.itemSubtitle,
        )
            : null,
        children: childAssets.isNotEmpty
            ? childAssets.map((child) => _buildAssetNode(child)).toList()
            : [
          const Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Text(
              'No sub-asset',
              style: AppTextStyles.itemSubtitle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getIconForAsset(Asset asset) {
    if (asset.parentId == null) {
      return const Icon(Icons.location_on, color: AppColors.primaryColor);
    } else if (asset.sensorType != null) {
      return const Icon(Icons.account_tree, color: AppColors.primaryColor);
    } else {
      return const Icon(Icons.build, color: AppColors.primaryColor);
    }
  }
}
