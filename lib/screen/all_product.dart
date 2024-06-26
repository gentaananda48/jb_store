import 'package:flutter/material.dart';
import 'package:jb_store/Components/bottom_navbar.dart';
import 'package:jb_store/Components/drawer_widget.dart';
import 'package:jb_store/Screen/order.dart';
import 'package:jb_store/models/product.dart';
import 'package:jb_store/services/api_services.dart';
import 'package:jb_store/screen/detail_screen.dart';

class AllProductsScreen extends StatefulWidget {
  @override
  _AllProductsScreenState createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home');
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AllProductsScreen()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OrderScreen()),
        );
        break;
      case 3:
        Navigator.pushNamed(context, '/profile');
        break;
    }
  }

  final ApiService apiService = ApiService();
  List<Product> products = [];
  List<Product> cart = [];
  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts({String? category}) async {
    try {
      final fetchedProducts =
          await apiService.fetchProducts(category: category);
      setState(() {
        products = fetchedProducts;
      });
    } catch (e) {
      print('Failed to fetch products: $e');
    }
  }

  void showCategoryFilter() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.zero),
      ),
      builder: (BuildContext context) {
        final categories = [
          'All',
          'Men\'s Clothing',
          'Women\'s Clothing',
          'Electronics',
          'Jewelery'
        ];
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close_rounded)),
                  Text(
                    'Product Categories',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Divider(),
            ...categories.map((category) {
              return ListTile(
                title: Text(category),
                onTap: () {
                  setState(() {
                    selectedCategory =
                        category == 'All' ? null : category.toLowerCase();
                    fetchProducts(category: selectedCategory);
                  });
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ],
        );
      },
    );
  }

  Widget buildCategoryButtons() {
    final categories = [
      'All',
      'Men\'s Clothing',
      'Women\'s Clothing',
      'Electronics',
      'Jewelery'
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: categories.map((category) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedCategory =
                      category == 'All' ? null : category.toLowerCase();
                  fetchProducts(category: selectedCategory);
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: selectedCategory == category.toLowerCase()
                    ? Colors.blue
                    : Colors.white,
                foregroundColor: selectedCategory == category.toLowerCase()
                    ? Colors.white
                    : Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text(category),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Products'),
      ),
      drawer: DrawerWidget(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: buildCategoryButtons(),
                ),
                IconButton(
                  icon: Icon(Icons.filter_list),
                  onPressed: showCategoryFilter,
                ),
              ],
            ),
          ),
          Expanded(
            child: products.isEmpty
                ? Center(child: CircularProgressIndicator())
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailScreen(product: product, cart: cart),
                            ),
                          );
                        },
                        child: Card(
                          surfaceTintColor: Colors.white,
                          elevation: 5.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                product.image,
                                fit: BoxFit.contain,
                                height: 150,
                                width: double.infinity,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  product.title,
                                  style: TextStyle(fontSize: 16),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  '\$${product.price}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
