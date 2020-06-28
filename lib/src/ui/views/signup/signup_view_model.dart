import 'package:flutter/widgets.dart';
import 'package:instagram_clone/src/app/generated/router/router.gr.dart';
import 'package:instagram_clone/src/ui/global/custom_base_view_model.dart';

class SignupViewModel extends CustomBaseViewModel {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String _fullName, _email, _password;
  String get fullName => _fullName;
  String get email => _email;
  String get password => _password;

  void setFullName(String fullName) {
    _fullName = fullName;
  }

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
      await authenticationService.signUpWithEmail(
        fullName: _fullName,
        email: _email,
        password: _password,
      );
      await navigationService.pushNamedAndRemoveUntil(Routes.homeViewRoute);
    }
    setBusy(false);
  }

  navigateToLoginView() async {
    await navigationService.pushNamedAndRemoveUntil(Routes.loginViewRoute);
  }
}
