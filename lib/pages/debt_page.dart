import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:task_manager/pages/Debt%20tabs/allahs_debt_tab.dart';
import 'package:task_manager/pages/Debt%20tabs/people_debt_tab.dart';

import '../constants.dart';

class DebtPage extends StatefulWidget {
  const DebtPage({super.key});

  @override
  State<DebtPage> createState() => _DebtPageState();
}

class _DebtPageState extends State<DebtPage> with TickerProviderStateMixin {
  TabController? tabController;
  
  List<Widget> pages = [
    AllahsDebt(),
    PeoplesDebt(),
  ];

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            controller: tabController,
            tabs: [
              Tab(
                text: DebtCateogry.allah,
              ),
              Tab(
                text: DebtCateogry.people,
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: tabController!,
              children: pages,
            ),
          ),
        ],
      ),
    );
  }
}
