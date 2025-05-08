import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_app/AddItemPage.dart';
import 'package:my_app/ManageProductsPage.dart';

class ManageListingsPage extends StatefulWidget {
  @override
  _ManageListingsPageState createState() => _ManageListingsPageState();
}

class _ManageListingsPageState extends State<ManageListingsPage> {
  final accent = Colors.blue.shade800;
  String? adminName; // <-- make it nullable (no 'Loading...' shown)

  @override
  void initState() {
    super.initState();
    fetchAdminName();
  }

  Future<void> fetchAdminName() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (doc.exists && doc.data() != null) {
        setState(() {
          adminName = doc.data()!['name'] ?? 'Admin';
        });
      } else {
        setState(() {
          adminName = 'Admin';
        });
      }
    } else {
      setState(() {
        adminName = 'Admin';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Manage Listings', style: TextStyle(color: accent)),
        centerTitle: true,
        elevation: 1,
        iconTheme: IconThemeData(color: accent),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top Section Text
            SizedBox(height: 30),
            Text(
              adminName == null
                  ? 'Welcome 👋' // when loading, simple Welcome
                  : 'Welcome $adminName 👋', // after loaded, show name
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: accent,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              'Manage your listings and customer orders easily.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),

            // Actions Section
            Text(
              'Actions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 16),

            // Add New Item Button
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => AddItemPage()), // 👈 open AddItemPage
                );
              },
              icon: Icon(Icons.add_circle_outline, color: Colors.white),
              label: Text(
                'Add New Item',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: accent,
                padding: EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
            SizedBox(height: 20),

            // Update Listings Button
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) =>
                          ManageProductsPage()), // 👈 open AddItemPage
                );
              },
              icon: Icon(Icons.inventory, color: Colors.white),
              label: Text(
                'Update Listings',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: accent,
                padding: EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
            SizedBox(height: 20),

            // View Orders Button
            ElevatedButton.icon(
              onPressed: () {
                // Navigate to View Orders Page
              },
              icon: Icon(Icons.shopping_bag_outlined, color: Colors.white),
              label: Text(
                'View Orders',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: accent,
                padding: EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),

            Spacer(),

            // Footer small hint
            Center(
              child: Text(
                'AquaCare Management © 2025',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
