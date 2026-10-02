import 'package:contact_app/core/routes/app_routes.dart';
import 'package:contact_app/features/view/widgets/container_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  // FIXED: Changed "new" to "HomeScreen"
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              child: ListView.separated(
               
                itemBuilder: (context, index) {
                  return const ContainerWidget(
                    personName: "yehia ashraf",
                    personNumber: "01001621232",
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 10);
                },
                itemCount: 9,
               
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
