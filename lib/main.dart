import 'package:flutter/material.dart';

void main() {
  runApp(const TransaksiApp());
}

class TransaksiApp extends StatelessWidget {
  const TransaksiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const TransaksiScreen(),
    );
  }
}

class TransaksiScreen extends StatefulWidget {
  const TransaksiScreen({super.key});

  @override
  State<TransaksiScreen> createState() => _TransaksiScreenState();
}

class _TransaksiScreenState extends State<TransaksiScreen> {
  final List<Map<String, dynamic>> items = [
    {'name': 'Laptop', 'price': 25000000, 'controller': TextEditingController(), 'subtotal': 0.0},
    {'name': 'Mouse', 'price': 1250000, 'controller': TextEditingController(), 'subtotal': 0.0},
    {'name': 'Keyboard', 'price': 1500000, 'controller': TextEditingController(), 'subtotal': 0.0},
    {'name': 'Monitor', 'price': 5000000, 'controller': TextEditingController(), 'subtotal': 0.0},
    {'name': 'Printer', 'price': 2200000, 'controller': TextEditingController(), 'subtotal': 0.0},
  ];

  double totalPayment = 0;
  bool showReceipt = false;

  void resetFields() {
    setState(() {
      for (var item in items) {
        item['controller'].clear();
        item['subtotal'] = 0;
      }
      totalPayment = 0;
      showReceipt = false;
    });
  }

  void calculateTotal() {
    setState(() {
      totalPayment = 0;
      for (var item in items) {
        int quantity = int.tryParse(item['controller'].text) ?? 0;
        item['subtotal'] = item['price'] * quantity;
        totalPayment += item['subtotal'];
      }
    });
  }

  void displayReceipt() {
    setState(() {
      calculateTotal();
      showReceipt = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Toko Komputer"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return ListTile(
                    title: Text(item['name']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Rp ${item['price']}'),
                        Text('Subtotal: Rp ${item['subtotal'].toStringAsFixed(0)}'),
                      ],
                    ),
                    trailing: SizedBox(
                      width: 50,
                      child: TextField(
                        controller: item['controller'],
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: '0',
                        ),
                        onChanged: (value) => calculateTotal(),
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: resetFields,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 243, 171, 235),
                  ),
                  child: const Text("Reset"),
                ),
                ElevatedButton(
                  onPressed: displayReceipt,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text("Cetak Struk"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Total: Rp $totalPayment',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (showReceipt) const Divider(),
            if (showReceipt)
              Expanded(
                child: ListView(
                  children: [
                    const Text(
                      "Struk Pembelian:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    for (var item in items)
                      if ((item['subtotal'] as double) > 0)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Text(
                            "${item['name']} x ${item['controller'].text} = Rp ${item['subtotal'].toStringAsFixed(0)}",
                          ),
                        ),
                    const Divider(),
                    Text(
                      'Total Bayar: Rp ${totalPayment.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
