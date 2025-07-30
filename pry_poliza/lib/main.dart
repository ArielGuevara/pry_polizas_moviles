import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pry_poliza/viewmodels/poliza_viewmodel.dart';
import 'package:pry_poliza/viewmodels/usuario_viewmodel.dart';
import 'package:pry_poliza/views/login_view.dart';
import 'package:pry_poliza/views/poliza_view.dart';
import 'package:pry_poliza/views/register_view.dart';
import 'package:pry_poliza/views/usuarios_view.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => PolizaViewModel()),
          ChangeNotifierProvider(create: (_) => UsuarioViewModel()),
        ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Gestión de Pólizas',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white24,
            elevation: 2,
          ),
        ),
        home: LoginView(),
        routes: {
          '/poliza': (context) => PolizaView(),
          '/users': (context) => UsuariosView(),
          '/register': (context) => RegisterView(), // Puedes cambiar esto por la vista de registro que desees
        },
      )
    )
  );
}

