import 'package:flutter/foundation.dart';
import '../models/product.dart';
import '../models/cart_item.dart';

class CartService extends ChangeNotifier {
  final List<CartItem> _items = [];

  // Getter for cart items
  List<CartItem> get items => List.unmodifiable(_items);

  // Get total number of items in cart
  int get totalItems => _items.fold(0, (sum, item) => sum + item.quantity);

  // Get total price of all items in cart
  double get totalPrice => _items.fold(0.0, (sum, item) => sum + item.totalPrice);

  // Get formatted total price
  String get formattedTotalPrice => 'Rp ${totalPrice.toStringAsFixed(0).replaceAllMapped(
    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
    (Match m) => '${m[1]}.',
  )}';

  // Check if cart is empty
  bool get isEmpty => _items.isEmpty;

  // Check if cart is not empty
  bool get isNotEmpty => _items.isNotEmpty;

  // Add product to cart
  void addProduct(Product product) {
    final existingIndex = _items.indexWhere((item) => item.product.id == product.id);
    
    if (existingIndex >= 0) {
      // Product already exists, increase quantity
      _items[existingIndex] = _items[existingIndex].copyWith(
        quantity: _items[existingIndex].quantity + 1,
      );
    } else {
      // New product, add to cart
      _items.add(CartItem(product: product, quantity: 1));
    }
    
    notifyListeners();
  }

  // Remove product from cart completely
  void removeProduct(String productId) {
    _items.removeWhere((item) => item.product.id == productId);
    notifyListeners();
  }

  // Update quantity of a specific product
  void updateQuantity(String productId, int newQuantity) {
    if (newQuantity <= 0) {
      removeProduct(productId);
      return;
    }

    final existingIndex = _items.indexWhere((item) => item.product.id == productId);
    if (existingIndex >= 0) {
      _items[existingIndex] = _items[existingIndex].copyWith(quantity: newQuantity);
      notifyListeners();
    }
  }

  // Decrease quantity by 1
  void decreaseQuantity(String productId) {
    final existingIndex = _items.indexWhere((item) => item.product.id == productId);
    if (existingIndex >= 0) {
      final currentQuantity = _items[existingIndex].quantity;
      if (currentQuantity > 1) {
        _items[existingIndex] = _items[existingIndex].copyWith(quantity: currentQuantity - 1);
      } else {
        _items.removeAt(existingIndex);
      }
      notifyListeners();
    }
  }

  // Get quantity of a specific product in cart
  int getProductQuantity(String productId) {
    final item = _items.firstWhere(
      (item) => item.product.id == productId,
      orElse: () => CartItem(product: Product(id: '', name: '', description: '', price: 0, imageUrl: '', category: ''), quantity: 0),
    );
    return item.quantity;
  }

  // Check if product is in cart
  bool isProductInCart(String productId) {
    return _items.any((item) => item.product.id == productId);
  }

  // Clear all items from cart
  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
