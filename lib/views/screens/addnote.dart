import 'package:flutter/material.dart';
import 'package:notekepper/helpers/storeHelper.dart';

class Add extends StatefulWidget {
  const Add({Key? key}) : super(key: key);

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  GlobalKey<FormState> addKey = GlobalKey();

  String? title;
  String? des;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
              padding: const EdgeInsets.all(20),
              alignment: Alignment.center,
              height: double.infinity,
              width: double.infinity,
              color: Colors.black,
              child: Form(
                key: addKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Create Notes",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      onSaved: (val) {
                        title = val!;
                      },
                      style: const TextStyle(color: Colors.white),
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: "Title of notes",
                          hintStyle: TextStyle(color: Colors.white)),
                    ),
                    TextFormField(
                      onFieldSubmitted: (val) async {
                        addKey.currentState!.save();
                        await StoreHelper.storeHelper
                            .addNotes(title: title!, des: des!);

                        Navigator.of(context).pop();
                        print("ID dhara");
                        setState(() {
                          title = null;
                          des = null;
                        });
                      },
                      onSaved: (val) {
                        des = val!;
                      },
                      style: const TextStyle(color: Colors.white),
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: "Typing something...",
                          hintStyle: TextStyle(color: Colors.white)),
                    )
                  ],
                ),
              ))),
    );
  }
}
