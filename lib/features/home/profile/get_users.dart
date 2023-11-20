import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:onlineshop/presentation/widgets/loading_component.dart';

import '../../../presentation/widgets/header_component.dart';

class User {
  final int id;
  final String email;
  final String username;
  final String password;
  final String firstName;
  final String lastName;
  final String city;
  final String street;
  final int number;
  final String zipcode;
  final String phone;
  final String lat;
  final String long;

  User({
    required this.id,
    required this.email,
    required this.username,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.city,
    required this.street,
    required this.number,
    required this.zipcode,
    required this.phone,
    required this.lat,
    required this.long,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      username: json['username'],
      password: json['password'],
      firstName: json['name']['firstname'],
      lastName: json['name']['lastname'],
      city: json['address']['city'],
      street: json['address']['street'],
      number: json['address']['number'],
      zipcode: json['address']['zipcode'],
      phone: json['phone'],
      lat: json['address']['geolocation']['lat'],
      long: json['address']['geolocation']['long'],
    );
  }
}

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  late Future<List<User>> users;

  @override
  void initState() {
    super.initState();
    users = fetchUsers();
  }

  Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse('https://fakestoreapi.com/users'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Column(
          children: [
            const HeaderWidget(),
            12.r.verticalSpace,
            FutureBuilder<List<User>>(
              future: users,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  List<User> userList = snapshot.data!;
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.82,
                    child: ListView.builder(
                      itemCount: userList.length,
                      itemBuilder: (context, index) {
                        User user = userList[index];
                        return ListTile(
                          title: Text('${user.firstName} ${user.lastName}'),
                          subtitle: Text('Email: ${user.email}'),
                          trailing: SizedBox(
                            width: 140.w,
                            child: Row(
                              children: [
                                const Icon(Icons.phone),
                                Text(user.phone),
                              ],
                            ),
                          ),
                          onTap: () {
                          },
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
