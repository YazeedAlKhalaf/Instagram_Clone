import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/src/app/models/post_model.dart';
import 'package:instagram_clone/src/ui/global/custom_base_view_model.dart';

class CreatePostViewModel extends CustomBaseViewModel {
  final TextEditingController captionController = TextEditingController();

  File _image;
  String _caption = '';

  File get image => _image;
  String get caption => _caption;

  setCaption(caption) {
    _caption = caption;
  }

  handleImage(ImageSource source) async {
    navigationService.back();
    File imageFile = await ImagePicker.pickImage(source: source);
    if (imageFile != null) {
      imageFile = await _cropImage(imageFile);
      _image = imageFile;
      notifyListeners();
    } else {
      await dialogService.showDialog(
        title: 'Something Went Wrong!',
        description: 'Please try again later.',
      );
    }
  }

  _cropImage(File imageFile) async {
    File croppedImage = await ImageCropper.cropImage(
      sourcePath: imageFile.path,
      aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
    );
    return croppedImage;
  }

  submit() async {
    if (!isBusy && _image != null && _caption.isNotEmpty) {
      setBusy(true);
      // Create post
      String imageUrl = await storageService.uploadPost(_image);
      Post post = Post(
        imageUrl: imageUrl,
        caption: _caption,
        likeCount: 0,
        authorId: currentUser.id,
        timestamp: Timestamp.fromDate(DateTime.now()),
      );
      await firestoreService.createPost(post);

      // Reset data
      captionController.clear();
      _caption = '';
      _image = null;
      setBusy(false);
    }

    // Get Out
    navigationService.back();
  }
}
