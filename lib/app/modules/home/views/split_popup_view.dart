import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:split_payment/app/modules/home/controllers/split_popup_controller.dart';
import 'package:split_payment/app/modules/home/models/payment_split.dart';

class SplitPopupView extends StatelessWidget {
  const SplitPopupView({required this.totalNominal, super.key});
  final double totalNominal;
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SplitPopupController(totalNominal),
      builder: (controller) {
        return _buildView(context, controller);
      },
    );
  }

  Widget _buildView(BuildContext context, SplitPopupController controller) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: controller.onSaveButtonClick,
                child: const Text('SAVE'),
              )),
          Text("Total $totalNominal",
              style: const TextStyle(fontWeight: FontWeight.bold)),
          Obx(() => Text("Sisa: ${controller.sisaObs.value.toString()}")),
          const SizedBox(height: 24),
          Obx(() {
            final dataList = controller.splitListObs;
            return ListView.builder(
              shrinkWrap: true,
              itemCount: dataList.length,
              itemBuilder: (context, index) {
                final data = dataList[index];
                return _buildItemSplit(context, controller, data);
              },
            );
          }),
          Center(
            child: ElevatedButton(
              onPressed: controller.onAddSplitButtonClick,
              child: const Text('ADD SPLIT'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemSplit(
    BuildContext context,
    SplitPopupController controller,
    PaymentSplit data,
  ) {
    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(data.paymentType.name),
              TextFormField(
                controller: data.textEditingController,
                onChanged: (s) => controller.onNominalSplitChanged(data, s),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
        IconButton(
            onPressed: () => controller.onItemDelete(data),
            icon: const Icon(Icons.delete))
      ],
    );
  }
}
