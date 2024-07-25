import 'package:admin_panel/provider/auth_provider.dart';
import 'package:admin_panel/theme/theme_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddDocument extends StatefulWidget {
  const AddDocument({super.key});

  @override
  State<AddDocument> createState() => _AddDocumentState();
}

class _AddDocumentState extends State<AddDocument> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController urlController = TextEditingController();
  final addDoc = FirebaseFirestore.instance;

  @override
  void dispose() {
    nameController.dispose();
    urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.whiteColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Add Document',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xfffb8c00), Color(0xffffa726)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),

        elevation: 10, // Adds shadow to AppBar
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 30),
            TextFormField(
              keyboardType: TextInputType.name,
              controller: nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter the name';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Name',
                filled: true,
                fillColor: const Color(0xFFE0E0E0).withOpacity(0.8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Name',
                hintStyle: const TextStyle(color: Colors.black54),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.url,
              controller: urlController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please the Url';
                }
                return null;
              },
              decoration: InputDecoration(
                filled: true,
                labelText: 'Url',
                fillColor: const Color(0xFFE0E0E0).withOpacity(0.8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Url',
                hintStyle: const TextStyle(color: Colors.black54),
              ),
            ),
            const SizedBox(height: 40),
                 Consumer<PhoneProvider>(
                builder:
                    (BuildContext context, PhoneProvider provider, Widget? child) {
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xffffa726), // Bright orange color
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {

                          provider.setLoading(true);
                         
                addDoc.collection('doc').add({
                  'name': nameController.text.toString(),
                  'url': urlController.text.toString(),
                }).then((value) {
                  Navigator.pop(context);
                }).onError((error, stackTrace) {});
                        
                      },
                      child: provider.isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              'Update',
                              style: TextStyle(
                                color: Color(0xffffffff), // White color
                                fontSize: 18,
                              ),
                            ),
                    ),
                  );
                },
              ),
       
          ],
        ),
      ),
    );
  }
}
