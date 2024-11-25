import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:perpustakaan/insert.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({super.key});

  @override
  _BookListPageState createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  // Buat variabel untuk menyimpan daftar buku
  List<Map<String, dynamic>> buku = [];

  @override
  void initState() {
    super.initState();
    fetchBook();
  }

  Future<void> fetchBook() async {
    final response = await Supabase.instance.client.from('buku').select();

    setState(() {
      buku = List<Map<String, dynamic>>.from(response);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.cyan[600],
        title: const Text('Daftar Buku', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white,),
            onPressed: fetchBook,
          ),
        ],
      ),
      body: buku.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: buku.length,
              itemBuilder: (context, index) {
                final book = buku[index];
                return Card(
                  color: Colors.blue[50],
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    title: Text(book['judul'] ?? 'Judul tidak tersedia'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          book['penulis'] ?? 'Penulis Tidak Tersedia',
                          style: const TextStyle(
                              fontStyle: FontStyle.italic, fontSize: 14),
                        ),
                        Text(
                          book['deskripsi'] ?? 'Deskripsi Tidak Tersedia',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            // Tambahkan logika navigasi ke halaman edit
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            // Tambahkan logika hapus buku
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddBookPage()),
          );
          if (result == true) {
            fetchBook(); // Refresh data jika buku berhasil ditambahkan
          }
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add, color: Colors.white,),
      ),
    );
  }
}