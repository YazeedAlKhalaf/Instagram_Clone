import 'package:instagram_clone/src/app/generated/router/router.gr.dart';
import 'package:instagram_clone/src/ui/global/custom_base_view_model.dart';
import 'package:instagram_clone/src/ui/views/activity/activity_view.dart';
import 'package:instagram_clone/src/ui/views/feed/feed_view.dart';
import 'package:instagram_clone/src/ui/views/profile/profile_view.dart';
import 'package:instagram_clone/src/ui/views/search/search_view.dart';

class HomeViewModel extends CustomBaseViewModel {
  int _currentTab = 0;
  int get currentTab => _currentTab;

  setCurrentTab(int currentTabNewIndex) {
    _currentTab = currentTabNewIndex;
    notifyListeners();
  }

  chooseScreen() {
    var chosenScreen;
    switch (_currentTab) {
      case 0:
        chosenScreen = FeedView();
        break;
      case 1:
        chosenScreen = SearchView();
        break;
      case 2:
        chosenScreen = ActivityView();
        break;
      case 3:
        chosenScreen = ProfileView(
          userId: currentUser.id,
        );
        break;
    }

    return chosenScreen;
  }

  navigateToCreatePostView() async {
    await navigationService.navigateTo(Routes.createPostViewRoute);
  }
}
