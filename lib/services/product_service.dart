import '../models/product.dart';

class ProductService {
  // Sample products data
  static List<Product> _products = [
    Product(
      id: '1',
      name: 'iPhone 15 Pro',
      description: 'Latest iPhone with A17 Pro chip, titanium design, and advanced camera system. Features include 6.1-inch Super Retina XDR display, 48MP main camera, and up to 1TB storage.',
      price: 18999000,
      imageUrl: 'https://images.unsplash.com/photo-1592750475338-74b7b21085ab?w=400&h=400&fit=crop',
      category: 'Electronics',
      rating: 4.8,
      reviewCount: 1234,
    ),
    Product(
      id: '2',
      name: 'MacBook Air M3',
      description: 'Ultra-thin laptop with M3 chip for incredible performance and battery life. Perfect for students and professionals who need portability without compromising power.',
      price: 17999000,
      imageUrl: 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=400&h=400&fit=crop',
      category: 'Electronics',
      rating: 4.7,
      reviewCount: 892,
    ),
    Product(
      id: '3',
      name: 'Sony WH-1000XM5',
      description: 'Industry-leading noise canceling headphones with crystal clear hands-free calling and Alexa voice control. 30-hour battery life with quick charge.',
      price: 5499000,
      imageUrl: 'https://images.unsplash.com/photo-1583394838336-acd977736f90?w=400&h=400&fit=crop',
      category: 'Electronics',
      rating: 4.6,
      reviewCount: 567,
    ),
    Product(
      id: '4',
      name: 'Nike Air Max 270',
      description: 'Lifestyle shoe with large Max Air unit for all-day comfort. Modern design meets classic Air cushioning for the perfect everyday sneaker.',
      price: 2199000,
      imageUrl: 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=400&h=400&fit=crop',
      category: 'Fashion',
      rating: 4.4,
      reviewCount: 324,
    ),
    Product(
      id: '5',
      name: 'Adidas Ultraboost 22',
      description: 'High-performance running shoe with responsive Boost midsole and Primeknit upper. Designed for runners who demand the best in comfort and energy return.',
      price: 2899000,
      imageUrl: 'https://images.unsplash.com/photo-1549298916-b41d501d3772?w=400&h=400&fit=crop',
      category: 'Fashion',
      rating: 4.5,
      reviewCount: 445,
    ),
    Product(
      id: '6',
      name: 'Coffee Bean Premium Blend',
      description: 'Carefully selected arabica beans from the highlands of Java. Medium roast with notes of chocolate and caramel. Perfect for espresso or drip coffee.',
      price: 125000,
      imageUrl: 'https://images.unsplash.com/photo-1559056199-641a0ac8b55e?w=400&h=400&fit=crop',
      category: 'Food & Beverage',
      rating: 4.3,
      reviewCount: 156,
    ),
    Product(
      id: '7',
      name: 'Organic Green Tea',
      description: 'Premium organic green tea leaves from the mountains of West Java. Rich in antioxidants and perfect for daily wellness routine.',
      price: 89000,
      imageUrl: 'https://images.unsplash.com/photo-1544787219-7f47ccb76574?w=400&h=400&fit=crop',
      category: 'Food & Beverage',
      rating: 4.2,
      reviewCount: 89,
    ),
    Product(
      id: '8',
      name: 'Samsung Galaxy Watch 6',
      description: 'Advanced smartwatch with health monitoring, GPS tracking, and long battery life. Compatible with Android and iOS devices.',
      price: 4299000,
      imageUrl: 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=400&h=400&fit=crop',
      category: 'Electronics',
      rating: 4.4,
      reviewCount: 278,
    ),
    Product(
      id: '9',
      name: 'Levi\'s 501 Original Jeans',
      description: 'Classic straight-fit jeans made with premium denim. Timeless design that never goes out of style. Available in multiple washes.',
      price: 1299000,
      imageUrl: 'https://images.unsplash.com/photo-1542272604-787c3835535d?w=400&h=400&fit=crop',
      category: 'Fashion',
      rating: 4.1,
      reviewCount: 234,
    ),
    Product(
      id: '10',
      name: 'Instant Noodles Pack',
      description: 'Delicious instant noodles with authentic Indonesian flavors. Quick and easy meal solution for busy lifestyles. Pack of 5.',
      price: 15000,
      imageUrl: 'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=400&h=400&fit=crop',
      category: 'Food & Beverage',
      rating: 3.9,
      reviewCount: 67,
    ),
  ];

  // Get all products
  static List<Product> getAllProducts() {
    return List.unmodifiable(_products);
  }

  // Get products by category
  static List<Product> getProductsByCategory(String category) {
    return _products.where((product) => product.category == category).toList();
  }

  // Get product by ID
  static Product? getProductById(String id) {
    try {
      return _products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }

  // Search products by name or description
  static List<Product> searchProducts(String query) {
    if (query.isEmpty) return getAllProducts();
    
    final lowercaseQuery = query.toLowerCase();
    return _products.where((product) {
      return product.name.toLowerCase().contains(lowercaseQuery) ||
             product.description.toLowerCase().contains(lowercaseQuery) ||
             product.category.toLowerCase().contains(lowercaseQuery);
    }).toList();
  }

  // Get all unique categories
  static List<String> getCategories() {
    final categories = _products.map((product) => product.category).toSet().toList();
    categories.sort();
    return categories;
  }

  // Get featured products (e.g., highest rated)
  static List<Product> getFeaturedProducts({int limit = 6}) {
    final sortedProducts = List<Product>.from(_products);
    sortedProducts.sort((a, b) => b.rating.compareTo(a.rating));
    return sortedProducts.take(limit).toList();
  }
}
