

import 'package:flutter/material.dart';

class Utils{
  static  loader() {
    return const Padding(
      padding:  EdgeInsets.all(8.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }
  static noData(){
    return const Center(
      child: Text("No Data"),
    );
  }
}