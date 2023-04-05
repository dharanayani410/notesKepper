import 'package:flutter/material.dart';
import 'package:notekepper/helpers/storeHelper.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GlobalKey<FormState> editKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey,
        foregroundColor: Colors.black,
        onPressed: () {
          Navigator.of(context).pushNamed('add');
        },
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: StoreHelper.storeHelper.getNotes(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("ERROR :- ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            List data = snapshot.data!.docs;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: data.length,
              itemBuilder: (context, i) {
                return Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data[i]['title']),
                        Text(
                          data[i]['des'],
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Map<Object, Object> editedValue = {
                                    'title': data[i]['title'],
                                    'des': data[i]['des']
                                  };

                                  showModalBottomSheet(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(20))),
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                            padding: EdgeInsets.all(20),
                                            height: 300,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                      top: Radius.circular(20)),
                                              color: Colors.grey,
                                            ),
                                            child: Form(
                                                key: editKey,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const Text(
                                                      "Edit Notes",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 30,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                    const SizedBox(
                                                      height: 30,
                                                    ),
                                                    TextFormField(
                                                      onSaved: (val) {
                                                        editedValue['title'] =
                                                            val as Object;
                                                      },
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                      initialValue: data[i]
                                                          ['title'],
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      decoration:
                                                          const InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              enabledBorder:
                                                                  InputBorder
                                                                      .none,
                                                              focusedBorder:
                                                                  InputBorder
                                                                      .none,
                                                              hintText:
                                                                  "Title of notes",
                                                              hintStyle: TextStyle(
                                                                  color: Colors
                                                                      .black)),
                                                    ),
                                                    TextFormField(
                                                      onSaved: (val) {
                                                        editedValue['des'] =
                                                            val as Object;
                                                      },
                                                      onFieldSubmitted: (val) {
                                                        if (editKey
                                                            .currentState!
                                                            .validate()) {
                                                          editKey.currentState!
                                                              .save();

                                                          StoreHelper
                                                              .storeHelper
                                                              .editNotes(
                                                                  id: data[i]
                                                                          ['id']
                                                                      .toString(),
                                                                  data:
                                                                      editedValue);

                                                          Navigator.pop(
                                                              context);
                                                        }
                                                      },
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                      textInputAction:
                                                          TextInputAction.done,
                                                      initialValue: data[i]
                                                          ['des'],
                                                      decoration:
                                                          const InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              enabledBorder:
                                                                  InputBorder
                                                                      .none,
                                                              focusedBorder:
                                                                  InputBorder
                                                                      .none,
                                                              hintText:
                                                                  "Typing something...",
                                                              hintStyle: TextStyle(
                                                                  color: Colors
                                                                      .black)),
                                                    )
                                                  ],
                                                )));
                                      });
                                },
                                icon: Icon(Icons.edit)),
                            IconButton(
                                onPressed: () {
                                  StoreHelper.storeHelper.deleteNotes(
                                      id: data[i]['id'].toString());
                                },
                                icon: Icon(Icons.delete)),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
