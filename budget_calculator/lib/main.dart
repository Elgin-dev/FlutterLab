
import 'package:flutter/material.dart';

void main() {
  runApp(const BudgetCalculatorApp());
}

class BudgetCalculatorApp extends StatelessWidget {
  const BudgetCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Budget Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
        ),
        useMaterial3: true,
      ),
      home: const BudgetCalculatorScreen(),
    );
  }
}

class BudgetCalculatorScreen extends StatefulWidget {
  const BudgetCalculatorScreen({super.key});

  @override
  State<BudgetCalculatorScreen> createState() =>
      _BudgetCalculatorScreenState();
}

class _BudgetCalculatorScreenState
    extends State<BudgetCalculatorScreen> {
  final incomeController = TextEditingController();
  final rentController = TextEditingController();
  final foodController = TextEditingController();
  final transportController = TextEditingController();
  final othersController = TextEditingController();

  double? balance;
  String message = '';
  Color resultColor = Colors.black;

  void calculateBalance() {
    final income = double.tryParse(incomeController.text.trim());
    final rent = double.tryParse(rentController.text.trim());
    final food = double.tryParse(foodController.text.trim());
    final transport =
        double.tryParse(transportController.text.trim());
    final others = double.tryParse(othersController.text.trim());

    if (income == null ||
        income <= 0 ||
        rent == null ||
        rent < 0 ||
        food == null ||
        food < 0 ||
        transport == null ||
        transport < 0 ||
        others == null ||
        others < 0) {
      setState(() {
        balance = null;
        message =
            'Enter a positive income and valid, non-negative expenses.';
        resultColor = Colors.red;
      });
      return;
    }

    final remaining = income - (rent + food + transport + others);

    setState(() {
      balance = remaining;

      if (remaining < 0) {
        message = 'You are overspending!';
        resultColor = Colors.red;
      } else if (remaining > 0) {
        message = 'Great! You have money left this month.';
        resultColor = Colors.green;
      } else {
        message = 'Your budget is exactly balanced.';
        resultColor = Colors.orange;
      }
    });
  }

  Widget buildExpenseField(
    String label,
    TextEditingController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(
          decimal: true,
        ),
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: const Icon(Icons.currency_rupee),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    incomeController.dispose();
    rentController.dispose();
    foodController.dispose();
    transportController.dispose();
    othersController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Monthly Budget Calculator'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.account_balance_wallet,
              size: 70,
              color: Colors.teal,
            ),
            const SizedBox(height: 12),
            const Text(
              'Manage Your Monthly Expenses',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),

            buildExpenseField(
              'Monthly Income (₹)',
              incomeController,
            ),
            buildExpenseField('Rent / EMI (₹)', rentController),
            buildExpenseField('Food Expenses (₹)', foodController),
            buildExpenseField(
              'Transport Expenses (₹)',
              transportController,
            ),
            buildExpenseField(
              'Other Expenses (₹)',
              othersController,
            ),

            const SizedBox(height: 8),

            ElevatedButton(
              onPressed: calculateBalance,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(16),
              ),
              child: const Text(
                'Calculate Balance',
                style: TextStyle(fontSize: 18),
              ),
            ),

            const SizedBox(height: 24),

            if (message.isNotEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      if (balance != null)
                        Text(
                          'Remaining Balance',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium,
                        ),
                      if (balance != null)
                        const SizedBox(height: 8),
                      if (balance != null)
                        Text(
                          '₹${balance!.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: resultColor,
                          ),
                        ),
                      const SizedBox(height: 8),
                      Text(
                        message,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: resultColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
