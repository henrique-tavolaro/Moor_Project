import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/Theme/AppColors.dart';
import 'package:project/widgets/home_page_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Home Page'),
      // ),
      body: BodyContent(),
    );
  }
}

class BodyContent extends StatelessWidget {
  const BodyContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 54),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Welcome!',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryText),
            ),
          ),
          Container(
            height: 150,
            child: Row(
              children: [
                HomePageCard(
                  cardName: 'Orders',
                  icon: Icons.shopping_cart_rounded,
                  onTap: () {
                    Navigator.of(context).pushNamed('/orders_page');
                  },
                ),
                HomePageCard(
                  cardName: 'Dashboard',
                  icon: Icons.multiline_chart,
                  onTap: () {
                    Navigator.of(context).pushNamed('/dashboard_page');
                  },
                ),
              ],
            ),
          ),
          Container(
            height: 150,
            width: double.maxFinite,
            child: HomePageCard(
              icon: Icons.add,
              cardName: 'Register new order',
              onTap: () {
                Navigator.pushNamed(context, '/register_orders_page');
              },
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(right: 16, left: 16, top: 32, bottom: 8),
            child: Text(
              'Registration',
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 22, color: AppColors.primaryText),
            ),
          ),
          Divider(
            indent: 16,
            endIndent: 16,
            height: 1,
            thickness: 1,
          ),
          Container(
            height: 150,
            child: Row(
              children: [
                HomePageCard(
                  cardName: 'Register salesman',
                  icon: Icons.person_add,
                  onTap: () {
                    Navigator.pushNamed(context, '/insert_salesman');
                  },
                ),
                HomePageCard(
                  cardName: 'Register product',
                  icon: Icons.add_to_photos_rounded,
                  onTap: () {
                    Navigator.pushNamed(context, '/insert_product');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
