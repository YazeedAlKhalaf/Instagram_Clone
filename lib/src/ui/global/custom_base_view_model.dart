import 'package:instagram_clone/src/app/generated/locator/locator.dart';
import 'package:instagram_clone/src/app/models/user_model.dart';
import 'package:instagram_clone/src/app/services/authentication_service.dart';
import 'package:instagram_clone/src/app/services/firestore_service.dart';
import 'package:instagram_clone/src/app/services/storage_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

abstract class CustomBaseViewModel extends BaseViewModel {
  final NavigationService navigationService = locator<NavigationService>();
  final DialogService dialogService = locator<DialogService>();
  final AuthenticationService authenticationService =
      locator<AuthenticationService>();
  final FirestoreService firestoreService = locator<FirestoreService>();
  final StorageService storageService = locator<StorageService>();

  User get currentUser => authenticationService.currentUser;
}
