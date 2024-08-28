import 'package:fintech_dashboard_clone/Controller/LoginController.dart';
import 'package:fintech_dashboard_clone/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Controller/NavigationHandler.dart';

class TopAppBar extends StatelessWidget {
  const TopAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row(
        children: [
          Visibility(
            visible: Responsive.isDesktop(context),
            child: const Padding(
              padding: EdgeInsets.only(right: 30.0),
              child: Text(
                "Overview",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.white,
              ),
              child: const TextField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintText: "Search something...",
                  icon: Icon(CupertinoIcons.search),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: Consumer<LoginController>(
                builder: (context, loginController, child) {
              return _nameAndProfilePicture(
                context,
                loginController.loggedInUser!.name ?? 'Admin',
                loginController.loggedInUser!.image ??
                    "https://image.freepik.com/free-photo/dreamy-girl-biting-sunglasses-looking-away-with-dreamy-face-purple-background_197531-7085.jpg",
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _nameAndProfilePicture(
      BuildContext context, String username, String imageUrl) {
    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
            onTap: () {
              Provider.of<NavigationHandler>(context, listen: false)
                  .updateIndex(index: 3);
            },
            child: const Text('Profile')),
        PopupMenuItem(
            onTap: () {
              Provider.of<LoginController>(context, listen: false).logout();
            },
            child: const Text('LogOut')),
      ],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            username,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Visibility(
            visible: !Responsive.isMobile(context),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(imageUrl),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
