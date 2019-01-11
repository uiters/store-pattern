import 'dart:async';

import './connectServer.dart';

import './../Constants/queries.dart' as queries;

class Model {
  static final instance = new Model();

  Future<List<Report>> getReports() async {
    Future<List> futureReports = MySqlConnection.instance.executeQuery(
      queries.QUERY_GET_REPORT_LASTWEEK
    );
    return _parseReports(futureReports);
  }
  Future<Report> getReportToday() async {
    Future<List> futureReport = MySqlConnection.instance.executeQuery(
      queries.QUERY_GET_REPORT_TODAY
    );
    return _parseReport(futureReport);
  }

  Future<List<Report>>  getReportsMonth() async {
    Future<List> futureReport = MySqlConnection.instance.executeQuery(
      queries.QUERY_GET_REPORT_MONTH
    );
    return _parseReports(futureReport);
  }

  Future<List<Report>>  getReportsYear() async {
    Future<List> futureReport = MySqlConnection.instance.executeQuery(
      queries.QUERY_GET_REPORT_YEAR
    );
    return _parseReports(futureReport);
  }

  Future<Report> _parseReport(Future<List> futureReport) async {
    List<Report> reports = [];
    await futureReport.then((values) {
      values.forEach((value) => reports.add(new Report.fromJson(value)));
    });
    return reports[0];
  }

  Future<List<Report>> _parseReports(Future<List> futureReports) async {
    List<Report> reports = [];
    await futureReports.then((values) {
      values.forEach((value) => reports.add(new Report.fromJson(value)));
    });
    return reports;
  }
}


class Report {
  int id;
  DateTime day;
  double totalPrice;

  Report(this.day, this.totalPrice);

  Report.fromJson(Map<String, dynamic> json) {
    id = json['ID'] != null ? int.parse(json['ID']) : 0;
    day = DateTime.parse(json['_Date']);
    totalPrice = double.parse(json['TotalPrice']);
  }
}