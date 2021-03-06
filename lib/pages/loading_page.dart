import 'package:leafety/pages/onBoarding_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:leafety/services/socket_service.dart';
import 'package:leafety/services/auth_service.dart';

import 'package:leafety/pages/principal_page.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (context, snapshot) {
          return Center(
            child: _buildLoadingWidget(context),
          );
        },
      ),
    );
  }

  Widget _buildLoadingWidget(context) {
    return Container(
        height: 400.0, child: Center(child: CircularProgressIndicator()));
  }

  Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final socketService = Provider.of<SocketService>(context, listen: false);

    final autenticado = await authService.isLoggedIn();

    if (autenticado) {
      Navigator.of(context).pushAndRemoveUntil(
          _createRutePrincipal(), (Route<dynamic> route) => false);

      socketService.connect();
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          _createRuteOnBoarding(), (Route<dynamic> route) => false);
    }
  }
}

Route _createRutePrincipal() {
  return PageRouteBuilder(
    transitionDuration: Duration(milliseconds: 1000),
    pageBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      return PrincipalPage();
    },
    transitionsBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child) {
      return Align(
        child: FadeTransition(
          opacity: animation,
          child: child,
        ),
      );
    },
  );
}

Route _createRuteOnBoarding() {
  return PageRouteBuilder(
    transitionDuration: Duration(milliseconds: 600),
    pageBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      return OnBoardingScreen();
    },
    transitionsBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child) {
      return Align(
        child: FadeTransition(
          opacity: animation,
          child: child,
        ),
      );
    },
  );
}
