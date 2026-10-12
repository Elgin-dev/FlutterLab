import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: true,
    home: CustomListViewExample(),
  ));
}

// Data model for custom items
class Item {
  final String name;
  final String price;
  final String imagePath;

  Item({
    required this.name,
    required this.price,
    required this.imagePath,
  });
}

class CustomListViewExample extends StatelessWidget {
  const CustomListViewExample({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample dataset based on PDF slides
    final List<Item> items = [
      Item(name: 'Apple', price: '₹180.00', imagePath: 'C:/Users/students/Documents/Flutter/apple.jpg'),
      Item(name: 'Orange', price: '₹100.00', imagePath: 'C:/Users/students/Documents/Flutter/orange.jpg'),
      Item(name: 'Mango', price: '₹70.00', imagePath: 'C:/Users/students/Documents/Flutter/mango.jpg'),
      Item(name: 'Pomegranate', price: '₹250.00', imagePath: 'C:/Users/students/Documents/Flutter/pomegranate.jpg'),
      Item(name: 'Dragon Fruit', price: '₹210.00', imagePath: 'C:/Users/students/Documents/Flutter/dragon.jpg'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom List View'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  // Image Asset container
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      item.imagePath,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.image, size: 100),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Item Information & Action Button
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          item.price,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text(
                            'Buy Now',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}