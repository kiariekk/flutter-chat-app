import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/services/auth_service.dart';
import 'package:flutter_chat_app/presentation/themes/app_colors.dart';
import 'package:flutter_chat_app/presentation/widgets/appbar_dropdown_menu_item.dart';

class AppBarDropdownButton extends StatelessWidget {
  final List<AppBarDropdownMenuItem> additionalItems;

  AppBarDropdownButton({
    Key key,
    this.additionalItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = List<AppBarDropdownMenuItem>();
    items.add(
      AppBarDropdownMenuItem(
        onPressed: () => AuthService.signOut(),
        value: "Logout",
        icon: Icon(
          Icons.logout,
          color: Theme.of(context).primaryColor,
        ),
        title: Text(
          'Logout',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
    if (additionalItems != null) {
      items.addAll(additionalItems);
    }
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
          ...items.map(
            (item) => DropdownMenuItem(
              value: item.value,
              child: item,
              onTap: item.onPressed,
            ),
          )
        ],
      ),
    );
  }
}
