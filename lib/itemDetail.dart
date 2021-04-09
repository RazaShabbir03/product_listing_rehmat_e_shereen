import 'package:flutter/material.dart';
import 'package:product_listing_rehmat_e_shereen/database_helper.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';

class ItemDetail extends StatefulWidget {
  final String name;
  final int price;
  ItemDetail(this.name, this.price);

  @override
  _ItemDetailState createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        Center(
          child: Text(
            widget.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
        ),
        SizedBox(
          height: queryData.size.height * 0.05,
        ),
        Center(
            child: Text(
          'Price: ${widget.price.toString()}',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        )),
        SizedBox(
          height: queryData.size.height * 0.20,
        ),
        ElevatedButton(
          onPressed: () async {
            int i = await DatabaseHelper.instance.insert({
              DatabaseHelper.columnName: widget.name,
              DatabaseHelper.columnPrice: widget.price,
            });
            final snackBar = SnackBar(
              content: Text('Added to cart successfully'),
              action: SnackBarAction(
                label: 'Undo',
                onPressed: () {},
              ),
            );
            print('inserted Id is $i');
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
          child:
              Text("add to cart".toUpperCase(), style: TextStyle(fontSize: 14)),
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                    side: BorderSide(color: Colors.blue))),
          ),
        ),
        SizedBox(
          height: queryData.size.height * 0.10,
        ),
      ]),
    );
  }
}
