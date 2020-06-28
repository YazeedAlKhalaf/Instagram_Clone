import 'package:flutter/material.dart';
import 'package:instagram_clone/src/ui/theme/theme.dart';
import 'package:instagram_clone/src/ui/widgets/dumb_widgets/busy_overlay.dart';
import 'package:instagram_clone/src/ui/widgets/dumb_widgets/custom_button.dart';
import 'package:stacked/stacked.dart';

import './login_view_model.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (
        BuildContext context,
        LoginViewModel model,
        Widget child,
      ) {
        return BusyOverlay(
          show: model.isBusy,
          child: Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        appName,
                        style: TextStyle(
                          fontFamily: 'Billabong',
                          fontSize: 50.0,
                        ),
                      ),
                      Form(
                        key: model.formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 30.0,
                                vertical: 10.0,
                              ),
                              child: TextFormField(
                                decoration: InputDecoration(labelText: 'Email'),
                                validator: (input) => !input.contains('@')
                                    ? 'Please enter a valid email'
                                    : null,
                                onSaved: (email) => model.setEmail(email),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 30.0,
                                vertical: 10.0,
                              ),
                              child: TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'Password'),
                                validator: (input) => input.length < 6
                                    ? 'Must be at least 6 characters'
                                    : null,
                                onSaved: (password) =>
                                    model.setPassword(password),
                                obscureText: true,
                              ),
                            ),
                            SizedBox(height: 20.0),
                            CustomButton(
                              text: 'Login',
                              width: 250,
                              onPressed: () async => await model.submit(),
                            ),
                            SizedBox(height: 20.0),
                            InkWell(
                              onTap: () async =>
                                  await model.navigateToSignupView(),
                              child: Text(
                                'No Account? Sign Up!',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
