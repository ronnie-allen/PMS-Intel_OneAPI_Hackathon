import 'package:patient_management_system/Models/health_model.dart';

class HealthDetails {
  final healthData = const [
    HealthModel(
        icon: 'assets/icons/burn.png', value: "305", title: "Calories burned"),
    HealthModel(
        icon: 'assets/icons/steps.png', value: "10,983", title: "Steps"),
    HealthModel(
        icon: 'assets/icons/distance.png', value: "9km", title: "Distance"),
    HealthModel(icon: 'assets/icons/sleep.png', value: "7h48m", title: "Sleep"),
  ];
}