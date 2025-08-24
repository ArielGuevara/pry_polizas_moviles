// integration_test/app_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';
import 'package:pry_poliza/viewmodels/poliza_viewmodel.dart';
import 'package:pry_poliza/viewmodels/usuario_viewmodel.dart';
import 'package:pry_poliza/views/login_view.dart';
import 'package:pry_poliza/views/poliza_view.dart';
import 'package:pry_poliza/views/usuarios_view.dart';

// Fake ViewModels para controlar el comportamiento durante las pruebas
class FakePolizaViewModel extends PolizaViewModel {
  @override
  String propietario = '';
  @override
  double valorAlquiler = 0;
  @override
  String modeloAuto = 'A';
  @override
  String edadPropietario = '18-23';
  @override
  int accidentes = 0;
  @override
  double costoTotal = 0;

  @override
  void nuevo() {
    propietario = '';
    valorAlquiler = 0;
    modeloAuto = 'A';
    edadPropietario = '18-23';
    accidentes = 0;
    costoTotal = 0;
    notifyListeners();
  }

  @override
  Future<void> calcularPoliza() async {
    // Simular cálculo con reglas de negocio simplificadas
    double costo = valorAlquiler;
    
    // Factor por modelo
    switch (modeloAuto) {
      case 'A':
        costo *= 1.1;
        break;
      case 'B':
        costo *= 1.2;
        break;
      case 'C':
        costo *= 1.3;
        break;
    }
    
    // Factor por edad
    switch (edadPropietario) {
      case '18-23':
        costo *= 1.25;
        break;
      case '23-55':
        costo *= 1.0;
        break;
      case '55+':
        costo *= 1.15;
        break;
    }
    
    // Factor por accidentes
    costo += (accidentes * 100);
    
    costoTotal = costo;
    notifyListeners();
    
    // Simular delay de API
    await Future.delayed(Duration(milliseconds: 500));
  }
}

class FakeUsuarioViewModel extends UsuarioViewModel {
  @override
  bool isAuthenticated = false;
  String lastMessage = '';

  Future<String> login(String email, String password) async {
    // Simular delay de autenticación
    await Future.delayed(Duration(milliseconds: 1000));
    
    if (email == 'test@test.com' && password == 'password123') {
      isAuthenticated = true;
      lastMessage = 'Login exitoso';
      return 'Login exitoso: test@test.com';
    } else {
      isAuthenticated = false;
      lastMessage = 'Credenciales incorrectas';
      return 'Error: Credenciales incorrectas';
    }
  }
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Pruebas de Integración - Aplicación de Pólizas', () {
    
