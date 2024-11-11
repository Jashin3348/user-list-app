import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<UserProvider>(context, listen: false).fetchUsers());
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title:const Text('User List',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration:const InputDecoration(
                labelText: 'Search by name',
                border: OutlineInputBorder(),
              ),
              onChanged: userProvider.searchUsers,
            ),
          ),
          Expanded(
            child: userProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : userProvider.error != null
                    ? Center(child: Text('Error: ${userProvider.error}'))
                    : RefreshIndicator(
                        onRefresh: userProvider.fetchUsers,
                        child: ListView.builder(
                          itemCount: userProvider.users.length,
                          itemBuilder: (context, index) {
                            final user = userProvider.users[index];
                            return ListTile(
                              leading:const CircleAvatar(
                                backgroundImage: NetworkImage('https://cdn-icons-png.flaticon.com/512/8847/8847419.png'),
                              ),
                              title: Text(user.name),
                              subtitle: Text(user.email),
                            );
                          },
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}
