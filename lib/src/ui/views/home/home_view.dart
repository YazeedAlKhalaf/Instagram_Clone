import 'package:flutter/material.dart';
import 'package:instagram_clone/src/ui/global/app_colors.dart';
import 'package:stacked/stacked.dart';

import './home_view_model.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (
        BuildContext context,
        HomeViewModel model,
        Widget child,
      ) {
        return Scaffold(
          body: model.chooseScreen(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: () async => await model.navigateToCreatePostView(),
            tooltip: 'Create Post',
            child: Icon(Icons.add_a_photo),
            elevation: 2.0,
          ),
          bottomNavigationBar: BottomAppBar(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  iconSize: 30.0,
                  color: model.currentTab == 0 ? primaryColor : lynchColor,
                  icon: Icon(Icons.home),
                  onPressed: () {
                    model.setCurrentTab(0);
                  },
                ),
                IconButton(
                  iconSize: 30.0,
                  color: model.currentTab == 1 ? primaryColor : lynchColor,
                  icon: Icon(Icons.search),
                  onPressed: () {
                    model.setCurrentTab(1);
                  },
                ),
                IconButton(
                  iconSize: 30.0,
                  color: model.currentTab == 2 ? primaryColor : lynchColor,
                  icon: Icon(Icons.notifications),
                  onPressed: () {
                    model.setCurrentTab(2);
                  },
                ),
                IconButton(
                  iconSize: 30.0,
                  color: model.currentTab == 3 ? primaryColor : lynchColor,
                  icon: Icon(Icons.account_circle),
                  onPressed: () {
                    model.setCurrentTab(3);
                  },
                ),
              ],
            ),
            shape: CircularNotchedRectangle(),
            color: Colors.white,
          ),
        );
      },
    );
  }
}
