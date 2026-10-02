import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact_app/core/routes/app_routes.dart';
import 'package:contact_app/features/view/widgets/container_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Yehia Contact App',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('contacts')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.blueAccent,
                      ),
                    );
                  }

                  if (snapshot.hasError) {
                    return const Center(
                      child: Text(
                        'Something went wrong',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text(
                        'No contacts found.',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }

                  var docs = snapshot.data!.docs;

                  return ListView.separated(
                    itemBuilder: (context, index) {
                      var doc = docs[index];
                      return ContainerWidget(
                        id: doc.id,
                        personName: doc['name'] ?? '',
                        personNumber: doc['phone'] ?? '',
                        onRefresh: () {},
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 10);
                    },
                    itemCount: docs.length,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.newUser);
        },
        backgroundColor: const Color(0xFFE0E5FF),
        elevation: 0,
        icon: const Icon(Icons.add, color: Color(0xFF3F51B5)),
        label: const Text(
          "New User",
          style: TextStyle(
            color: Color(0xFF3F51B5),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
