import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide Transition;
import 'package:get/get.dart';

import '../../common_things.dart';
import '../../home/home_screen.dart';
import '../../productdetail.dart';
import 'menu_events.dart';
import 'menu_states.dart';

class MenuBloc extends Bloc<MenuEvents, MenuStates> {
  MenuBloc() : super(const MenuInitialState()) {
    on<OnAddToCartEvent>(
      (event, emit) async {
        addToCart(event.id);
        String toastMessage = "ITEM ADDED TO CART";
        event.fToast.showToast(
          child: CustomToast(toastMessage),
          positionedToastBuilder: (context, child) => Positioned(
            bottom: MediaQuery.of(context).size.height * 0.14,
            left: MediaQuery.of(context).size.width * 0.1,
            right: MediaQuery.of(context).size.width * 0.1,
            child: child,
          ),
        );
        cartInit = true;
        emit(AddedToCartState());
      },
    );

    on<OnAddToWishlistEvent>(
      (event, emit) {
        addToWishlist(event.id);
        emit(AddedToWishlistState());
      },
    );
    on<OnRemoveFromWishlistEvent>(
      (event, emit) {
        removeFromWishlist(event.id, event.context);
        emit(RemoveFromWishlistState());
      },
    );

    on<OnTapEvent>(
      (event, emit) {
        getItem(event.item);
        Get.to(() => const ProductDetail(), transition: Transition.downToUp);
      },
    );
  }
}
