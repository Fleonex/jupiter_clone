import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:jupiter_clone/style/color.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../services/database.dart';

class Graphs extends StatefulWidget {
  const Graphs({Key? key}) : super(key: key);

  @override
  State<Graphs> createState() => _GraphsState();
}

class _GraphsState extends State<Graphs> {
  List<Map<String, dynamic>> _transactions = [];
  List<String> _categories = [];
  Map<String, double> _categoryLimits = {};
  List<Widget> _monthlyCharts = [];
  List<Widget> _monthlyCategoricalCharts = [];
  DateTime _startDate = DateTime(2000, 1, 1);
  DateTime _endDate = DateTime.now();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final String uid = FirebaseAuth.instance.currentUser!.uid;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchData();
    // _categorizedTransactions();
  }

  void _fetchData() async {
    // dispose();
    setState(() {
      _isLoading = true;
    });
    final List<Map<String, dynamic>>? res =
        await DatabaseService(uid: uid).getTransactions();
    final List<Map<String, dynamic>>? categoriesRes =
        await DatabaseService(uid: uid).getCategories();
    if (res == null || categoriesRes == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }
    List<String> categories = [];
    Map<String, double> categoryLimits = {};

    for (var data in categoriesRes) {
      categoryLimits[data['category']] = data['limit'];
    }

    for (var data in categoriesRes) {
      categories.add(data['category']);
    }
    setState(() {
      _transactions = res;
      _categories = categories;
      _categoryLimits = categoryLimits;
      // print("Graphs $_transactions");
      _startDateController.text =
          DateFormat('dd-MM-yyyy').format(_startDate).toString();
      _endDateController.text =
          DateFormat('dd-MM-yyyy').format(_endDate).toString();
    });

    _categorizedTransactions();
  }

  List<Color> _getColors(int n) {
    List<Color> colors = [];

    int i = 0;
    while (i < n) {
      var generatedColor = Random().nextInt(Colors.primaries.length);
      if (!colors.contains(Colors.primaries[generatedColor])) {
        colors.add(Colors.primaries[generatedColor]);
        i++;
        continue;
      }
      generatedColor = Random().nextInt(Colors.accents.length);
      if (!colors.contains(Colors.accents[generatedColor])) {
        colors.add(Colors.accents[generatedColor]);
        i++;
        continue;
      }
      colors.add(
          Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0));
    }

    return colors;
  }

  void _categorizedTransactions() {
    Map<String, List<_MonthlyExpenses>> monthlyExpenses = {};
    Map<String, List<List<_CategoricalExpense>>> categoricalExpenses = {};
    List<Color> colors = _getColors(_categories.length);
    List<String> years = [];

    for (var data in _transactions) {
      DateTime date = data['date'].toDate();
      // print(date);
      // print(date.isBefore(_startDate));
      if (date.isBefore(_startDate) || date.isAfter(_endDate)) {
        // print("Date $date is not in range ${_startDate} - ${_endDate}");
        continue;
      }
      String year = date.year.toString();
      String month = date.month.toString();

      if (monthlyExpenses[year] == null) {
        monthlyExpenses[year] = [];
        categoricalExpenses[year] = [];
        years.add(year);

        for (int i = 1; i <= 12; i++) {
          monthlyExpenses[year]!.add(_MonthlyExpenses(i.toString(), 0));
          categoricalExpenses[year]!.add([]);
        }

        for (int i = 0; i < _categories.length; i++) {
          for (int j = 0; j < 12; j++) {
            categoricalExpenses[year]![j]
                .add(_CategoricalExpense(_categories[i], 0, colors[i]));
          }
        }
      }

      monthlyExpenses[year]![int.parse(month) - 1].expenses += data['amount'];
      String category = data['category'];
      // print("$category ${categoricalExpenses[year]![int.parse(month) - 1]!.firstWhere((element) => element.category == category).category}");
      categoricalExpenses[year]![int.parse(month) - 1]
          .firstWhere((element) => element.category == category)
          .expenses += data['amount'];
    }

    years.sort((a, b) => int.parse(a).compareTo(int.parse(b)));

    // print(years.length);

    if (years.isEmpty) {
      setState(() {
        _monthlyCharts = [];
        _isLoading = false;
      });
      return;
    }

    List<Widget> charts = [];
    for (int i = 0; i < years.length; i++) {
      charts.add(SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        title: ChartTitle(text: 'Monthly Expenses in ${years[i]}'),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <ChartSeries<_MonthlyExpenses, String>>[
          LineSeries<_MonthlyExpenses, String>(
            dataSource: monthlyExpenses[years[i]]!,
            xValueMapper: (_MonthlyExpenses expenses, _) => expenses.month,
            yValueMapper: (_MonthlyExpenses expenses, _) => expenses.expenses,
            name: years[i],
            // dataLabelSettings: const DataLabelSettings(isVisible: true),
          ),
        ],
      ));
    }
    List<Widget> piecharts = [];
    for (int i = 0; i < years.length; i++) {
      for (int j = 1; j <= 12; j++) {
        if (categoricalExpenses[years[i]]![j - 1].isNotEmpty &&
            monthlyExpenses[years[i]]![j - 1].expenses > 0) {
          // print("Categorical Expenses ${categoricalExpenses[years[i]]![j]}");
          piecharts.add(SfCircularChart(
            title: ChartTitle(text: 'Categorical Expenses in  $j,${years[i]}'),
            legend: Legend(isVisible: true),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <CircularSeries<_CategoricalExpense, String>>[
              PieSeries<_CategoricalExpense, String>(
                dataSource: categoricalExpenses[years[i]]![j - 1],
                xValueMapper: (_CategoricalExpense expenses, _) =>
                    expenses.category,
                yValueMapper: (_CategoricalExpense expenses, _) =>
                    expenses.expenses,
                pointColorMapper: (_CategoricalExpense expenses, _) =>
                    expenses.color,
                dataLabelSettings: const DataLabelSettings(isVisible: true),
                explode: true,
                explodeGesture: ActivationMode.singleTap,
              ),
            ],
          ));
        }
      }
    }

    setState(() {
      _monthlyCharts = charts;
      _monthlyCategoricalCharts = piecharts;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const SpinKitSpinningLines(color: purple)
        : Scaffold(
            appBar: AppBar(
              title: const Text("Graphs"),
              backgroundColor: purple,
            ),
            body: ListView(
              children: [
                const SizedBox(height: 20),
                // Create a date range picker.
                Form(
                  key: _formKey,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            controller: _startDateController,
                            decoration: const InputDecoration(
                              labelText: 'Start Date',
                              hintText: 'Enter the start date',
                            ),
                            onTap: () async {
                              // Below line stops keyboard from appearing
                              FocusScope.of(context).requestFocus(FocusNode());
                              // Show Date Picker Here
                              DateTime? date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2010),
                                lastDate: DateTime(2050),
                              );

                              if (date!.isAfter(_endDate)) {
                                if (!mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        "Start date cannot be after end date"),
                                  ),
                                );
                                return;
                              }

                              setState(() {
                                _startDate = date;
                                _startDateController.text =
                                    DateFormat('dd-MM-yyyy')
                                        .format(_startDate)
                                        .toString();
                                _categorizedTransactions();
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            controller: _endDateController,
                            decoration: const InputDecoration(
                              labelText: 'End Date',
                              hintText: 'Enter the end date',
                            ),
                            onTap: () async {
                              // Below line stops keyboard from appearing
                              FocusScope.of(context).requestFocus(FocusNode());
                              // Show Date Picker Here
                              DateTime? date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2010),
                                lastDate: DateTime(2050),
                              );

                              if (date!.isBefore(_startDate)) {
                                if (!mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        "End date cannot be before start date"),
                                  ),
                                );
                                return;
                              }

                              setState(() {
                                _endDate = date;
                                _endDateController.text =
                                    DateFormat('dd-MM-yyyy')
                                        .format(_endDate)
                                        .toString();
                                _categorizedTransactions();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                (_monthlyCharts.isEmpty)
                    ? const Center(child: Text("No data to display"))
                    : SizedBox(
                        height: 300,
                        child: PageView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          clipBehavior: Clip.none,
                          reverse: true,
                          children: _monthlyCharts.reversed.toList(),
                        ),
                      ),
                const SizedBox(height: 20),
                (_monthlyCategoricalCharts.isEmpty)
                    ? const Center(child: Text("No data to display"))
                    : SizedBox(
                        height: 300,
                        child: PageView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          clipBehavior: Clip.none,
                          reverse: true,
                          children: _monthlyCategoricalCharts.reversed.toList(),
                        ),
                      ),
              ],
            ),
          );
  }
}

class _MonthlyExpenses {
  String month;
  double expenses;

  _MonthlyExpenses(this.month, this.expenses);
}

class _CategoricalExpense {
  String category;
  double expenses;
  final Color color;

  _CategoricalExpense(this.category, this.expenses, this.color);
}
