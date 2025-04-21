import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:pocketcoach/Week%207/const.dart';

class StripeService {
  StripeService._();

  static final StripeService instance = StripeService._();

  Future<void> makepayment({required int amt,required String name,required String mono}) async {
    try {
      print("Make payment");
      String? paymentIntentClientSecret = await createpayment(amt, "inr",name,mono);
      if (paymentIntentClientSecret == null) {
        print("Error: Payment Intent creation failed.");
        return;
      }

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentClientSecret,
          merchantDisplayName: "Divyesh Chavda",
        ),
      );

      await process();
    } catch (e) {
      print("Payment Error: $e");
    }
  }

  Future<String?> createpayment(int amount, String currency,String name,String mono) async {
    try {
      print("create payment");
      final Dio dio = Dio();
      Map<String, dynamic> data = {
        "amount": calculate(amount),
        "currency": currency,
        "metadata": {
          "name":name,
          "mobile_no":mono,
        }, // 👈 Add metadata here
      };

      var response = await dio.post(
        "https://api.stripe.com/v1/payment_intents",
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization": "Bearer $stripeSecretKey",
            "Content-Type": "application/x-www-form-urlencoded"
          },
        ),
      );

      if (response.data != null && response.data["client_secret"] != null) {
        print("Payment Intent Created: ${response.data}");
        return response.data["client_secret"];
      } else {
        print("Error: Payment Intent response is invalid.");
        return null;
      }
    } catch (e) {
      print("API Request Error: $e");
      return null;
    }
  }


  Future<void> process() async {
    try {
      print("Process");
      await Stripe.instance.presentPaymentSheet();
    } on StripeException catch (e) {
      print("Stripe PaymentSheet Error: ${e.error.localizedMessage}");
    } catch (e) {
      print("Unexpected Error in process(): $e");
    }
  }


  String calculate(int amount) {
    return (amount * 100).toString();
  }
}
