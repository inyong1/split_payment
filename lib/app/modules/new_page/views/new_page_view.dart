import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/new_page_controller.dart';

class NewPageView extends GetView<NewPageController> {
  const NewPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NewPageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'NewPageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
