import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/constants/fonts/font_decerations.dart';

class ScreenCostamize extends StatelessWidget {
  const ScreenCostamize({super.key, required this.isEdit});
  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              CupertinoIcons.back,
              color: Colors.white,
            )),
        title: Text(
          isEdit ? 'Edit' : 'Add',
          style: textHeadings,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextFormField(
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                  hintText: 'Title', hintStyle: textDescriptions),
            ),
            const SizedBox(height: 50),
            TextFormField(
              style: const TextStyle(color: Colors.white),
              maxLines: 10,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Description...',
                  hintStyle: textDescriptions),
            ),
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple[900],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: const Icon(
          Icons.check,
          color: Colors.white,
        ),
      ),
    );
  }
}
