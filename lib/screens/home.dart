import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:ofypets_mobile_app/utils/drawer_homescreen.dart';
import 'package:ofypets_mobile_app/utils/constants.dart';
import 'package:ofypets_mobile_app/models/product.dart';
import 'package:ofypets_mobile_app/screens/auth.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  Size _deviceSize;
  Map<dynamic, dynamic> responseBody;
  bool _isLoading = true;
  bool _isAuthenticated = false;
  List<Product> todaysDealProducts = [];
  List<String> categoryObjs = [];
  List<String> categoryImageUrls = [];
  List<Color> colorList = [
    Colors.yellow.shade300,
    Colors.blue.shade200,
    Colors.orangeAccent,
    Colors.purple.shade200,
    Colors.green.shade300
  ];

  @override
  void initState() {
    super.initState();
    getCategories();
    getTodaysDeals();
  }

  @override
  Widget build(BuildContext context) {
    _deviceSize = MediaQuery.of(context).size;
    Widget bannerCarousel = CarouselSlider(
      items: <Widget>[
        bannerCards('images/banners/slider1.jpg'),
        bannerCards('images/banners/slider2.jpg'),
        bannerCards('images/banners/slider3.jpg'),
        bannerCards('images/banners/slider4.jpg'),
        bannerCards('images/banners/slider5.jpg'),
      ],
      autoPlay: true,
    );
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'ofypets',
            style: TextStyle(fontFamily: 'HolyFat', fontSize: 50),
          ),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: _deviceSize.width * 0.01),
                child: Icon(
                  Icons.shopping_cart,
                  semanticLabel: 'Shopping Cart',
                ))
          ],
          bottom: PreferredSize(
            preferredSize: Size(_deviceSize.width, 50),
            child: Container(
              width: _deviceSize.width,
              height: 50,
              margin: EdgeInsets.all(10),
              color: Colors.white,
              child: ListTile(
                leading: Icon(Icons.search),
                title: Text(
                  'Find the best for your pet...',
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
              ),
            ),
          )),
      drawer: HomeDrawer(),
      body: CustomScrollView(slivers: [
        SliverList(
          delegate: SliverChildListDelegate([bannerCarousel]),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Container(
                width: _deviceSize.width,
                color: Colors.white,
                child: ListTile(
                  dense: true,
                  leading: Icon(
                    Icons.category,
                    color: Colors.blue,
                  ),
                  title: Text('Categories',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue)),
                ))
          ]),
        ),
        _isLoading
            ? SliverList(
                delegate: SliverChildListDelegate([
                Container(
                  height: _deviceSize.height * 0.5,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.blue,
                  ),
                )
              ]))
            : SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return categoryBox(categoryObjs[index], colorList[index],
                      categoryImageUrls[index]);
                }, childCount: categoryObjs.length),
              ),
        SliverList(
          delegate: SliverChildListDelegate([
            Container(
                width: _deviceSize.width,
                color: Colors.white,
                child: ListTile(
                  dense: true,
                  leading: Icon(
                    Icons.today,
                    color: Colors.deepOrange,
                  ),
                  title: Text('Today\'s Deals',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.deepOrange)),
                ))
          ]),
        ),
        _isLoading
            ? SliverList(
                delegate: SliverChildListDelegate([
                Container(
                  height: _deviceSize.height * 0.5,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.blue,
                  ),
                )
              ]))
            : SliverToBoxAdapter(
                child: Container(
                  height: _deviceSize.height * 0.5,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return todaysDealsCard(index);
                    },
                  ),
                ),
              ),
        SliverToBoxAdapter(
          child: Divider(),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Container(
              width: _deviceSize.width,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              color: Colors.white,
              alignment: Alignment.centerRight,
              child: Text(
                'SEE ALL',
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            )
          ]),
        ),
      ]),
      bottomNavigationBar: !_isAuthenticated
          ? BottomNavigationBar(
              onTap: (index) {
                MaterialPageRoute route = MaterialPageRoute(
                    builder: (context) => Authentication(index));

                Navigator.push(context, route);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  title: Text('SIGN IN'),
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person_outline),
                    title: Text('CREATE ACCOUNT')),
              ],
            )
          : null,
    );
  }

  Widget bannerCards(String imagePath) {
    return Container(
      width: _deviceSize.width * 0.8,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        elevation: 2,
        margin: EdgeInsets.symmetric(
            vertical: _deviceSize.height * 0.05,
            horizontal: _deviceSize.width * 0.02),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          child: Image.asset(
            imagePath,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  Widget todaysDealsCard(int index) {
    return SizedBox(
        width: _deviceSize.width * 0.4,
        child: Card(
          borderOnForeground: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Image.network(
                todaysDealProducts[index].image,
                height: _deviceSize.height * 0.2,
              ),
              Container(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: Text(
                  todaysDealProducts[index].name,
                  maxLines: 3,
                ),
              ),
              Text(
                todaysDealProducts[index].displayPrice,
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlutterRatingBar(
                    itemCount: 5,
                    allowHalfRating: true,
                    fillColor: Colors.orange,
                    borderColor: Colors.orange,
                    ignoreGestures: true,
                    initialRating: todaysDealProducts[index].avgRating,
                    onRatingUpdate: (index) {},
                    itemSize: 20,
                  ),
                  Text(todaysDealProducts[index].reviewsCount),
                ],
              ),
              Divider(),
              Text(
                'ADD TO CART',
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ));
  }

  Widget categoryBox(String categoryName, Color color, String imageUrl) {
    return Container(
        margin: EdgeInsets.all(10.0),
        color: color,
        width: _deviceSize.width * 0.4,
        child: Stack(children: [
          Container(
            alignment: Alignment.bottomRight,
            child: Image.network(
              imageUrl,
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              categoryName,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ]));
  }

  getCategories() async {
    http
        .get(Settings.SERVER_URL + 'taxonomies?q[name_cont]=Pets&set=nested')
        .then((response) {
      responseBody = json.decode(response.body);
      responseBody['taxonomies'][0]['root']['taxons'].forEach((category) {
        setState(() {
          categoryObjs.add(category['name']);
          categoryImageUrls.add(category['icon']);
        });
      });
    });
  }

  getTodaysDeals() async {
    String todaysDealsId;
    http.Response response = await http
        .get(Settings.SERVER_URL + 'taxonomies?q[name_cont]=Today\'s Deals');
    responseBody = json.decode(response.body);
    todaysDealsId = responseBody['taxonomies'][0]['id'].toString();
    http
        .get(Settings.SERVER_URL +
            'taxons/products?id=${todaysDealsId}&per_page=10&data_set=small')
        .then((response) {
      responseBody = json.decode(response.body);
      responseBody['products'].forEach((product) {
        print(product['master']['images'][0]['mini_url']);
        setState(() {
          todaysDealProducts.add(Product(
              name: product['name'],
              displayPrice: product['display_price'],
              avgRating: double.parse(product['avg_rating']),
              reviewsCount: product['reviews_count'].toString(),
              image: product['master']['images'][0]['product_url']));
        });
      });
      setState(() {
        _isLoading = false;
      });
    });
  }
}
