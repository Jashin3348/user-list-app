import 'package:flutter/material.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserProvider with ChangeNotifier {
  List<User> _users = [];
  List<User> _filteredUsers = [];
  bool _isLoading = true;
  String? _error;

  List<User> get users => _filteredUsers;  // Use filtered list for display
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchUsers() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _users = data.map((json) => User.fromJson(json)).toList();
        _filteredUsers = _users; // Initialize with all users
        _isLoading = false;
      } else {
        _error = 'Failed to load users';
      }
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }

  void searchUsers(String query) {
    if (query.isEmpty) {
      _filteredUsers = _users;  // Show all users if query is empty
    } else {
      _filteredUsers = _users
          .where((user) => user.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();  // Notify listeners of the change
  }
}
