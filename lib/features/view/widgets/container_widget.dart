import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact_app/features/view/screens/new_user_screen.dart';
import 'package:flutter/material.dart';



class ContainerWidget extends StatelessWidget {
  const ContainerWidget({
    super.key,
    required this.id,
    required this.personName,
    required this.personNumber,
    required this.onRefresh,
  });

  final String id;
  final String personName;
  final String personNumber;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewUserScreen(
                  contactId: id,
                  existingName: personName,
                  existingPhone: personNumber,
                ),
              ),
            ).then((value) {
              onRefresh();
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(width: 12),
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.grey[200],
                  child: Icon(Icons.person, color: Colors.grey[600]),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        personName,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        personNumber,
                        style: TextStyle(color: Colors.grey[600], fontSize: 13),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  color: Colors.red,
                  iconSize: 22,
                  hoverColor: Colors.red.withOpacity(0.1),
                  splashColor: Colors.red.withOpacity(0.2),
                  highlightColor: Colors.red.withOpacity(0.1),
                  onPressed: () async {
                    await FirebaseFirestore.instance
                        .collection('contacts')
                        .doc(id)
                        .delete();
                    onRefresh();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.call_outlined),
                  color: Colors.green,
                  iconSize: 22,
                  hoverColor: Colors.green.withOpacity(0.1),
                  splashColor: Colors.green.withOpacity(0.2),
                  highlightColor: Colors.green.withOpacity(0.1),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
