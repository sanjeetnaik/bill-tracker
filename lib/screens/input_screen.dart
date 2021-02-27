import 'package:bill_tracker/get_data.dart';
import 'package:bill_tracker/mamba/bill.dart';
import 'package:bill_tracker/screens/newitem_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bill_tracker/mamba_components/reuseable_card_bill.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InputScreen extends StatefulWidget {
  var isadd;
  InputScreen({this.isadd});
  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  var productname;
  double sum;
  var quantity;
  var price;
  var lsoprodname = [];
  var lsoprice = [];
  var lsoquantity = [];
  var lsoresult = [];
  var lsowidgets = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Screen'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
              itemCount: lsowidgets.length,
              itemBuilder: (context, index) {
                return lsowidgets[index];
              },
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.redAccent,
                  ),
                  height: 60,
                  width: 120,
                  child: FlatButton(
                    onPressed: () {
                      setState(() {
                        productname = '';
                        quantity = '';
                        price = '';
                        lsoprodname = [];
                        lsoprice = [];
                        lsoquantity = [];
                        lsoresult = [];
                        lsowidgets = [];
                      });
                    },
                    child: Text(
                      'Clear',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blue,
                  ),
                  height: 60,
                  width: 120,
                  child: FlatButton(
                    onPressed: () async {
                      var user = await FirebaseAuth.instance.currentUser();
                      var uid = user.uid;

                      var hello = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Bill(
                            quantity: lsoquantity,
                            productName: lsoprodname,
                            price: lsoprice,
                            bill: lsowidgets,
                          ),
                        ),
                      );

                      if (widget.isadd && lsowidgets.length != 0) {
                        FocusScope.of(context).unfocus();
                        Firestore.instance
                            .collection('items')
                            .document('$uid')
                            .collection('bills')
                            .add({
                          'productNames': lsoprodname,
                          'prices': lsoprice,
                          'quantity': lsoquantity,
                          'total': hello
                        });

                        if (hello != null) {
                          Navigator.pop(context);
                        }
                      }
                    },
                    child: Text(
                      'Bill',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          lsoresult = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewItem()),
          );
          // sum = sum + (double.parse(lsoresult[1]) * int.parse(lsoresult[2]));
          lsoprodname.add(lsoresult[0]);
          lsoprice.add(double.parse(lsoresult[1]));
          lsoquantity.add(int.parse(lsoresult[2]));
          setState(
            () {
              lsowidgets.add(
                ReuseableCardBill(
                  price: double.parse(lsoresult[1]),
                  quantity: int.parse(lsoresult[2]),
                  productName: lsoresult[0],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
