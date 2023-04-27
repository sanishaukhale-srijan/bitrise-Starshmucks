import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:starshmucks/model/wishlist_model.dart';

abstract class MenuEvents {}

class OnAddToCartEvent extends MenuEvents {
  late int id;
  late FToast fToast;

  OnAddToCartEvent(this.id, this.fToast);
}

class OnAddToWishlistEvent extends MenuEvents {
  late int id;

  OnAddToWishlistEvent(this.id);
}

class OnRemoveFromWishlistEvent extends MenuEvents {
  late WishlistModel id;
  BuildContext context;

  OnRemoveFromWishlistEvent(this.id, this.context);
}

class OnTapEvent extends MenuEvents {
  late var item;

  OnTapEvent(this.item);
}
