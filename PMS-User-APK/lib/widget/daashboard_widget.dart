import 'package:flutter/material.dart';
import 'package:patient_management_system/util/responsive.dart';
import 'package:patient_management_system/widget/activity_details_card.dart';
import 'package:patient_management_system/widget/bar_graph_widget.dart';
import 'package:patient_management_system/widget/header_widget.dart';
import 'package:patient_management_system/widget/line_chart_card.dart';
import 'package:patient_management_system/widget/summary_widget.dart';

class DashboardWidget extends StatelessWidget {
  const DashboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            const SizedBox(height: 18),
            const HeaderWidget(),
            const SizedBox(height: 18),
            const ActivityDetailsCard(),
            const SizedBox(height: 18),
            const LineChartCard(),
            const SizedBox(height: 18),
            const BarGraphCard(),
            const SizedBox(height: 18),
            if (Responsive.isTablet(context)) const SummaryWidget(),
          ],
        ),
      ),
    );
  }
}