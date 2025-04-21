import 'package:flutter/material.dart';

class silver extends StatefulWidget {
  const silver({Key? key}) : super(key: key);

  @override
  State<silver> createState() => _silverState();
}

class _silverState extends State<silver> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 350.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Sliver Example',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(color: Colors.white, blurRadius: 20),
                  ],
                ),
              ),
              background: Image.asset(
                'assets/lambo.jpeg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                    title: Text('List Item ${index + 1}'),
                  ),
                ),
              ),
              childCount: 10,
            ),
          ),
        ],
      ),
    );
  }
}
