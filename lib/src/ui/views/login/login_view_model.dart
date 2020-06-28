import 'package:flutter/widgets.dart';
import 'package:instagram_clone/src/app/generated/router/router.gr.dart';
import 'package:instagram_clone/src/ui/global/custom_base_view_model.dart';

class LoginViewModel extends CustomBaseViewModel {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String _email, _password;
  String get email => _email;
  String get password => _password;

  void setEmail(String email) {
    _email = email;
  }

  void setPassword(String password) {
    _password = password;
  }

  submit() async {
    setBusy(true);
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      await authenticationService.loginWithEmail(
        email: _email,
        password: _password,
      );
      await navigationService.pushNamedAndRemoveUntil(Routes.homeViewRoute);
    }
    setBusy(false);
  }

  navigateToSignupView() async {
    await navigationService.pushNamedAndRemoveUntil(Routes.signupViewRoute);
  }
}
