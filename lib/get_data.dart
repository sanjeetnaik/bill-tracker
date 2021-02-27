import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ReadData extends StatefulWidget {
  var uid;
  ReadData({this.uid});
  @override
  _ReadDataState createState() => _ReadDataState();
}

class _ReadDataState extends State<ReadData> {
  @override
  void initState() {
    // TODO: implement initState
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Read Data'),
      ),
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('items/${widget.uid}/bills')
            .snapshots(),
        builder: (ctx, chatSnapshots) {
          if (chatSnapshots.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final chatDocs = chatSnapshots.data.documents;
            if (chatDocs.length == 0) {
              return ListView(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Center(
                      child: Text(
                    'No Data :(',
                  )),
                ],
              );
            }

            return ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
              itemCount: chatDocs.length,
              itemBuilder: (ctx, index) => Column(
                children: [
                  Text('prices : ${chatDocs[index]['prices']}'),
                  Text('products : ${chatDocs[index]['productNames']}'),
                  Text('quantity : ${chatDocs[index]['quantity']}'),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

// class ReadData extends StatelessWidget {
//   var uid;

//   ReadData({this.uid});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Read Data'),
//       ),
//       body: StreamBuilder(
//         stream: Firestore.instance.collection('items/$uid/bills').snapshots(),
//         builder: (ctx, chatSnapshots) {
//           if (chatSnapshots.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           } else {
//             final chatDocs = chatSnapshots.data.documents;
//             if (chatDocs.length == 0) {
//               return ListView(
//                 children: [
//                   SizedBox(
//                     height: 40,
//                   ),
//                   Center(
//                       child: Text(
//                     'No Data :(',
//                   )),
//                 ],
//               );
//             }

//             return ListView.builder(
//               padding: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
//               itemCount: chatDocs.length,
//               itemBuilder: (ctx, index) => Column(
//                 children: [
//                   Text('prices : ${chatDocs[index]['prices']}'),
//                   Text('products : ${chatDocs[index]['productNames']}'),
//                   Text('quantity : ${chatDocs[index]['quantity']}'),
//                 ],
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
