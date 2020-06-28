import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/src/ui/widgets/dumb_widgets/busy_overlay.dart';
import 'package:stacked/stacked.dart';

import './edit_profile_view_model.dart';

class EditProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EditProfileViewModel>.reactive(
      viewModelBuilder: () => EditProfileViewModel(),
      onModelReady: (EditProfileViewModel model) => model.initialize(),
      builder: (
        BuildContext context,
        EditProfileViewModel model,
        Widget child,
      ) {
        _displayProfileImage() {
          // No new profile image
          if (model.profileImage == null) {
            // No existing profile image
            if (model.currentUser.profileImageUrl.isEmpty) {
              // Display placeholder
              return AssetImage(
                'assets/images/placeholders/user_placeholder.png',
              );
            } else {
              // User profile image exists
              return CachedNetworkImageProvider(
                model.currentUser.profileImageUrl,
              );
            }
          } else {
            // New profile image
            return FileImage(model.profileImage);
          }
        }

        return BusyOverlay(
          show: model.isBusy,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'Edit Profile',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            body: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: ListView(
                children: <Widget>[
                  model.isBusy
                      ? LinearProgressIndicator(
                          backgroundColor: Colors.blue[200],
                          valueColor: AlwaysStoppedAnimation(
                            Colors.blue,
                          ),
                        )
                      : SizedBox.shrink(),
                  Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Form(
                      key: model.formKey,
                      child: Column(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 60.0,
                            backgroundColor: Colors.grey,
                            backgroundImage: _displayProfileImage(),
                          ),
                          FlatButton(
                            onPressed: model.handleImageFromGallery,
                            child: Text(
                              'Change Profile Image',
                              style:
                                  Theme.of(context).accentTextTheme.subtitle2,
                            ),
                          ),
                          TextFormField(
                            initialValue: model.fullName,
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.person,
                                size: 30.0,
                              ),
                              labelText: 'Full Name',
                            ),
                            validator: (input) => input.trim().length < 1
                                ? 'Please enter a valid name'
                                : null,
                            onSaved: (fullName) => model.setFullName(fullName),
                          ),
                          TextFormField(
                            initialValue: model.bio,
                            style: TextStyle(fontSize: 18.0),
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.book,
                                size: 30.0,
                              ),
                              labelText: 'Bio',
                            ),
                            validator: (input) => input.trim().length > 150
                                ? 'Please enter a bio less than 150 characters'
                                : null,
                            onSaved: (bio) => model.setBio(bio),
                          ),
                          Container(
                            margin: EdgeInsets.all(40.0),
                            height: 40.0,
                            width: 250.0,
                            child: FlatButton(
                              onPressed: () => model.submit(),
                              color: Colors.blue,
                              textColor: Colors.white,
                              child: Text(
                                'Save Profile',
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
