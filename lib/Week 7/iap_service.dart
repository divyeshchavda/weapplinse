import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class MockIAPService {
  Future<List<ProductDetails>> fetchProducts() async {
    // Mock product details
    return [
      ProductDetails(
        id: 'mock_product_1',
        title: 'Mock Product 1',
        description: 'This is a mock product.',
        price: '2000',
        rawPrice: 2000.0,
        currencyCode: 'INR',
      ),
    ];
  }

  Future<void> buyProduct(ProductDetails productDetails) async {
    // Simulate successful purchase
    print('Mock purchase successful for: ${productDetails.title}');
  }
}
