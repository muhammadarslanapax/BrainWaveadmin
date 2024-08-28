import 'package:fintech_dashboard_clone/Controller/LoginController.dart';
import 'package:fintech_dashboard_clone/widgets/Setting/SettingScreen.dart';
import 'package:fintech_dashboard_clone/widgets/category_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LoginController loginController =
        Provider.of<LoginController>(context, listen: false);
    if (loginController.loggedInUser != null) {
      nameController.text = loginController.loggedInUser!.name ?? '';
      emailController.text = loginController.loggedInUser!.email ?? '';
      // nameController.text = loginController.loggedInUser!.password ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return CategoryBox(
        isToShow: true,
        suffix: ElevatedButton(
            onPressed: () {
              Provider.of<LoginController>(context, listen: false).updateAdmin(
                  email: emailController.text,
                  name: nameController.text,
                  password: passwordController.text);
            },
            child: const Text('Update')),
        title: 'Profile',
        children: [
          customTextField(controller: nameController, context: context),
          customTextField(controller: emailController, context: context),
          customTextField(controller: passwordController, context: context),
        ]);
  }
}
