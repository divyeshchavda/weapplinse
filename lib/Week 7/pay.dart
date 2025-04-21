import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentService {
  late Razorpay _razorpay;

  PaymentService() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void openCheckout({required int amt}) {
    var options = {
      'key': 'rzp_test_7VknZ5XR3KHKqI',
      'amount': amt*100,
      'name': 'Demo',
      'description': 'Payment for Order #1234',
      'prefill': {'contact': '8732988555', 'email': 'divyeshchavda2018@gmail.com'},
      'external': {'wallets': ['paytm']},
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }
  void initialize({
    required Function(String) onSuccess,
    required Function(String) onFailure,
    required Function(String) onCancel,
  }) {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, (response) {
      onSuccess(response.paymentId!);
    });

    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, (response) {
      onFailure(response.message ?? "Payment Failed");
    });

    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, (response) {
      onCancel("Payment Cancelled or External Wallet Selected");
    });
  }
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    debugPrint("Payment Successful: ${response.paymentId}");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    debugPrint("Payment Failed: ${response.code} - ${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    debugPrint("External Wallet: ${response.walletName}");
  }

  void dispose() {
    _razorpay.clear(); // Clean up resources
  }
}
