part of '../../feature.dart';

class TabletHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onProfileTap;

  const TabletHeader({
    super.key,
    required this.title,
    this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTheme.of(context).headLineLarge32),
        Row(
          children: [
            GestureDetector(
              onTap: onProfileTap,
              child: const ProfileMenu(),
            ),
            horizontalSpace(24),
            SvgPicture.asset(
              AppIcons.notificationIcon,
              width: 20,
              height: 20,
            ),
          ],
        ),
      ],
    );
  }
}
