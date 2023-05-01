import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../services/database.dart';

class Graphs extends StatefulWidget {
  const Graphs({Key? key}) : super(key: key);

  @override
  State<Graphs> createState() => _GraphsState();
}

class _GraphsState extends State<Graphs> {
  List<Map<String, dynamic>> _transactions = [];
  List<Widget> _monthlyCharts = [];
  DateTime _startDate = DateTime(2000, 1, 1);
  DateTime _endDate = DateTime.now();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    _fetchData();
    // _categorizedTransactions();
  }

  void _fetchData() async {
    // dispose();
    final List<Map<String, dynamic>>? res =
        await DatabaseService(uid: uid).getTransactions();
    if (res == null) {
      return;
    }
    setState(() {
      _transactions = res;
      // print("Graphs $_transactions");
      _startDateController.text = DateFormat('dd-MM-yyyy').format(_startDate).toString();
      _endDateController.text = DateFormat('dd-MM-yyyy').format(_endDate).toString();
    });

    _categorizedTransactions();
  }

  void _categorizedTransactions() {
    Map<String, List<_MonthlyExpenses>> monthlyExpenses = {};
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
        years.add(year);
        for (int i = 1; i <= 12; i++) {
          monthlyExpenses[year]!.add(_MonthlyExpenses(i.toString(), 0));
        }
      }

      // print("Month $month Year $year Amount ${data['amount']}");

      monthlyExpenses[year]![int.parse(month) - 1].expenses += data['amount'];
    }

    years.sort((a, b) => int.parse(a).compareTo(int.parse(b)));

    // print(years.length);

    if (years.isEmpty) {
      setState(() {
        _monthlyCharts = [];
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

    setState(() {
      _monthlyCharts = charts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(height: 20),
          // Create a date range picker.
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
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
                      if (mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Start date cannot be after end date"),
                        ),
                      );
                      return;
                    }

                    setState(() {
                      _startDate = date!;
                      _startDateController.text = DateFormat('dd-MM-yyyy').format(_startDate).toString();
                      _categorizedTransactions();
                    });
                  },
                ),
                TextFormField(
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
                      if (mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("End date cannot be before start date"),
                        ),
                      );
                      return;
                    }

                    setState(() {
                      _endDate = date!;
                      _endDateController.text = DateFormat('dd-MM-yyyy').format(_endDate).toString();
                      _categorizedTransactions();
                    });
                  },
                ),
              ],
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
