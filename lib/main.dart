import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:samplepapers12/screens/homescreen.dart';
import 'package:samplepapers12/widgets/policy_dialog.dart';
import 'package:share/share.dart';

//policy : https://cbse-all-rounder.flycricket.io/privacy.html

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: Builder(
          builder: (context) => Drawer(
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 180,
                  width: double.infinity,
                  child: Center(
                    child: SizedBox(
                      height: 90,
                      width: 90,
                      child: Image.asset(
                        'assets/images/book.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                const Divider(
                  height: 25,
                  thickness: 4,
                ),
                ListTile(
                  title: const Text('Share with friends'),
                  leading: const Icon(
                    Icons.share,
                    color: Colors.pink,
                  ),
                  onTap: () {
                    Share.share(
                        'Download the CBSE All Rounder app developed by a High School student and unlock every study resource offline and that too without any ads. Click the link to download now https://play.google.com/store/apps/details?id=com.example.samplepapers12');
                  },
                ),
                ListTile(
                  title: const Text('Privacy Policy'),
                  leading: const Icon(
                    Icons.policy,
                    color: Colors.pink,
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (ctx) {
                        return const PolicyDialog(
                          mdFileName: 'privacy_policy.md',
                        );
                      },
                    );
                  },
                ),
                ListTile(
                  title: const Text('Terms and Conditions'),
                  leading: const Icon(
                    Icons.privacy_tip,
                    color: Colors.pink,
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (ctx) {
                        return const PolicyDialog(
                          mdFileName: 'terms_and_conditions.md',
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          titleSpacing: 0,
          leading: Builder(builder: (context) {
            return IconButton(
              splashRadius: 25,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.menu),
            );
          }),
          title: Text("CBSE Sample Papers"),
        ),
        body: HomeScreen(),
      ),
    );
  }
}
