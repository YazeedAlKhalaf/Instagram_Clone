import 'package:flutter/widgets.dart';
import 'package:instagram_clone/src/ui/global/custom_base_view_model.dart';

class CommentsViewModel extends CustomBaseViewModel {
  final TextEditingController commentController = TextEditingController();

  bool _isCommenting = false;
  bool get isCommenting => _isCommenting;

  setIsCommenting(bool isCommentingNewValue) {
    _isCommenting = isCommentingNewValue;
    notifyListeners();
  }
}
