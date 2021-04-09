import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:product_listing_rehmat_e_shereen/cart.dart';
import 'package:product_listing_rehmat_e_shereen/database_helper.dart';
import 'package:product_listing_rehmat_e_shereen/itemDetail.dart';
import 'package:product_listing_rehmat_e_shereen/network.dart';

void main() {
  runApp(MyApp());
}

Future<ProductListing> fetchData() async {
  var response = await http.get(Uri.parse(
      'http://165.227.69.207/rehmat-e-sheree/public/api/products/hashlob/web-data/products/get/all/auth'));
  final productListing = productListingFromJson(response.body);
  return productListing;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    return new ListView.builder(
      itemCount: snapshot.data.data.length,
      itemBuilder: (BuildContext context, index) {
        int price = int.parse(snapshot.data.data[index].price);
        return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ItemDetail(snapshot.data.data[index].name, price)),
              );
            },
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Card(
                child: ListTile(
                    tileColor: Colors.grey[200],
                    title: Text(snapshot.data.data[index].name)),
              ),
            ));
      },
    );
  }

  int counter = 0;
  getData() async {
    List<Map<String, dynamic>> queryRows =
        await DatabaseHelper.instance.queryAll();
    print(queryRows);
    return queryRows;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Listing'),
        actions: [
          FutureBuilder(
              future: getData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Stack(
                    children: <Widget>[
                      Center(
                        child: new IconButton(
                            icon: Icon(Icons.shopping_cart),
                            onPressed: () {
                              setState(() {
                                counter = snapshot.data.length;
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Cart()),
                              );
                            }),
                      ),
                      counter != 0
                          ? new Positioned(
                              right: 11,
                              top: 11,
                              child: new Container(
                                padding: EdgeInsets.all(2),
                                decoration: new BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                constraints: BoxConstraints(
                                  minWidth: 14,
                                  minHeight: 14,
                                ),
                                child: Text(
                                  '$counter',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 8,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          : new Container()
                    ],
                  );
                } else {
                  return new CircularProgressIndicator();
                }
              }),
        ],
      ),
      body: FutureBuilder<ProductListing>(
          future: fetchData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData)
              return createListView(context, snapshot);
            else
              return Center(child: new CircularProgressIndicator());
          }),
    );
  }
}
