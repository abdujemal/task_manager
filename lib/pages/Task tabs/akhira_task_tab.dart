import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/helper/database_helper.dart';
import 'package:task_manager/my_controller.dart';
import 'package:task_manager/widgets/sl_input.dart';
import 'package:task_manager/widgets/task_item.dart';

class AkhiraTaskTab extends StatefulWidget {
  const AkhiraTaskTab({super.key});

  @override
  State<AkhiraTaskTab> createState() => _AkhiraTaskTabState();
}

class _AkhiraTaskTabState extends State<AkhiraTaskTab> {
  MyController myController = Get.find<MyController>();
  double myDebt = 0;
  double payedDebt = 0;
  double myTotalDebt = 0;
  String paymentHistory = "";

  @override
  void initState() {
    super.initState();
    getDebts();
  }

  getDebts() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    payedDebt = pref.getDouble("payed amount") ?? 0;
    paymentHistory = pref.getString("history") ?? "";
    myTotalDebt = await DatabaseHelper().getPanishment();
    myDebt = myTotalDebt - payedDebt;
    if (myDebt < 0) {
      myDebt = 0;
    }
    setState(() {});
  }

  showRecordPayment(String history, double payedAmount) {
    Get.bottomSheet(Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 58, 58, 58),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          const Center(
            child: Text(
              "Pay the debt",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          SLInput(
            title: "Amount",
            hint: "2000",
            keyboardType: TextInputType.number,
            onSumbited: (val) {
              if (val.isNotEmpty) {
                SharedPreferences.getInstance().then((pref) {
                  pref.setDouble(
                      "payed amount", payedAmount + (int.parse(val) / 30));
                  pref.setString("history",
                      "$history,${DateFormat("EEE MMM dd yyyy").format(DateTime.now())} ==> ${val} ETB");
                  getDebts();
                  Get.back();
                });
              }
            },
            isOutlined: true,
            inputColor: Colors.white,
            otherColor: Colors.grey,
          ),
        ],
      ),
    ));
  }

  showPaymentHistory(String history) {
    List<String> myHistory =
        history.split(",").where((e) => e.contains("==>")).toList();
    print(myHistory);
    Get.bottomSheet(Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 58, 58, 58),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          const Center(
            child: Text(
              "Payment History",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          myHistory.isEmpty
              ? const Center(
                  child: Text("No history"),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: myHistory.length,
                    itemBuilder: (context, index) {
                      String date = myHistory[index].split("==>")[0];
                      String amount = myHistory[index].split("==>")[1];
                      return Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.white.withAlpha(120),
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(date),
                              Text(
                                amount,
                                style: const TextStyle(
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white.withAlpha(30),
            ),
            child: Stack(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.monetization_on_outlined,
                      size: 75,
                      color: Colors.grey.shade400,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.center,
                              child: Text(
                                "My Debts",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.red,
                                      ),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Center(
                                          child: Text(
                                            "${(myDebt * 30).round()} ETB",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                            ),
                                          ),
                                        ),
                                        const Text("UnPayed"),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.green,
                                      ),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Center(
                                          child: Text(
                                            "${(payedDebt * 30).round()} ETB",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                            ),
                                          ),
                                        ),
                                        const Text("Payed"),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.green,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Center(
                                    child: Text(
                                      "${((myTotalDebt < 0 ? 0.0 : myTotalDebt) * 30).round()} ETB",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                  const Text("Total"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    onPressed: () {
                      getDebts();
                    },
                    icon: const Icon(Icons.refresh),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showRecordPayment(paymentHistory, payedDebt);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.add),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showPaymentHistory(paymentHistory);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.history),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: myController.akhiraTasks.length,
              itemBuilder: (context, index) => TaskItem(
                index: index,
                taskModel: myController.akhiraTasks[index],
              ),
            ),
          ),
        ],
      );
    });
  }
}
