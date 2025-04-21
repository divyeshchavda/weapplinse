import 'package:flutter/material.dart';

import '../Week 3/api.dart';


class PaginationDemo extends StatefulWidget {
  @override
  _PaginationDemoState createState() => _PaginationDemoState();
}

class _PaginationDemoState extends State<PaginationDemo> {
  List<dynamic> users = [];
  int page = 1;
  final int limit = 5;
  bool isLoading = false;
  bool hasMore = true;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchUsers();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && hasMore) {
        fetchUsers();
      }
    });
  }

  Future<void> fetchUsers() async {
    if (isLoading) return;
    setState(() => isLoading = true);

    try {
      List<dynamic> newUsers = await api.fetch2(page: page, limit: limit);
      setState(() {
        if (newUsers.length < limit) hasMore = false;
        users.addAll(newUsers);
        page++;
      });
    } catch (e) {
      print('Error fetching users: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pagination Demo")),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: users.length + (hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == users.length) {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Colors.grey.shade200,
              elevation: 10,
              child: ListTile(
                title: Text(users[index]['name']),
                subtitle: Text(users[index]['email']),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}