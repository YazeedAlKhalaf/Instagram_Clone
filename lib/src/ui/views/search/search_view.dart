import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/src/app/models/user_model.dart';
import 'package:instagram_clone/src/ui/global/app_colors.dart';
import 'package:stacked/stacked.dart';

import './search_view_model.dart';

class SearchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchViewModel>.reactive(
      viewModelBuilder: () => SearchViewModel(),
      builder: (
        BuildContext context,
        SearchViewModel model,
        Widget child,
      ) {
        _buildUserTile(User user) {
          return ListTile(
            leading: CircleAvatar(
              radius: 20.0,
              backgroundImage: user.profileImageUrl.isEmpty
                  ? AssetImage(
                      'assets/images/placeholders/user_placeholder.png',
                    )
                  : CachedNetworkImageProvider(
                      user.profileImageUrl,
                    ),
            ),
            title: Text(user.name),
            onTap: () => model.navigateToProfileView(userId: user.id),
          );
        }

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: TextField(
              controller: model.searchController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                border: InputBorder.none,
                fillColor: backgroundColor,
                hintText: 'Search',
                prefixIcon: Icon(
                  Icons.search,
                  size: 30.0,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.clear,
                  ),
                  onPressed: model.clearSearch,
                ),
                filled: true,
              ),
              onSubmitted: model.searchOnSubmitted,
            ),
          ),
          body: model.users == null
              ? Center(
                  child: Text('Search for a user'),
                )
              : FutureBuilder<QuerySnapshot>(
                  future: model.users,
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot,
                  ) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.data.documents.length == 0) {
                      return Center(
                        child: Text('No users found! Please try again.'),
                      );
                    }
                    return ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (BuildContext context, int index) {
                        User user = User.fromMap(
                          snapshot.data.documents[index].data,
                        );
                        return _buildUserTile(user);
                      },
                    );
                  },
                ),
        );
      },
    );
  }
}
