import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:task_manager/constants.dart';
import 'package:task_manager/pages/Task%20tabs/akhira_task_tab.dart';
import 'package:task_manager/pages/Task%20tabs/dunya_task_tab.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> with TickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      const AkhiraTaskTab(),
      const DunyaTaskTab(),
    ];
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            controller: tabController,
            tabs: [
              Tab(
                text: TaskCategory.akhira,
              ),
              Tab(
                text: TaskCategory.dunya,
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
