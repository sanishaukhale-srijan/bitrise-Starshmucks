import 'package:flutter/material.dart';

class SplashScreenState extends StatelessWidget {
  const SplashScreenState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class SplashInitialState extends SplashScreenState {
  const SplashInitialState({super.key});
}

class SplashloadingState extends SplashScreenState {
  const SplashloadingState({super.key});
}

class NewUserState extends SplashScreenState {
  const NewUserState({super.key});
}

class UserExistsState extends SplashScreenState {
  const UserExistsState({super.key});
}
