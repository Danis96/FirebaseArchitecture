import 'package:firebasedrill/data/source/trainingPlanRepository.dart';

class TrainingPlanViewModel {
  var trainingPlanRepository = TrainingPlanRepository();

  Future getAllTrainingPlans() {
    return trainingPlanRepository.getTrainingPlanCollection();
  }

  Future getSpecificTrainingPlan(String id) {
    return trainingPlanRepository.getTrainingPlanDocument(id);
  }
}