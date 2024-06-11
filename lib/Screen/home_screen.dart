import 'package:flutter/material.dart';
import '../Models/product.dart';
import '../services/api_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(
              Icons.menu_outlined,
              color: Colors.black,
              size: 25.0,
            ),
            const SizedBox(width: 10), // Jarak antara ikon dan teks
            const Text('Home Screen'),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_outlined, color: Colors.black),
            onPressed: () {
              // Tambahkan aksi yang diinginkan di sini
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_bag_outlined, color: Colors.black),
            onPressed: () {
              // Tambahkan aksi yang diinginkan di sini
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (value) {
                // Handle search input change
                print('Search term: $value');
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Categories",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  // margin: EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0),
                  height: 50.0,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        CategoryChip(label: 'All'),
                        CategoryChip(label: 'Fasion'),
                        CategoryChip(label: ' Electronics'),
                        CategoryChip(label: 'Appliances'),
                        CategoryChip(label: 'Beauty'),
                        CategoryChip(label: 'Category 6'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: 200.0,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      height: 150.0,
                      color: Color(0xffffe0b8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "MIN 15% OFF",
                            style: TextStyle(
                                fontSize: 25,
                                color: Color.fromARGB(255, 74, 30, 0)),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Color(0xffcc6522),
                            ),
                            child: Text(
                              "shop now",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      height: 150.0,
                      child: FutureBuilder<List<Product>>(
                        future: ApiService().fetchProducts(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            List<Product> products = snapshot.data!;
                            // Take the first product's image as an example
                            String productImage =
                                products.isNotEmpty ? products[0].image : '';
                            return Image.network(
                              productImage,
                              fit: BoxFit.cover,
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Color(0xfff6f6f6),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Deal of The Day",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xffffffff),
                  ),
                  child: Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(),
                        child: FutureBuilder<List<Product>>(
                          future: ApiService().fetchProducts(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            } else {
                              List<Product> products = snapshot.data!;
                              // Shuffle the list of products
                              products.shuffle();
                              // Take the first 4 products
                              List<Product> randomProducts =
                                  products.take(4).toList();
                              return SingleChildScrollView(
                                child: GridView.count(
                                  crossAxisCount: 2,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  children: randomProducts.map((product) {
                                    return _diskonCard(
                                      nama: product.title,
                                      gambar: product.image,
                                      detail: product.description,
                                      harga: product.price,
                                    );
                                  }).toList(),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(26.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Hot Selling Footwear",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Aksi yang ingin Anda lakukan saat tombol "view all" ditekan
                      },
                      child: Text("view all"),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0),
                child: FutureBuilder<List<Product>>(
                  future: ApiService().fetchProducts(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else {
                      // Shuffle the list of products
                      snapshot.data!.shuffle();

                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: snapshot.data!.map((product) {
                            return _hotselling(
                              nama: product.title,
                              gambar: product.image,
                              detail: product.description,
                              harga: product.price,
                            );
                          }).toList(),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 26, right: 26),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Recommended for you",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text("view all"),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0),
                child: FutureBuilder<List<Product>>(
                  future: ApiService().fetchProducts(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else {
                      // Shuffle the list of products
                      snapshot.data!.shuffle();

                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: snapshot.data!.map((product) {
                            return _hotselling(
                              nama: product.title,
                              gambar: product.image,
                              detail: product.description,
                              harga: product.price,
                            );
                          }).toList(),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _hotselling({
  required String nama,
  required String gambar,
  required String detail,
  required double harga,
}) {
  return GestureDetector(
    child: Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        // height: 150,
        width: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            // BoxShadow(
            //   color: Colors.grey.withOpacity(0.5),
            //   spreadRadius: 2,
            //   blurRadius: 3,
            //   offset: Offset(0, 2),
            // ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.network(
              gambar,
              width: 80.0,
              height: 80.0,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 8.0),
            // Text(
            //   "Durian",
            //   style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            // ),
            SizedBox(height: 4.0),
            Text(
              nama,
              style: TextStyle(fontSize: 12.0),
              textAlign: TextAlign.start,
            ),
            SizedBox(
              width: 150,
              child: Text(
                '\$$harga',
                style: TextStyle(fontSize: 12.0),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Widget _diskonCard({
  required String nama,
  required String gambar,
  required String detail,
  required double harga,
}) {
  return GestureDetector(
    child: Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            // BoxShadow(
            //   color: Colors.grey.withOpacity(0.5),
            //   spreadRadius: 2,
            //   blurRadius: 3,
            //   offset: Offset(0, 2),
            // ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              gambar,
              width: 80.0,
              height: 80.0,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 8.0),
            Text(
              nama,
              style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4.0),
            Container(
              padding: EdgeInsets.all(5),
              decoration: const BoxDecoration(
                color: Colors.red,
              ),
              child: Text(
                "Upto 40% Off",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class CategoryChip extends StatelessWidget {
  final String label;

  const CategoryChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Chip(
        label: Text(label),
        backgroundColor: Color(0xffef2a39),
        labelStyle: TextStyle(color: Colors.white),
      ),
    );
  }
}
