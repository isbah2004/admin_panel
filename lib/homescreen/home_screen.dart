// import 'package:admin_panel/Utils/utils.dart';
// import 'package:admin_panel/homescreen/add_document.dart';
// import 'package:admin_panel/homescreen/update_document.dart';
// import 'package:admin_panel/theme/theme_data.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final fireStore = FirebaseFirestore.instance.collection('doc').snapshots();
//   CollectionReference urlRef = FirebaseFirestore.instance.collection('doc');

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: AppTheme.hintColor,
//         title: Text(
//           'Homescreen',
//           style: Theme.of(context).textTheme.headlineMedium,
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.refresh),
//             onPressed: () {
//               setState(() {});
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           StreamBuilder<QuerySnapshot>(
//             stream: fireStore,
//             builder:
//                 (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//               if (snapshot.hasError) {
//                 return const Center(
//                   child: Text('Something went wrong'),
//                 );
//               } else if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Padding(
//                   padding: EdgeInsets.only(
//                       top: MediaQuery.of(context).size.height / 3),
//                   child: const Center(
//                     child: Text('Loading'),
//                   ),
//                 );
//               } else if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
//                 return Padding(
//                   padding: EdgeInsets.only(
//                       top: MediaQuery.of(context).size.height / 3),
//                   child: const Center(child: Text('No data available')),
//                 );
//               }

//               return Expanded(
//                 child: ListView(
//                   children:
//                       snapshot.data!.docs.map((DocumentSnapshot document) {
//                     Map<String, dynamic> data =
//                         document.data()! as Map<String, dynamic>;

//                     return Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: GestureDetector(
//                         onTap: () {
//                           Utils.urlLauncher(data['url']);
//                         },
//                         child: Container(
//                           padding: const EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(12),
//                             color: Colors.orange[100],
//                           ),
//                           alignment: Alignment.center,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 data['name'],
//                                 style: const TextStyle(fontSize: 20),
//                               ),
//                               PopupMenuButton(
//                                 color: Colors.white,
//                                 elevation: 4,
//                                 padding: EdgeInsets.zero,
//                                 shape: const RoundedRectangleBorder(
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(2)),
//                                 ),
//                                 icon: const Icon(Icons.more_vert),
//                                 itemBuilder: (context) => [
//                                   PopupMenuItem(
//                                     value: 1,
//                                     child: ListTile(
//                                       onTap: () {
//                                         Navigator.pop(context);
//                                         Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                             builder: (context) =>
//                                                 UpdateDocument(
//                                               documentId: document.id,
//                                               name: data['name'],
//                                               url: data['url'],
//                                             ),
//                                           ),
//                                         );
//                                       },
//                                       leading: const Icon(Icons.edit),
//                                       title: const Text('Edit'),
//                                     ),
//                                   ),
//                                   PopupMenuItem(
//                                     value: 2,
//                                     child: ListTile(
//                                       onTap: () {
//                                         Navigator.pop(context);
//                                         urlRef
//                                             .doc(document.id)
//                                             .delete()
//                                             .then((value) {})
//                                             .catchError((error) {});
//                                       },
//                                       leading: const Icon(Icons.delete_outline),
//                                       title: const Text('Delete'),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               );
//             },
//           )
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.orange,
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => const AddDocument()),
//           );
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

import 'package:admin_panel/Utils/utils.dart';
import 'package:admin_panel/homescreen/add_document.dart';
import 'package:admin_panel/homescreen/update_document.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final fireStore = FirebaseFirestore.instance.collection('doc').snapshots();
  CollectionReference urlRef = FirebaseFirestore.instance.collection('doc');

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didpop) {
        SystemNavigator.pop();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Documents',
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
          actions: [
            IconButton(
              icon: const Icon(
                Icons.refresh,
                color: Colors.black,
              ),
              onPressed: () {
                setState(() {});
              },
            ),
          ],
          elevation: 10, // Adds shadow to AppBar
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(16),
            ),
          ),
        ),
        body: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: fireStore,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      'Something went wrong',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.redAccent,
                      ),
                    ),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 3),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xffffa726), // Bright orange color
                      ),
                    ),
                  );
                } else if (snapshot.data == null ||
                    snapshot.data!.docs.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 3),
                    child: const Center(
                      child: Text(
                        'No data available',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  );
                }

                return Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16.0),
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            Utils.urlLauncher(data['url']);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    data['name'],
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                PopupMenuButton(
                                  color: Colors.white,
                                  elevation: 4,
                                  padding: EdgeInsets.zero,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(2)),
                                  ),
                                  icon: const Icon(Icons.more_vert),
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      value: 1,
                                      child: ListTile(
                                        onTap: () {
                                          Navigator.pop(context);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  UpdateDocument(
                                                documentId: document.id,
                                                name: data['name'],
                                                url: data['url'],
                                              ),
                                            ),
                                          );
                                        },
                                        leading: const Icon(Icons.edit),
                                        title: const Text('Edit'),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: 2,
                                      child: ListTile(
                                        onTap: () {
                                          Navigator.pop(context);
                                          urlRef
                                              .doc(document.id)
                                              .delete()
                                              .then((value) {})
                                              .catchError((error) {});
                                        },
                                        leading:
                                            const Icon(Icons.delete_outline),
                                        title: const Text('Delete'),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xffffa726),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddDocument()));
          },
          child: const Icon(
            Icons.add,
            color: Colors.black,
          ),
        ),
        backgroundColor: const Color(0xFFF5F5F5), // Light grey background
      ),
    );
  }
}
