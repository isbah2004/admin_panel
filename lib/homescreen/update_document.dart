import 'package:admin_panel/provider/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateDocument extends StatefulWidget {
  final String documentId;
  final String name;
  final String url;

  const UpdateDocument({
    super.key,
    required this.documentId,
    required this.name,
    required this.url,
  });

  @override
  State<UpdateDocument> createState() => _UpdateDocumentState();
}

class _UpdateDocumentState extends State<UpdateDocument> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController urlController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    urlController = TextEditingController(text: widget.url);
  }

  @override
  void dispose() {
    nameController.dispose();
    urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Update Document',
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
        child: Form(
          key: _formKey,
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
                        if (_formKey.currentState!.validate()) {
                          provider.setLoading(true);
                          FirebaseFirestore.instance
                              .collection('doc')
                              .doc(widget.documentId)
                              .update({
                            'name': nameController.text,
                            'url': urlController.text,
                          }).then((value) {provider.setLoading(false);
                            Navigator.pop(context);
                          }).catchError((error) {provider.setLoading(false);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Failed to update: $error')));
                          });
                        }
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
      ),
    );
  }
}
