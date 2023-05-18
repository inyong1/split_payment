import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const Text(
              'HomeView is working',
              style: TextStyle(fontSize: 20),
            ),
            TextField(
              controller: controller.totalTextController,
              decoration:
                  const InputDecoration(hintText: "Input total invoice"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: controller.onSplitPayementButtonClick,
              child: const Text("SPLIT PAYMENT"),
            ),
            Expanded(child: Obx(_buildSplitList)),
          ],
        ),
      ),
    );
  }

  Widget _buildSplitList() {
    final dataList = controller.paymentSplitListObs;
    return ListView.separated(
      itemCount: dataList.length,
      itemBuilder: (context, index) {
        final data = dataList[index];
        return ListTile(
          title: Text(data.nominal.toString()),
          subtitle: Text(data.paymentType.name),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
    );
  }
}
