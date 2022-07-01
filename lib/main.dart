import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'payment_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? url;

  makePayment(
    double amount,
    String email,
  ) async {
    Map<String, String> headers = {
      'Authorization':
          'Bearer sk_test_c92466e2d1031748ab44f1995df0a57e504f5221',
      'Content-Type': 'application/json'
    };
    Request request = Request(
      'POST',
      Uri.parse('https://api.paystack.co/transaction/initialize'),
    );
    request.body = json.encode({
      'email': email,
      'amount': amount * 100,

      // "transaction_charge": 1000
    });
    request.headers.addAll(headers);
    StreamedResponse response = await request.send();

    Map<String, dynamic> data;
    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      data = json.decode(await response.stream.bytesToString());
      url = data['data']['authorization_url'];
      print('$url  the original');
    } else {
      (response.reasonPhrase);
      url = "https://api.paystack.co/transaction/initialize";
    }
  }

  @override
  Widget build(BuildContext context) {
/*
I called the make payment function here first
*/

    makePayment(50, "paystack@gmail.com");
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PaymentScreen(
                      url: url ?? "",
                    )),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
