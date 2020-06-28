import 'package:instagram_clone/src/app/generated/router/router.gr.dart';
import 'package:instagram_clone/src/ui/global/custom_base_view_model.dart';

class StartupViewModel extends CustomBaseViewModel {
  Future handleStartup() async {
    var isUserLoggedIn = await authenticationService.isUserLoggedIn();

    if (isUserLoggedIn) {
      await navigateToHomeView();
    } else {
      await navigateToSignUpView();
    }
  }

  Future navigateToHomeView() async {
    await navigationService.pushNamedAndRemoveUntil(Routes.homeViewRoute);
  }

  Future navigateToSignUpView() async {
    await navigationService.pushNamedAndRemoveUntil(Routes.signupViewRoute);
  }

  Future navigateToLoginView() async {
    await navigationService.pushNamedAndRemoveUntil(Routes.loginViewRoute);
  }
}
