import 'package:fintech_dashboard_clone/Controller/NavigationHandler.dart';
import 'package:fintech_dashboard_clone/models/enums/navigation_items.dart';
import 'package:fintech_dashboard_clone/responsive.dart';
import 'package:fintech_dashboard_clone/widgets/navigation_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../Controller/DataController.dart';

class NavigationPanel extends StatefulWidget {
  final Axis axis;
  const NavigationPanel({Key? key, required this.axis}) : super(key: key);

  @override
  State<NavigationPanel> createState() => _NavigationPanelState();
}

class _NavigationPanelState extends State<NavigationPanel> {
  // int activeTab = 0;
  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationHandler>(
        builder: (context, navigationHandler, child) {
      return Container(
        constraints: const BoxConstraints(minWidth: 80),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        margin: Responsive.isDesktop(context)
            ? const EdgeInsets.symmetric(horizontal: 30, vertical: 20)
            : const EdgeInsets.all(10),
        child: widget.axis == Axis.vertical
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                      onTap: () {
                        Future.microtask(() =>
                            Provider.of<DataHandlerController>(context,
                                    listen: false)
                                .getCredentials());
                      },
                      child: Image.asset("assets/logo.png", height: 50)),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: NavigationItems.values
                        .map(
                          (e) => NavigationButton(
                            onPressed: () {
                              Provider.of<NavigationHandler>(context,
                                      listen: false)
                                  .updateIndex(index: e.index);
                            },
                            icon: e.icon,
                            isActive:
                                e.index == navigationHandler.selectedIndex,
                          ),
                        )
                        .toList(),
                  ),
                  Container()
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                      onTap: () {
                        Future.microtask(() =>
                            Provider.of<DataHandlerController>(context,
                                    listen: false)
                                .getCredentials());
                      },
                      child: Image.asset("assets/logo.png", height: 20)),
                  Row(
                    children: NavigationItems.values
                        .map(
                          (e) => NavigationButton(
                            onPressed: () {
                              Provider.of<NavigationHandler>(context)
                                  .updateIndex(index: e.index);
                            },
                            icon: e.icon,
                            isActive:
                                e.index == navigationHandler.selectedIndex,
                          ),
                        )
                        .toList(),
                  ),
                  Container()
                ],
              ),
      );
    });
  }
}
