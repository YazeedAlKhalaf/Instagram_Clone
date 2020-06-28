import 'package:flutter/material.dart';
import 'package:instagram_clone/src/ui/theme/theme.dart';
import 'package:instagram_clone/src/ui/widgets/dumb_widgets/busy_overlay.dart';
import 'package:instagram_clone/src/ui/widgets/dumb_widgets/custom_button.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

import './signup_view_model.dart';

class SignupView extends StatefulWidget {
  @override
  _SignupViewState createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignupViewModel>.reactive(
      viewModelBuilder: () => SignupViewModel(),
      builder: (
        BuildContext context,
        SignupViewModel model,
        Widget child,
      ) {
        return BusyOverlay(
          show: model.isBusy,
          child: Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: getValueForScreenType<double>(
                      context: context,
                      mobile: 350,
                      tablet: 650,
                      desktop: 750,
                    ),
                  ),
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
                                decoration:
                                    InputDecoration(labelText: 'Full Name'),
                                validator: (input) => input.trim().isEmpty
                                    ? 'Please enter a valid name'
                                    : null,
                                onSaved: (fullName) =>
                                    model.setFullName(fullName),
                              ),
                            ),
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
                              text: 'Sign Up',
                              width: 250,
                              onPressed: () async => await model.submit(),
                            ),
                            SizedBox(height: 20.0),
                            InkWell(
                              onTap: () async =>
                                  await model.navigateToLoginView(),
                              child: Text(
                                'Already have an account? Login',
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
