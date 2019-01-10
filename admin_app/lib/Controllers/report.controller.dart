import './../Models/report.model.dart';

class Controller {
  static final instance = new Controller();

  Future<List<Report>> get reportsWeek => Model.instance.getReports();
  Future<Report> get reportToday => Model.instance.getReportToday();
}