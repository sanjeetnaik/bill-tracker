import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bill_tracker/mamba_components/reuseable_card_bill.dart';
import 'package:bill_tracker/mamba_components/bottom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Bill extends StatelessWidget {
  double _amount = 0;

  Bill({this.productName, this.quantity, this.price, this.bill});

  var productName = [];
  var quantity = [];
  var price = [];
  var bill = [];

  String getAmountWithoutGst() {
    for (int i = 0; i < quantity.length; i++) {
      _amount += quantity[i] * price[i];
    }
    return _amount.toStringAsFixed(2);
  }

  String getGst() {
    double gst = _amount * 0.025;
    return gst.toStringAsFixed(2);
  }

  String getFinalAmount() {
    _amount += _amount * 0.05;
    return _amount.toStringAsFixed(2);
  }

  Future pushme() async {
    var user = await FirebaseAuth.instance.currentUser();
    var uid = user.uid;
    String d = getFinalAmount();
    return d;
  }

  @override
  Widget build(BuildContext context) {
    var a = getAmountWithoutGst();
    var b = getGst();
    var c = getFinalAmount();
    pushme();

    var widget = Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Sub Total :'),
                  Text(a),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('ADD CGST @2.5% :'),
                Text(b),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('ADD CGST @2.5% :'),
                Text(b),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total Amount :'),
                  Text(c),
                ],
              ),
            ),
          ],
        ),
      ),
      width: double.infinity,
      height: 120.0,
      margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: Color(0xFF1D1E33),
        borderRadius: BorderRadius.circular(5.0),
      ),
    );
    // bill.add(a);
    // bill.add(b);
    // bill.add(c);
    // bill.add(widget);

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Bill'),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                itemCount: bill.length,
                itemBuilder: (BuildContext context, int index) {
                  return bill[index];
                }),
            SizedBox(
              height: 30,
            ),
            widget,
            SizedBox(
              height: 30,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.blue,
              ),
              height: 60,
              width: 150,
              child: FlatButton(
                onPressed: () {
                  Navigator.pop(context, c);
                },
                child: Text(
                  'Confirm Bill',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
