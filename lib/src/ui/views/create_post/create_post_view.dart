import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/src/ui/global/ui_helpers.dart';
import 'package:instagram_clone/src/ui/widgets/dumb_widgets/busy_overlay.dart';
import 'package:stacked/stacked.dart';

import './create_post_view_model.dart';

class CreatePostView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreatePostViewModel>.reactive(
      viewModelBuilder: () => CreatePostViewModel(),
      builder: (
        BuildContext context,
        CreatePostViewModel model,
        Widget child,
      ) {
        _iosBottomSheet() {
          showCupertinoModalPopup(
            context: context,
            builder: (BuildContext context) {
              return CupertinoActionSheet(
                title: Text('Add Photo'),
                actions: <Widget>[
                  CupertinoActionSheetAction(
                    child: Text('Take Photo'),
                    onPressed: () => model.handleImage(ImageSource.camera),
                  ),
                  CupertinoActionSheetAction(
                    child: Text('Choose From Gallery'),
                    onPressed: () => model.handleImage(ImageSource.gallery),
                  ),
                ],
                cancelButton: CupertinoActionSheetAction(
                  child: Text('Cancel'),
                  onPressed: () => Navigator.pop(context),
                ),
              );
            },
          );
        }

        _androidDialog() {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return SimpleDialog(
                title: Text('Add Photo'),
                children: <Widget>[
                  SimpleDialogOption(
                    child: Text('Take Photo'),
                    onPressed: () => model.handleImage(ImageSource.camera),
                  ),
                  SimpleDialogOption(
                    child: Text('Choose From Gallery'),
                    onPressed: () => model.handleImage(ImageSource.gallery),
                  ),
                  SimpleDialogOption(
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.redAccent,
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              );
            },
          );
        }

        _showSelectImageDialog() {
          return Platform.isIOS ? _iosBottomSheet() : _androidDialog();
        }

        return BusyOverlay(
          show: model.isBusy,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                'Post Creation',
                style: Theme.of(context).textTheme.headline5,
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    'Create',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 15,
                    ),
                  ),
                  onPressed: () => model.submit(),
                ),
              ],
            ),
            body: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Center(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(blockSizeVertical(context) * 2),
                    child: Column(
                      children: <Widget>[
                        model.isBusy
                            ? Padding(
                                padding: EdgeInsets.only(bottom: 10.0),
                                child: LinearProgressIndicator(
                                  backgroundColor: Colors.blue[200],
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.blue),
                                ),
                              )
                            : SizedBox.shrink(),
                        GestureDetector(
                          onTap: _showSelectImageDialog,
                          child: Container(
                            padding: EdgeInsets.all(
                              blockSizeVertical(context) * 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: model.image == null
                                ? Icon(
                                    Icons.add_a_photo,
                                    color: Colors.white70,
                                    size: blockSizeVertical(context) * 15,
                                  )
                                : Image(
                                    image: FileImage(model.image),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        verticalSpaceLarge(context),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: blockSizeVertical(context) * 5,
                          ),
                          child: TextField(
                            controller: model.captionController,
                            style: TextStyle(
                              fontSize: blockSizeVertical(context) * 3,
                            ),
                            decoration: InputDecoration(
                              labelText: 'Caption',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            onChanged: (caption) => model.setCaption(caption),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
