import 'package:flutter/material.dart';
import 'package:product_listing_rehmat_e_shereen/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

getData() async {
  List<Map<String, dynamic>> queryRows =
      await DatabaseHelper.instance.queryAll();
  print(queryRows);
  return queryRows;
}

class _CartState extends State<Cart> {
  int priceTotal = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            setTotal() {
              for (int i = 0; i < snapshot.data.length; i++) {
                priceTotal = priceTotal + snapshot.data[i]['price'];
              }
            }

            setTotal();

            print(DatabaseHelper.instance.getTotal().toString());
            return Column(children: [
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(snapshot.data[index]['name']),
                        subtitle: Text(
                            'Price: ${snapshot.data[index]['price'].toString()}'),
                        trailing: IconButton(
                          onPressed: () async {
                            int rowsEffected = await DatabaseHelper.instance
                                .delete(snapshot.data[index]['_id']);
                            setState(() {
                              setTotal();
                            });
                            final snackBar = SnackBar(
                              content: Text('Deleted from cart successfully'),
                              action: SnackBarAction(
                                label: 'Undo',
                                onPressed: () {
                                  // Some code to undo the change.
                                },
                              ),
                            );
                            print(rowsEffected);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      );
                    }),
              ),
              // Text(priceTotal.toString()),
            ]);
          } else {
            return Center(child: new CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
