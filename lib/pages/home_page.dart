import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:payment_gateway/utils/app_string.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePAgeState createState() => _HomePAgeState();
}

class _HomePAgeState extends State<HomePage> {
  final int _count = 1;
  final int _amount = 200;
  Razorpay _razorpay = Razorpay();

  @override
  void initState() {
    _razorpay = Razorpay();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _appBar(),
        body: _homeBody(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  PreferredSizeWidget? _appBar() => AppBar(
        title: Text(AppString.homeAppBar),
        backgroundColor: Colors.blue,
        elevation: 5.0,
      );

  Widget? _homeBody() => SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                var options = {
                  'key': AppString.razorPayKeyId,
                  'amount': _amount,
                  'name': 'Vrajesh',
                  'description': 'Testing',
                  'prefill': {'contact': 9265843792, 'email': 'vrajesh.stackapp@gmail.com'}
                };

                try {
                  _razorpay.open(options);
                } catch (e) {
                  print("Encountered error :- $e");
                }
              },
              child: Text(
                AppString.razorPayNow,
                style: const TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                elevation: 5.0,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {

              },
              child: Text(
                AppString.stripePayNow,
                style: const TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                elevation: 5.0,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ],
        ),
      );

  void _handlePaymentSuccess(PaymentSuccessResponse response) => displayDialog(context, response.paymentId);

  void _handlePaymentError(PaymentFailureResponse response) {
    // # What you want to do on payment failure
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // # What you want to do when user choses an external wallet
  }

  displayDialog(BuildContext context, String? paymentId) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Stack(
            children: [
              Column(
                children: [
                  Text(
                    AppString.transactionSuccessful,
                    style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "ID : $paymentId",
                    style: const TextStyle(color: Colors.grey, fontSize: 20, fontWeight: FontWeight.normal),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
