import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jb_store/Components/bottom_navbar.dart';
import 'package:jb_store/Components/drawer_widget.dart';
import 'package:jb_store/Screen/order.dart';
import 'package:jb_store/screen/all_product.dart';
import '../Models/product.dart';
import '../services/api_product.dart';
// Import bottom navigation bar

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String _selectedCategory = 'all';
  String _searchTerm = '';
  List<Product> _searchResults = [];

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

  void _onCategorySelected(String category) {
    setState(() {
      _selectedCategory = category;
      _searchResults = [];
    });
  }

  void _onSearchChanged(String value) {
    setState(() {
      _searchTerm = value;
    });

    if (_searchTerm.isNotEmpty) {
      ApiProduct().fetchProducts().then((products) {
        setState(() {
          _searchResults = products.where((product) {
            return product.title.toLowerCase().contains(_searchTerm.toLowerCase());
          }).toList();
        });
      });
    } else {
      setState(() {
        _searchResults = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Menghilangkan panah kembali
        title: Row(
          children: [
            Builder(
              builder: (context) => GestureDetector(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: Icon(
                  Icons.menu_outlined,
                  color: Colors.black,
                  size: 25.0,
                ),
              ),
            ),
            const SizedBox(width: 10),
            const Text('Home Screen'),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_outlined, color: Colors.black),
            onPressed: () {
              // Add your action here
            },
          ),
        ],
      ),
      drawer: DrawerWidget(),
      body: SingleChildScrollView(
        child: Column(
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
                onChanged: _onSearchChanged,
              ),
            ),
            if (_searchTerm.isNotEmpty) _buildSearchResultsSection(),
            if (_searchTerm.isEmpty) ...[
              _buildCategoriesSection(),
              _buildPromotionalBannerSection(),
              _buildDealOfTheDaySection(),
              _buildHotSellingSection(),
              _buildRecommendedSection(),
            ],
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildSearchResultsSection() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Search Results",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          _searchResults.isEmpty
              ? Text("No results found.")
              : GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.7,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: _searchResults.map((product) {
                    return _productCard(
                      name: product.title,
                      image: product.image,
                      detail: product.description,
                      price: product.price,
                    );
                  }).toList(),
                ),
        ],
      ),
    );
  }

  Widget _buildCategoriesSection() {
    return Container(
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
            height: 50.0,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CategoryChip(
                    label: 'All',
                    onSelected: () => _onCategorySelected('all'),
                  ),
                  CategoryChip(
                    label: 'Men\'s Clothing',
                    onSelected: () => _onCategorySelected('men\'s clothing'),
                  ),
                  CategoryChip(
                    label: 'Women\'s Clothing',
                    onSelected: () => _onCategorySelected('women\'s clothing'),
                  ),
                  CategoryChip(
                    label: 'Electronics',
                    onSelected: () => _onCategorySelected('electronics'),
                  ),
                  CategoryChip(
                    label: 'Jewelery',
                    onSelected: () => _onCategorySelected('jewelery'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPromotionalBannerSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: 200.0,
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                height: 150.0,
                color: Color.fromARGB(255, 235, 244, 246),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "MIN 15% OFF",
                      style: TextStyle(
                        fontSize: 25,
                        color: Color.fromARGB(255, 7, 25, 82),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 8, 131, 195),
                      ),
                      child: Text(
                        "Shop Now",
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
                  future: ApiProduct().fetchProducts(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      List<Product> products = snapshot.data!;
                      String productImage =
                          products.isNotEmpty ? products[0].image : '';
                      return Image.network(
                        productImage,
                        fit: BoxFit.contain,
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDealOfTheDaySection() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Color(0xfff6f6f6),
      ),
      child: Column(
        children: [
          SizedBox(height: 20),
          Text(
            "Deal of The Day",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: Color(0xffffffff),
            ),
            child: FutureBuilder<List<Product>>(
              future: ApiProduct().fetchProducts(category: _selectedCategory == 'all' ? null : _selectedCategory),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  List<Product> products = snapshot.data!;
                  products.shuffle();
                  List<Product> randomProducts = products.take(4).toList();
                  return GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.7,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: randomProducts.map((product) {
                      return _productCard(
                        name: product.title,
                        image: product.image,
                        detail: product.description,
                        price: product.price,
                      );
                    }).toList(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHotSellingSection() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Color(0xfff6f6f6),
      ),
      child: Column(
        children: [
          SizedBox(height: 20),
          Text(
            "Hot Selling",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: Color(0xffffffff),
            ),
            child: FutureBuilder<List<Product>>(
              future: ApiProduct().fetchProducts(category: _selectedCategory == 'all' ? null : _selectedCategory),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  List<Product> products = snapshot.data!;
                  products.shuffle();
                  List<Product> randomProducts = products.take(4).toList();
                  return GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.7,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: randomProducts.map((product) {
                      return _productCard(
                        name: product.title,
                        image: product.image,
                        detail: product.description,
                        price: product.price,
                      );
                    }).toList(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendedSection() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Color(0xfff6f6f6),
      ),
      child: Column(
        children: [
          SizedBox(height: 20),
          Text(
            "Recommended",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: Color(0xffffffff),
            ),
            child: FutureBuilder<List<Product>>(
              future: ApiProduct().fetchProducts(category: _selectedCategory == 'all' ? null : _selectedCategory),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  List<Product> products = snapshot.data!;
                  products.shuffle();
                  List<Product> randomProducts = products.take(4).toList();
                  return GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.7,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: randomProducts.map((product) {
                      return _productCard(
                        name: product.title,
                        image: product.image,
                        detail: product.description,
                        price: product.price,
                      );
                    }).toList(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _productCard({
    required String name,
    required String image,
    required String detail,
    required double price,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset(0, 5),
          )
        ],
      ),
      child: Column(
        children: [
          Image.network(
            image,
            fit: BoxFit.contain,
            height: 100,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "\$$price",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryChip extends StatelessWidget {
  final String label;
  final VoidCallback onSelected;

  const CategoryChip({
    Key? key,
    required this.label,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: ChoiceChip(
        label: Text(label),
        selected: false,
        onSelected: (selected) {
          if (selected) {
            onSelected();
          }
        },
      ),
    );
  }
}
