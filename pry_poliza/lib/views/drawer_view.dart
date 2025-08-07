import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pry_poliza/viewmodels/drawer_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DrawerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<DrawerViewModel>(context);
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Colors.blue, Colors.deepPurpleAccent])
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.add, size: 50, color: Colors.white),
                      Text("Polizas", style: TextStyle(fontSize: 22, color: Colors.white),),
                      Text("Universidad de las Fuerzas Armadas ESPE", style: TextStyle(fontSize: 10, color: Colors.white70),),
                    ],
                  ),
                ),
                ListTile(
                  selected: vm.selected == 'Home',
                  selectedTileColor: Colors.orange.shade200,
                  leading: Icon(Icons.home, color: Colors.blue),
                  title: Text('Home', style: TextStyle(color: Colors.deepPurple)),
                  onTap: () {
                    vm.selct('Home');
                    Navigator.pop(context);
                  },
                ),
                Divider(),
              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app, color: Colors.red),
            title: Text('Cerrar sesión', style: TextStyle(color: Colors.red)),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
