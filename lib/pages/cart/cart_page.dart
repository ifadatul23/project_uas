import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  final List<Map<String, String>> cartItems;

  const CartPage({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    // Hitung subtotal dari harga item
    int subtotal = cartItems.fold(
      0,
      (sum, item) =>
          sum +
          int.parse(item['price']!.replaceAll('.', '').replaceAll('Rp', '')),
    );
    int ongkir = 11000;
    int biayaPesan = 2000;
    int total = subtotal + ongkir + biayaPesan;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang Saya'),
        backgroundColor: const Color(0xFF2B7A74),
      ),
      body:
          cartItems.isEmpty
              ? const Center(child: Text('Keranjang masih kosong'))
              : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final item = cartItems[index];
                        return ListTile(
                          leading: Image.asset(
                            item['image']!,
                            width: 50,
                            height: 50,
                          ),
                          title: Text(item['name']!),
                          subtitle: Text(item['price']!),
                        );
                      },
                    ),
                  ),
                  // Tampilkan ringkasan dan tombol pesan kalau keranjang tidak kosong
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Rangkuman Pesanan",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Subtotal"),
                            Text("Rp$subtotal"),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Ongkos Kirim"),
                            Text("Rp$ongkir"),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Biaya Pemesanan"),
                            Text("Rp$biayaPesan"),
                          ],
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Total Harga",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Rp$total",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(
                                255,
                                38,
                                116,
                                111,
                              ),
                            ),
                            onPressed: () {
                              // aksi tombol
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Pesanan berhasil dikirim!"),
                                ),
                              );
                            },
                            child: const Text("Pesan"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
    );
  }
}
