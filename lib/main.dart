import 'package:flutter/material.dart';
import 'package:flutter_localization/provider_localization.dart';
import 'package:flutter_localization/ui/account_screen.dart';
import 'package:flutter_localization/ui/home_screen.dart';
import 'package:flutter_localization/ui/setting_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'locale/my_localization.dart';
import 'locale/my_localization_delegate.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProviderLocalization(),
      child: Consumer<ProviderLocalization>(
        builder: (context, localization, child){
          return MaterialApp(
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              MyLocalizationDelegate(localization.language),
            ],
            supportedLocales: [
              Locale('en', 'US'),
              Locale('id', 'ID'),
            ],
            home: MyApp(),
          );
        },
      )
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int indexSelected = 0;

  @override
  Widget build(BuildContext context) {
    final providerLocalization = Provider.of<ProviderLocalization>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Localization'),
      ),
      body: _buildWidgetBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indexSelected,
        onTap: (indexSelected) {
          setState(() {
            this.indexSelected = indexSelected;
          });
        },
        items: [
          BottomNavigationBarItem(
            title: Text(MyLocalization.of(context).home),
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            title: Text(MyLocalization.of(context).account),
            icon: Icon(Icons.account_circle),
          ),
          BottomNavigationBarItem(
            title: Text(MyLocalization.of(context).setting),
            icon: Icon(Icons.settings),
          ),
        ],
      ),
    );
  }

  Widget _buildWidgetBody() {
    switch (indexSelected) {
      case 0:
        return HomeScreen();
      case 1:
        return AccountScreen();
      case 2:
        return SettingScreen();
      default:
        return Container();
    }
  }
}