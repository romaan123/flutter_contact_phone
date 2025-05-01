import 'package:flutter/material.dart';

void main() {
  runApp(const PeopleApp());
}

class PeopleApp extends StatelessWidget {
  const PeopleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'People Directory',
      debugShowCheckedModeBanner: false,
      home: const PeopleListScreen(),
    );
  }
}

class Person {
  final String name;
  final String phone;
  final String email;
  final String imagePath;

  Person({
    required this.name,
    required this.phone,
    required this.email,
    required this.imagePath,
  });
}

final List<Person> people = [
  Person(
    name: 'My friend',
    phone: '123-456-7890',
    email: 'alice@example.com',
    imagePath: 'man1.jpg',
  ),
  Person(
    name: 'Tom and Jerry',
    phone: '987-654-3210',
    email: 'bob@example.com',
    imagePath: 'man2.jpg',
  ),
  Person(
    name: 'Charlie Chaplin',
    phone: '555-123-4567',
    email: 'charlie@example.com',
    imagePath: 'man3.jpg',
  ),
];

class PeopleListScreen extends StatelessWidget {
  const PeopleListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('People Directory')),
      body: ListView.builder(
        itemCount: people.length,
        itemBuilder: (context, index) {
          final person = people[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(person.imagePath),
            ),
            title: Text(person.name),
            subtitle: Text(person.phone),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PersonDetailScreen(person: person),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class PersonDetailScreen extends StatelessWidget {
  final Person person;

  const PersonDetailScreen({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(person.name)),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage(person.imagePath),
            ),
            const SizedBox(height: 20),
            Text('Phone: ${person.phone}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Email: ${person.email}', style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
