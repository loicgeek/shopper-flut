
import 'package:flutter/material.dart';
import 'package:shopapp_flut/bloc_helpers/bloc_provider.dart';
import 'package:shopapp_flut/bloc_widgets/bloc_state_builder.dart';
import 'package:shopapp_flut/blocs/authentication/authentication_bloc.dart';
import 'package:shopapp_flut/blocs/authentication/authentication_state.dart';
import 'package:shopapp_flut/pages/home_page.dart';

import 'login_page.dart';

class DecisionPage extends StatefulWidget {
  @override
  DecisionPageState createState() {
    return new DecisionPageState();
  }
}

class DecisionPageState extends State<DecisionPage> {
  AuthenticationState oldAuthenticationState;

  @override
  Widget build(BuildContext context) {
    AuthenticationBloc bloc = BlocProvider.of<AuthenticationBloc>(context);
    return BlocEventStateBuilder<AuthenticationState>(
      bloc: bloc,
      builder: (BuildContext context, AuthenticationState state) {
        print("dec-failed?: ${state.hasFailed}");
        print("dec-authenticated?: ${state.isAuthenticated}");
        print("dec-authenticating?: ${state.isAuthenticating}");
        if (state != oldAuthenticationState){
          oldAuthenticationState = state;

          if (state.isAuthenticated){
            _redirectToPage(context, HomePage());
          } else if (state.isAuthenticating || state.hasFailed){
  //do nothing
          } else {
            _redirectToPage(context, LoginPage());
          }
        }

        // This page does not need to display anything since it will
        // always remain behind any active page (and thus 'hidden').
        return Container();
      }
    );
  }

  void _redirectToPage(BuildContext context, Widget page){
    WidgetsBinding.instance.addPostFrameCallback((_){
      MaterialPageRoute newRoute = MaterialPageRoute(
          builder: (BuildContext context) => page
        );

      Navigator.of(context).pushAndRemoveUntil(newRoute, ModalRoute.withName('/decision'));
    });
   
  }
}