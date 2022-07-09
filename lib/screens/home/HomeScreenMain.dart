import 'package:e_commerce/screens/home/HomeScreenBody.dart';
import 'package:e_commerce/screens/home/HomeScreenHeader.dart';

import 'package:flutter/material.dart';


class HomeScreenMain extends StatefulWidget {
  const HomeScreenMain({Key? key}) : super(key: key);

  @override
  State<HomeScreenMain> createState() => _HomeScreenMainState();
}

class _HomeScreenMainState extends State<HomeScreenMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HomeScreenHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: HomeScreenBody())),
        ],
      ),
    );
  }
}