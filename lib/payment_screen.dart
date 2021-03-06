import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentScreen extends StatefulWidget {
  final String url;

/*

Just click on the floating action button



My problem is after the payment is successfull,
the nevigation delegate never gets called
because the url never changes.
This makes it difficult for me to get response from
the webview.
*/

  const PaymentScreen({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        userAgent: 'Flutter;Webview',
        navigationDelegate: (navigation) async {
/*
The print function below is to show you that the navigation delegate function
Never gets called.
*/

          print("The url now is ${navigation.url}");
          if (navigation.url == "https://hello.pstk.xyz/callback") {
            Navigator.of(context).pop(); //close webview

          }
          return NavigationDecision.navigate;
        },
      ),
    );
  }
}
