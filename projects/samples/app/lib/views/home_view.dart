import 'package:app/core/themes/custom_theme_data.dart';
import 'package:app/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomWidgets.customAppBar(),
      drawer: CustomWidgets.customDrawer(),
      body: CustomWidgets.customContainer(),
      floatingActionButton: CustomWidgets.getFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomWidgets.customBottomNavBar(),
    );
  }
}
