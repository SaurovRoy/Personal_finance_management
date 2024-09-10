import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class PiChartScreen extends StatefulWidget {
  const PiChartScreen({Key? key}) : super(key: key);

  @override
  State<PiChartScreen> createState() => _PiChartScreenState();
}

class _PiChartScreenState extends State<PiChartScreen> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final List<Color> colorList = const [
    Color(0xff4285F4),
    Color(0xff1ac260),
    Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('finance_management')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('total')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  }
                  if (snapshot.hasData) {
                    var snap = snapshot.data!.docs;

                    if (snap.isNotEmpty) {
                      // Debug print to check document data
                      for (var doc in snap) {
                        print(doc.data()); // Print each document's data
                      }

                      // Assuming you need to aggregate data from all documents
                      double totalIncome = 0;
                      double totalExpense = 0;
                      double totalBalance = 0;

                      for (var doc in snap) {
                        totalIncome += double.parse(doc['totalIncome'].toString());
                        totalExpense += double.parse(doc['totalExpense'].toString());
                        totalBalance += double.parse(doc['totalBalance'].toString());
                      }

                      return Column(
                        children: [
                          PieChart(
                            dataMap: {
                              "Total Income": totalIncome,
                              "Total Expense": totalExpense,
                              "Total Balance": totalBalance,
                            },
                            chartRadius: MediaQuery.of(context).size.width / 3.2,
                            legendOptions: const LegendOptions(
                              legendPosition: LegendPosition.left,
                            ),
                            chartType: ChartType.ring,
                            colorList: colorList,
                            animationDuration: const Duration(milliseconds: 1200),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                          Card(
                            child: Column(
                              children: [
                                ReUseableRow(title: "Total Income", value: totalIncome.toString()),
                                ReUseableRow(title: "Total Expense", value: totalExpense.toString()),
                                ReUseableRow(title: 'Total Balance', value: totalBalance.toString()),
                              ],
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Center(child: Text('No data available'));
                    }
                  } else {
                    return Center(child: Text('No data available'));
                  }
                },
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            ],
          ),
        ),
      ),
    );
  }
}

class ReUseableRow extends StatelessWidget {
  final String title;
  final String value;

  const ReUseableRow({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          const SizedBox(height: 5),
          const Divider(),
        ],
      ),
    );
  }
}
