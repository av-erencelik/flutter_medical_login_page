import 'package:flutter/material.dart';
import 'package:flutter_medicalapp_desing/main.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Login", style: Theme.of(context).textTheme.bodyLarge),
        leading: const Icon(
          Icons.chevron_left,
          color: Colors.black,
          size: 32,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            const Expanded(
              flex: 6,
              child: LoginForm(),
            ),
            Divider(
              color: CustomColors().greyLight,
              thickness: 2,
            ),
            const Expanded(
              flex: 4,
              child: Auth(),
            )
          ],
        ),
      ),
    );
  }
}

class Auth extends StatelessWidget {
  const Auth({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                      side: BorderSide(color: CustomColors().greyLight)) // NEW
                  ),
              icon: const FaIcon(
                FontAwesomeIcons.google,
                color: Colors.blue,
              ),
              onPressed: () {},
              label: Text(
                "Sign In with Google",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.black, fontSize: 16),
              )),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                      side: BorderSide(color: CustomColors().greyLight)) // NEW
                  ),
              icon: const FaIcon(
                FontAwesomeIcons.facebook,
                color: Colors.blue,
              ),
              onPressed: () {},
              label: Text(
                "Sign In with Facebook",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.black, fontSize: 16),
              ))
        ],
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        const TextWidget(),
        const SizedBox(
          height: 16,
        ),
        const TextWidget(
          isPasswordField: true,
        ),
        const Forgot(),
        const SizedBox(
          height: 40,
        ),
        LoginButton(
          formKey: _formKey,
        ),
        const SizedBox(
          height: 25,
        ),
        const SignUp()
      ]),
    );
  }
}

class SignUp extends StatelessWidget {
  const SignUp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account?",
          style: TextStyle(color: CustomColors().greyDark, fontSize: 16),
        ),
        TextButton(onPressed: () {}, child: const Text("Sign Up"))
      ],
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.formKey,
  });
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(50),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24)) // NEW
            ),
        onPressed: () {
          if (formKey.currentState!.validate()) {
            // If the form is valid, display a snackbar. In the real world,
            // you'd often call a server or save the information in a database.
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const Login(),
              ),
            );
          }
        },
        child: Text(
          "Login",
          style: Theme.of(context).textTheme.bodyMedium,
        ));
  }
}

class Forgot extends StatelessWidget {
  const Forgot({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(10),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const Text(
            "Forgot Password?",
          ),
        )
      ],
    );
  }
}

class TextWidget extends StatefulWidget {
  const TextWidget({
    super.key,
    this.isPasswordField = false,
  });
  final bool isPasswordField;
  @override
  State<TextWidget> createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  late FocusNode myFocusNode;
  final ValueNotifier<bool> _myFocusNotifier = ValueNotifier<bool>(false);
  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
    myFocusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    myFocusNode.removeListener(_onFocusChange);
    myFocusNode.dispose();
    _myFocusNotifier.dispose();

    super.dispose();
  }

  void _onFocusChange() {
    _myFocusNotifier.value = myFocusNode.hasFocus;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _myFocusNotifier,
      builder: (context, isFocus, child) {
        return TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          focusNode: myFocusNode,
          style: const TextStyle(color: Colors.black),
          controller: myController,
          obscureText: widget.isPasswordField,
          enableSuggestions: widget.isPasswordField ? false : true,
          autocorrect: widget.isPasswordField ? false : true,
          decoration: InputDecoration(
              prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 23, right: 10),
                  child: widget.isPasswordField
                      ? Icon(
                          Icons.lock_outline,
                          size: 24,
                          color: myController.text.isNotEmpty
                              ? CustomColors().green
                              : CustomColors().greyDark,
                        )
                      : Icon(
                          Icons.email_outlined,
                          size: 24,
                          color: myController.text.isNotEmpty
                              ? CustomColors().green
                              : CustomColors().greyDark,
                        )),
              suffixIcon: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 23),
                  child: widget.isPasswordField
                      ? Icon(
                          Icons.disabled_visible,
                          size: 24,
                          color: myController.text.isNotEmpty
                              ? CustomColors().green
                              : CustomColors().greyDark,
                        )
                      : myController.text.isNotEmpty
                          ? Icon(
                              Icons.done,
                              size: 24,
                              color: myController.text.isNotEmpty
                                  ? CustomColors().green
                                  : CustomColors().greyDark,
                            )
                          : null),
              hintText: widget.isPasswordField
                  ? 'Enter your password'
                  : 'Enter your email',
              hintStyle: TextStyle(color: CustomColors().greyDark),
              contentPadding: const EdgeInsets.all(20),
              fillColor: isFocus ? Colors.white : CustomColors().greyLight,
              filled: true,
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: CustomColors().greyDark),
                  borderRadius: const BorderRadius.all(Radius.circular(24))),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: CustomColors().greyLight),
                  borderRadius: const BorderRadius.all(Radius.circular(24)))),
        );
      },
    );
  }
}
