import 'package:flutter/material.dart';

class MenuStates extends StatelessWidget {
  const MenuStates({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class MenuInitialState extends MenuStates {
  const MenuInitialState({super.key});
}

class AddedToCartState extends MenuStates {}

class AddedToWishlistState extends MenuStates {}

class RemoveFromWishlistState extends MenuStates {}
