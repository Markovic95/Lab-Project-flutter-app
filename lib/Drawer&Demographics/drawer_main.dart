import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  final BuildContext context;
  const MainDrawer({super.key, required this.context});
  Widget buildListTile(String title, IconData icon, String path1) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () {
        String path = path1;
        redir(path);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 130,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Colors.indigo, //χρωμα του header του drawer
            // decoration:BoxDecoration(color:Colors.blue), διαφορετικος τροπος να περασουμε χρωμα
            child: Text(
              "Menu",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
              ),
            ),
          ),
          buildListTile("User-info", Icons.people, '/demogra'),
        ],
      ),
    );
  }

  void redir(String go) {
    Navigator.of(context).pushNamed(go);
  }
}
