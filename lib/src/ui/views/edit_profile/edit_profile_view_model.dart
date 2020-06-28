import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/src/app/models/user_model.dart';
import 'package:instagram_clone/src/ui/global/custom_base_view_model.dart';

class EditProfileViewModel extends CustomBaseViewModel {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  File _profileImage;
  String _fullName = '';
  String _bio = '';

  File get profileImage => _profileImage;
  String get fullName => _fullName;
  String get bio => _bio;

  setProfileImage(File profileImageNewValue) {
    _profileImage = profileImageNewValue;
    notifyListeners();
  }

  setFullName(String fullNameNewValue) {
    _fullName = fullNameNewValue;
    notifyListeners();
  }

  setBio(String bioNewValue) {
    _bio = bioNewValue;
    notifyListeners();
  }

  initialize() {
    setFullName(currentUser.name);
    setBio(currentUser.bio);
  }

  handleImageFromGallery() async {
    File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      setProfileImage(imageFile);
    }
  }

  submit() async {
    if (formKey.currentState.validate() && !isBusy) {
      formKey.currentState.save();

      setBusy(true);

      // Update user in database
      String _profileImageUrl = '';

      if (_profileImage == null) {
        _profileImageUrl = currentUser.profileImageUrl;
      } else {
        _profileImageUrl = await storageService.uploadUserProfileImage(
          currentUser.profileImageUrl,
          _profileImage,
        );
      }

      User user = User(
        id: currentUser.id,
        name: _fullName,
        profileImageUrl: _profileImageUrl,
        bio: _bio,
      );
      // Database update
      firestoreService.updateUser(user);

      navigationService.back();
    }
  }
}
