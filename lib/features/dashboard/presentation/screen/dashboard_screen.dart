import 'package:demo_videocalling/features/dashboard/presentation/widgets/dashboard_body.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _AppBarCustom(),
      body: DashboardBody(),
    );
  }
}

class _AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  const _AppBarCustom({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Text(
        'CONTACTS',
        style: TextStyle(
          color: Colors.purple,
          fontWeight: FontWeight.bold,
          letterSpacing: 2.5,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, kToolbarHeight);
}
