import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:instagram_clone/src/app/generated/router/router.gr.dart';
import 'package:instagram_clone/src/ui/global/custom_base_view_model.dart';

class SearchViewModel extends CustomBaseViewModel {
  final TextEditingController searchController = TextEditingController();
  Future<QuerySnapshot> _users;
  Future<QuerySnapshot> get users => _users;

  setUsers(Future<QuerySnapshot> usersNewValue) {
    _users = usersNewValue;
    notifyListeners();
  }

  clearSearch() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => searchController.clear());
    setUsers(null);
  }

  searchOnSubmitted(String searchValue) {
    if (searchValue.isNotEmpty) {
      setUsers(firestoreService.searchUsers(searchValue));
    }
  }

  navigateToProfileView({@required String userId}) async {
    await navigationService.navigateTo(
      Routes.profileViewRoute,
      arguments: ProfileViewArguments(
        userId: userId,
      ),
    );
  }
}
