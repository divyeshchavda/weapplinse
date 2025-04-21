import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'dart:async';

class task713 extends StatefulWidget {
  @override
  _task713State createState() => _task713State();
}

class _task713State extends State<task713> {
  final InAppPurchase _iap = InAppPurchase.instance;
  StreamSubscription<List<PurchaseDetails>>? _subscription;
  bool _isAvailable = false;
  List<ProductDetails> _products = [];
  final List<String> _subscriptionIds = ['pocketcoach.month', 'pocketcoach.year'];

  @override
  void initState() {
    super.initState();
    _initStore();
    _subscription = _iap.purchaseStream.listen((purchaseDetailsList) {
      _handlePurchaseUpdates(purchaseDetailsList);
    });
  }


  Future<void> _initStore() async {
    _isAvailable = await _iap.isAvailable();
    if (_isAvailable) {
      ProductDetailsResponse response =
      await _iap.queryProductDetails(_subscriptionIds.toSet());
      setState(() {
        _products = response.productDetails;
      });
    }
  }


  void _buySubscription(ProductDetails product) {
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: product);
    _iap.buyNonConsumable(purchaseParam: purchaseParam);
  }


  void _handlePurchaseUpdates(List<PurchaseDetails> purchaseDetailsList) {
    for (var purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.purchased ||
          purchaseDetails.status == PurchaseStatus.restored) {
        print("✅ Purchase Successful: ${purchaseDetails.productID}");
      }
      if (purchaseDetails.pendingCompletePurchase) {
        _iap.completePurchase(purchaseDetails);
      }
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("In-App Purchase")),
      body: _isAvailable
          ? Column(
        children: _products.map((product) {
          return Card(
            child: ListTile(
              title: Text(product.title),
              leading: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(image: AssetImage("assets/img_5.png"))
                ),
              ),
              subtitle: Text(product.price),
              trailing: ElevatedButton( style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Colors.black,
              ),
                child: Text("Buy",style: GoogleFonts.poppins(
                    fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white)),
                onPressed: () => _buySubscription(product),
              ),
            ),
          );
        }).toList(),
      )
          : Center(child: Text("Store Not Available")),
    );
  }
}
