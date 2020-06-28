import 'package:instagram_clone/src/ui/global/custom_base_view_model.dart';
import 'package:instagram_clone/src/app/models/post_model.dart';

class FeedViewModel extends CustomBaseViewModel {
  List<Post> _posts = [];
  List<Post> get posts => _posts;

  initialize() async {
    await setupFeed();
  }

  setupFeed() async {
    List<Post> posts = await firestoreService.getFeedPosts(currentUser.id);
    _posts = posts;
    notifyListeners();
  }
}
