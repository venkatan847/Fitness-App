// import 'package:delivery_app_technical_test/dependency/dependency_provider.dart';
// import 'package:delivery_app_technical_test/legacy_ui/create_order_screen/create_order_screen.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'abstract_navigation_state.dart';
//
// class NavigateToCreateOrderScreen extends AbstractNavigateToState {
//   final String pickup;
//   final String dropOff;
//   final Function(dynamic result)? onPop;
//
//   NavigateToCreateOrderScreen(
//       {bool rootNavigator = true,
//       this.onPop,
//       required this.pickup,
//       required this.dropOff})
//       : super(rootNavigator: rootNavigator);
//
//   @override
//   call(context) {
//     final page = CreateOrderScreen(
//         () => DProvider.of(context)!.blocSubModule.orderBloc(),
//         pickup,
//         dropOff);
//     final route = createPageRoute(page);
//     Navigator.of(context, rootNavigator: rootNavigator)
//         .push(route)
//         .then((value) {
//       logPreviousPageName(context);
//       return onPop?.call(value);
//     });
//     logOpenedPageName(context);
//   }
//
//   @override
//   String getNavigationToScreenName() => "create_order_screen"; // DriverTipScreen
// }
