import 'package:flutter/material.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
          onTap: () => print("EGE"), child: Text('Discover Page')),
    );
  }
}
