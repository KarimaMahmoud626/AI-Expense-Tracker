import 'package:ai_expense_tracker/core/utils/size_config.dart';
import 'package:ai_expense_tracker/core/widgets/custom_title_subtitle.dart';
import 'package:ai_expense_tracker/features/auth/data/models/user_model.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: CircleAvatar(
                    radius: SizeConfig.defaultSize! * 3,
                    backgroundImage:
                        user.imageUrl != null
                            ? NetworkImage(user.imageUrl!)
                            : AssetImage("assets/images/default_avatar.jpeg"),
                  ),
                ),
                CustomTitleSubtitle(
                  title: user.name,
                  subTitle: 'Track your money with ease',
                  titleColor: colors.onSurface,
                  subTitleColor: colors.onSurfaceVariant,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: colors.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.notifications_active),
            ),
          ),
        ],
      ),
    );
  }
}
