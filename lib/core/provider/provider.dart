// In CartProvider
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/product_model.dart';


class CartProvider with ChangeNotifier {
  int _cartItemCount = 0;

  int get cartItemCount => _cartItemCount;

  CartProvider() {
    // Load the saved badge count when the CartProvider is initialized
    _loadSavedBadgeCount();
  }

  void incrementCartItemCount() {
    _cartItemCount++;
    _saveBadgeCount();
    notifyListeners();
  }

  void decrementCartItemCount() {
    if (_cartItemCount > 0) {
      _cartItemCount--;
      _saveBadgeCount();
      notifyListeners();
    }
  }

  void clearCart() {
    _cartItemCount = 0;
    _saveBadgeCount();
    notifyListeners();
  }

  // Load the saved badge count from SharedPreferences
  Future<void> _loadSavedBadgeCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _cartItemCount = prefs.getInt('cart_item_count') ?? 0;
    notifyListeners();
  }

  // Save the current badge count to SharedPreferences
  Future<void> _saveBadgeCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('cart_item_count', _cartItemCount);
  }
}




// In FavouriteProvider
class FavouriteProvider with ChangeNotifier {
  int _favoriteItemCount = 0;

  int get favoriteItemCount => _favoriteItemCount;

  FavouriteProvider() {
    // Load the saved favorite item count when the FavouriteProvider is initialized
    _loadSavedFavoriteItemCount();
  }

  void incrementFavoriteItemCount() {
    _favoriteItemCount++;
    _saveFavoriteItemCount();
    notifyListeners();
  }

  void decrementFavoriteItemCount() {
    if (_favoriteItemCount > 0) {
      _favoriteItemCount--;
      _saveFavoriteItemCount();
      notifyListeners();
    }
  }

  void clearFavorites() {
    _favoriteItemCount = 0;
    _saveFavoriteItemCount();
    notifyListeners();
  }

  // Load the saved favorite item count from SharedPreferences
  Future<void> _loadSavedFavoriteItemCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _favoriteItemCount = prefs.getInt('favorite_item_count') ?? 0;
    notifyListeners();
  }

  // Save the current favorite item count to SharedPreferences
  Future<void> _saveFavoriteItemCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('favorite_item_count', _favoriteItemCount);
  }
}
