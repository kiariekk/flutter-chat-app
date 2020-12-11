import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/services/auth_service.dart';
import 'package:flutter_chat_app/presentation/themes/app_colors.dart';

class AppbarDropdownButton extends StatelessWidget {
  const AppbarDropdownButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: DropdownButton(
        icon: Icon(
          Icons.more_vert,
          color: AppColors.lightColor,
        ),
        underline: SizedBox(),
        onChanged: (value) {},
        items: [
          DropdownMenuItem(
            value: "Logout",
            child: Row(
              children: [
                Icon(
                  Icons.logout,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(width: 10),
                Text(
                  'Logout',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
            onTap: () => AuthService.signOut(),
          ),
        ],
      ),
    );
  }
}
