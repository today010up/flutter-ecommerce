import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'ofypets',
                style: TextStyle(
                    fontFamily: 'HolyFat', fontSize: 65, color: Colors.white),
              ),
              Text(
                '1.0.0',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
              ),
              Expanded(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  GestureDetector(
                    child: Text(
                      'Sign in',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w300),
                    ),
                    onTap: () {
                      print("Sign in");
                    },
                  ),
                  Text('|',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w300)),
                  GestureDetector(
                    child: Text('Create Account',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w300)),
                    onTap: () {
                      print('Create Account');
                    },
                  )
                ],
              ))
            ]),
            decoration: BoxDecoration(color: Colors.green),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Colors.green,
            ),
            title: Text(
              'Home',
              style: TextStyle(color: Colors.green),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.favorite,
              color: Colors.green,
            ),
            title: Text(
              'Favorites',
              style: TextStyle(color: Colors.green),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.receipt,
              color: Colors.green,
            ),
            title: Text(
              'Buy Again',
              style: TextStyle(color: Colors.green),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.person,
              color: Colors.green,
            ),
            title: Text(
              'Account',
              style: TextStyle(color: Colors.green),
            ),
          ),
          Divider(),
          ListTile(
            title: Text(
              '24/7 Help',
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.call,
            ),
            title: Text(
              'Call: 1-111-111-1111',
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.mail,
            ),
            title: Text(
              'Email: abc@ofypets.com',
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.share,
            ),
            title: Text(
              'Share the App',
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.alternate_email,
            ),
            title: Text(
              'App Feedback',
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.assignment,
            ),
            title: Text(
              'Privacy Policy',
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.assignment,
            ),
            title: Text(
              'Terms and Policies',
            ),
          ),
        ],
      ),
    );
  }
}
