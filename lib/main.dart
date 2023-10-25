import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'flutter_mvvm_architecture/resources/utils/go_router.dart';
import 'flutter_mvvm_architecture/view_model/auth_viewmodel.dart';
import 'flutter_mvvm_architecture/view_model/user_view_model.dart';

///MvVM
void main() {
  runApp(const MyAppMvvm());
}

class MyAppMvvm extends StatelessWidget {
  const MyAppMvvm({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        routerConfig: RouterHelper.router,
      ),
    );
  }
}