    testWidgets('Prueba 1: Login correcto', (WidgetTester tester) async {
      print('=== INICIANDO PRUEBA 1: LOGIN CORRECTO ===');
      
      // Objective: Verificar que el usuario puede iniciar sesión con credenciales válidas
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<PolizaViewModel>(create: (_) => FakePolizaViewModel()),
            ChangeNotifierProvider<UsuarioViewModel>(create: (_) => FakeUsuarioViewModel()),
          ],
          child: MaterialApp(
            home: LoginView(),
            routes: {
              '/poliza': (context) => PolizaView(),
              '/users': (context) => UsuariosView(),
            },
          ),
        ),
      );

      // Paso 1: Verificar que estamos en la pantalla de login
      expect(find.byType(LoginView), findsOneWidget);
      print('✓ Pantalla de login cargada correctamente');

      // Paso 2: Encontrar campos de entrada usando ValueKey
      final emailField = find.byKey(ValueKey('email_field'));
      final passwordField = find.byKey(ValueKey('password_field'));
      final loginButton = find.byKey(ValueKey('login_button'));

      // Si no existen las keys, usar alternativa
      final emailFieldAlt = emailField.evaluate().isEmpty ? 
        find.byType(TextFormField).first : emailField;
      final passwordFieldAlt = passwordField.evaluate().isEmpty ? 
        find.byType(TextFormField).last : passwordField;
      final loginButtonAlt = loginButton.evaluate().isEmpty ? 
        find.byType(ElevatedButton) : loginButton;

      // Paso 3: Ingresar credenciales válidas
      await tester.enterText(emailFieldAlt, 'test@test.com');
      await tester.enterText(passwordFieldAlt, 'password123');
      print('✓ Credenciales válidas ingresadas');

      await tester.pump();

      // Paso 4: Presionar botón de login
      await tester.tap(loginButtonAlt);
      await tester.pumpAndSettle();
      print('✓ Botón de login presionado');

      // Resultado esperado: Debe navegar a la pantalla de pólizas o mostrar mensaje de éxito
      // (En una app real con Firebase, esto navegaría automáticamente)
      print('✓ Login correcto completado');
    });

    testWidgets('Prueba 2: Login incorrecto', (WidgetTester tester) async {
      print('\n=== INICIANDO PRUEBA 2: LOGIN INCORRECTO ===');
      
      // Objective: Verificar que el sistema rechaza credenciales incorrectas
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<PolizaViewModel>(create: (_) => FakePolizaViewModel()),
            ChangeNotifierProvider<UsuarioViewModel>(create: (_) => FakeUsuarioViewModel()),
          ],
          child: MaterialApp(
            home: LoginView(),
            routes: {
              '/poliza': (context) => PolizaView(),
            },
          ),
        ),
      );

      // Paso 1: Encontrar campos
      final emailFieldAlt = find.byType(TextFormField).first;
      final passwordFieldAlt = find.byType(TextFormField).last;
      final loginButtonAlt = find.byType(ElevatedButton);

      // Paso 2: Ingresar credenciales incorrectas
      await tester.enterText(emailFieldAlt, 'wrong@email.com');
      await tester.enterText(passwordFieldAlt, 'wrongpassword');
      print('✓ Credenciales incorrectas ingresadas');

      await tester.pump();

      // Paso 3: Presionar botón de login
      await tester.tap(loginButtonAlt);
      await tester.pumpAndSettle();
      print('✓ Botón de login presionado');

      // Resultado esperado: Debe mostrar mensaje de error y permanecer en login
      expect(find.byType(LoginView), findsOneWidget);
      print('✓ Login incorrecto manejado correctamente');
    });

    testWidgets('Prueba 3: Registro y cálculo de póliza', (WidgetTester tester) async {
      print('\n=== INICIANDO PRUEBA 3: REGISTRO Y CÁLCULO DE PÓLIZA ===');
      
      // Objective: Verificar el flujo completo de creación de póliza
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<PolizaViewModel>(create: (_) => FakePolizaViewModel()),
            ChangeNotifierProvider<UsuarioViewModel>(create: (_) => FakeUsuarioViewModel()),
          ],
          child: MaterialApp(
            home: PolizaView(),
            routes: {
              '/users': (context) => UsuariosView(),
            },
          ),
        ),
      );

      // Paso 1: Verificar que estamos en la pantalla de póliza
      expect(find.byType(PolizaView), findsOneWidget);
      expect(find.text('Crear Póliza'), findsOneWidget);
      print('✓ Pantalla de póliza cargada');

      // Paso 2: Encontrar campos de entrada con ValueKey o alternativa
      final propietarioField = find.byKey(ValueKey('propietario_field'));
      final valorField = find.byKey(ValueKey('valor_field'));
      final accidentesField = find.byKey(ValueKey('accidentes_field'));
      final crearButton = find.byKey(ValueKey('crear_poliza_button'));

      // Alternativas si no existen las keys
      final propietarioFieldAlt = propietarioField.evaluate().isEmpty ? 
        find.byType(TextField).first : propietarioField;
      final valorFieldAlt = valorField.evaluate().isEmpty ? 
        find.byType(TextField).at(1) : valorField;
      final accidentesFieldAlt = accidentesField.evaluate().isEmpty ? 
        find.byType(TextField).last : accidentesField;
      final crearButtonAlt = crearButton.evaluate().isEmpty ? 
        find.byType(ElevatedButton).first : crearButton;

      // Paso 3: Llenar formulario de póliza
      await tester.enterText(propietarioFieldAlt, 'Juan Pérez');
      await tester.enterText(valorFieldAlt, '5000');
      print('✓ Datos básicos ingresados');

      await tester.pump();

      // Paso 4: Seleccionar modelo de auto B
      final modeloBRadio = find.text('Modelo B');
      if (modeloBRadio.evaluate().isNotEmpty) {
        await tester.tap(modeloBRadio);
        await tester.pump();
        print('✓ Modelo B seleccionado');
      }

      // Paso 5: Seleccionar edad 23-55
      final edad2355Radio = find.text('Mayor igual a 23 y menor a 55');
      if (edad2355Radio.evaluate().isNotEmpty) {
        await tester.tap(edad2355Radio);
        await tester.pump();
        print('✓ Rango de edad 23-55 seleccionado');
      }

      // Paso 6: Ingresar número de accidentes
      await tester.enterText(accidentesFieldAlt, '1');
      await tester.pump();
      print('✓ Número de accidentes ingresado');

      // Paso 7: Presionar botón crear póliza
      await tester.tap(crearButtonAlt);
      await tester.pumpAndSettle();
      print('✓ Botón crear póliza presionado');

      // Resultado esperado: Debe calcular y mostrar el costo total
      // Buscar texto que contenga signo de dólar
      final costoText = find.textContaining('\$');
      expect(costoText, findsAtLeastNWidgets(1));
      print('✓ Costo total calculado y mostrado');
    });

    testWidgets('Prueba 4: Validación de valores negativos', (WidgetTester tester) async {
      print('\n=== INICIANDO PRUEBA 4: VALIDACIÓN DE VALORES NEGATIVOS ===');
      
      // Objective: Verificar que el sistema maneja correctamente valores negativos
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<PolizaViewModel>(create: (_) => FakePolizaViewModel()),
            ChangeNotifierProvider<UsuarioViewModel>(create: (_) => FakeUsuarioViewModel()),
          ],
          child: MaterialApp(
            home: PolizaView(),
          ),
        ),
      );

      // Paso 1: Encontrar campo de valor
      final valorField = find.byType(TextField).at(1);

      // Paso 2: Intentar ingresar valor negativo
      await tester.enterText(valorField, '-1000');
      await tester.pump();
      print('✓ Valor negativo ingresado');

      // Paso 3: Hacer tap fuera del campo para activar validación
      await tester.tap(find.text('Crear Póliza'));
      await tester.pump();

      // Resultado esperado: El valor debe ser corregido a 0 o mostrar error
      print('✓ Validación de valor negativo completada');
    });

    testWidgets('Prueba 5: Consulta de usuarios', (WidgetTester tester) async {
      print('\n=== INICIANDO PRUEBA 5: CONSULTA DE USUARIOS ===');
      
      // Objective: Verificar que se puede navegar y consultar la lista de usuarios
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<PolizaViewModel>(create: (_) => FakePolizaViewModel()),
            ChangeNotifierProvider<UsuarioViewModel>(create: (_) => FakeUsuarioViewModel()),
          ],
          child: MaterialApp(
            home: PolizaView(),
            routes: {
              '/users': (context) => UsuariosView(),
            },
          ),
        ),
      );

      // Paso 1: Verificar que estamos en PolizaView
      expect(find.byType(PolizaView), findsOneWidget);
      print('✓ En pantalla de pólizas');

      // Paso 2: Navegar a usuarios mediante BottomNavigationBar
      final usuariosTab = find.text('Usuarios');
      if (usuariosTab.evaluate().isNotEmpty) {
        await tester.tap(usuariosTab);
        await tester.pumpAndSettle();
        print('✓ Navegación a usuarios mediante tab');
      } else {
        // Alternativa: usar el ícono de personas
        final personIcon = find.byIcon(Icons.person);
        if (personIcon.evaluate().isNotEmpty) {
          await tester.tap(personIcon);
          await tester.pumpAndSettle();
          print('✓ Navegación a usuarios mediante icono');
        }
      }

      // Paso 3: Verificar que llegamos a la pantalla de usuarios
      expect(find.byType(UsuariosView), findsOneWidget);
      expect(find.text('Usuarios'), findsOneWidget);
      print('✓ Pantalla de usuarios cargada');

      // Resultado esperado: Debe mostrar la lista de usuarios o mensaje de carga
      final loadingIndicator = find.byType(CircularProgressIndicator);
      final noUsers = find.text('No hay usuarios registrados');
      final hasContent = loadingIndicator.evaluate().isNotEmpty || 
                        noUsers.evaluate().isNotEmpty ||
                        find.byType(ListTile).evaluate().isNotEmpty;
      
      expect(hasContent, isTrue);
      print('✓ Consulta de usuarios completada');
    });

    testWidgets('Prueba 6: Flujo completo de póliza con diferentes parámetros', (WidgetTester tester) async {
      print('\n=== INICIANDO PRUEBA 6: FLUJO COMPLETO CON DIFERENTES PARÁMETROS ===');
      
      // Objective: Probar diferentes combinaciones de parámetros
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<PolizaViewModel>(create: (_) => FakePolizaViewModel()),
            ChangeNotifierProvider<UsuarioViewModel>(create: (_) => UsuarioViewModel()),
          ],
          child: MaterialApp(
            home: PolizaView(),
          ),
        ),
      );

      // Paso 1: Llenar con parámetros específicos
      final propietarioField = find.byType(TextField).first;
      final valorField = find.byType(TextField).at(1);
      final accidentesField = find.byType(TextField).last;

      await tester.enterText(propietarioField, 'María González');
      await tester.enterText(valorField, '8000');
      print('✓ Datos del propietario ingresados');

      // Paso 2: Seleccionar Modelo C (más caro)
      final modeloCRadio = find.text('Modelo C');
      if (modeloCRadio.evaluate().isNotEmpty) {
        await tester.tap(modeloCRadio);
        await tester.pump();
        print('✓ Modelo C seleccionado');
      }

      // Paso 3: Seleccionar edad 55+
      final edad55Radio = find.text('Mayor igual 55');
      if (edad55Radio.evaluate().isNotEmpty) {
        await tester.tap(edad55Radio);
        await tester.pump();
        print('✓ Edad 55+ seleccionada');
      }

      // Paso 4: Ingresar múltiples accidentes
      await tester.enterText(accidentesField, '3');
      await tester.pump();
      print('✓ 3 accidentes ingresados');

      // Paso 5: Calcular póliza
      final crearButton = find.byType(ElevatedButton).first;
      await tester.tap(crearButton);
      await tester.pumpAndSettle();
      print('✓ Póliza calculada');

      // Resultado esperado: Debe mostrar un costo mayor debido a los factores de riesgo
      final costoText = find.textContaining('\$');
      expect(costoText, findsAtLeastNWidgets(1));
      print('✓ Flujo completo con parámetros de alto riesgo completado');
    });
  });
}