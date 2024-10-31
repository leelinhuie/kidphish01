import 'package:flutter/material.dart';

class AppUsage {
  final String appName;
  final String usageTime;

  AppUsage({required this.appName, required this.usageTime});
}

class ReportPages extends StatelessWidget {
  const ReportPages({super.key});

  List<AppUsage> generateSampleAppUsageData() {
    return [
      AppUsage(appName: "App 1", usageTime: "2h 30m"),
      AppUsage(appName: "App 2", usageTime: "1h 15m"),
      AppUsage(appName: "App 3", usageTime: "45m"),
      AppUsage(appName: "App 4", usageTime: "3h 10m"),
      AppUsage(appName: "App 5", usageTime: "1h 50m"),
    ];
  }

  @override
  Widget build(BuildContext context) {
    List<AppUsage> appUsageData = generateSampleAppUsageData();

    return Scaffold(
      backgroundColor: Color(0xFF1F2A37),
      appBar: AppBar(
        title: Text("App Usage Report"),
        backgroundColor: Color(0xFF1F2A37),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: appUsageData.length,
        itemBuilder: (context, index) {
          AppUsage appUsage = appUsageData[index];
          return ListTile(
            title: Text(appUsage.appName),
            subtitle: Text("Usage Time: ${appUsage.usageTime}"),
          );
        },
      ),
    );
  }
}