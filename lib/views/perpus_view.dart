import 'package:flutter/material.dart';
import 'package:navigasi_perpus/controllers/perpus_controllers.dart';
import 'package:navigasi_perpus/widgets/bottom_nav.dart';
import 'package:navigasi_perpus/widgets/modal.dart';
import 'package:navigasi_perpus/models/perpus.dart';

class PerpusView extends StatefulWidget {
  PerpusView({super.key});

  @override
  State<PerpusView> createState() => _PerpusViewState();
}

class _PerpusViewState extends State<PerpusView> {
  final PerpusControllers perpus = PerpusControllers();
  final TextEditingController tittleInput = TextEditingController();
  final TextEditingController deskripsiInput = TextEditingController();
  final TextEditingController judulInput = TextEditingController();
  final TextEditingController penerbitInput = TextEditingController();
  final TextEditingController karyaInput = TextEditingController();
  final TextEditingController stockInput = TextEditingController();
  final TextEditingController gambarInput = TextEditingController();
  final TextEditingController voteAverageInput = TextEditingController();
  final GlobalKey<FormState> _formKeyTambah = GlobalKey<FormState>();
  final ModalWidget modal = ModalWidget();

  final List<String> listAct = ["Ubah", "Hapus"];
  List<Perpus>? book;
  int? bookId;

  void getBook() {
    setState(() {
      book = perpus.perpus;
    });
  }

  void addBook(Perpus data) {
    setState(() {
      book!.add(data);
      getBook();
    });
  }

  @override
  void initState() {
    super.initState();
    getBook();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Perpustakaan"),
        backgroundColor: const Color.fromARGB(255, 255, 182, 182),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                bookId = null;
              });
              clearFormInputs();
              modal.showFullModal(context, fromTambah(null));
            },
            icon: Icon(Icons.add_sharp),
          ),
        ],
      ),
      body: book != null && book!.isNotEmpty
          ? ListView.builder(
              padding: EdgeInsets.all(12),
              itemCount: book!.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.white,
                  child: ListTile(
                    leading: Image(
                      image: AssetImage(book![index].posterPath),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          book![index].judul,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          book![index].deskripsi,
                          style: TextStyle(fontSize: 11),
                        ),
                        Text(
                          book![index].penerbit,
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          book![index].karya,
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          book![index].stock,
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                        Text(book![index].voteAverage.toString()),
                      ],
                    ),
                    trailing: PopupMenuButton<String>(
                      icon: Icon(
                        Icons.more_vert,
                        color: Colors.black,
                        size: 20.0,
                      ),
                      itemBuilder: (BuildContext context) {
                        return listAct.map((String choice) {
                          return PopupMenuItem<String>(
                            value: choice,
                            child: Text(choice),
                            onTap: () {
                              if (choice == "Ubah") {
                                setState(() {
                                  bookId = book![index].id;
                                });
                                fillFormInputs(index);
                                modal.showFullModal(context, fromTambah(index));
                              } else if (choice == "Hapus") {
                                setState(() {
                                  book!.removeAt(index);
                                  getBook();
                                });
                              }
                            },
                          );
                        }).toList();
                      },
                    ),
                  ),
                );
              },
            )
          : Center(child: Text("Data Kosong")),
      bottomNavigationBar: BottomNav(3),
    );
  }

  Widget fromTambah(int? index) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKeyTambah,
          child: Column(
            children: [
              Text(
                index == null ? "Tambah Data" : "Ubah Data",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: tittleInput,
                decoration: InputDecoration(labelText: "ID"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Harus diisi';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: judulInput,
                decoration: InputDecoration(labelText: "Judul"),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: deskripsiInput,
                decoration: InputDecoration(labelText: "Deskripsi"),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: penerbitInput,
                decoration: InputDecoration(labelText: "Penerbit"),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: karyaInput,
                decoration: InputDecoration(labelText: "Karya"),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: stockInput,
                decoration: InputDecoration(labelText: "Stock"),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: voteAverageInput,
                decoration: InputDecoration(labelText: "Rating"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKeyTambah.currentState!.validate()) {
                    if (index == null) {
                      addBook(
                        Perpus(
                          id: int.parse(tittleInput.text),
                          judul: judulInput.text,
                          deskripsi: deskripsiInput.text,
                          penerbit: penerbitInput.text,
                          karya: karyaInput.text,
                          stock: stockInput.text,
                          posterPath: gambarInput.text,
                          voteAverage: double.parse(voteAverageInput.text),
                        ),
                      );
                    } else {
                      book![index] = Perpus(
                        id: int.parse(tittleInput.text),
                        judul: judulInput.text,
                        deskripsi: deskripsiInput.text,
                        penerbit: penerbitInput.text,
                        karya: karyaInput.text,
                        stock: stockInput.text,
                        posterPath: gambarInput.text,
                        voteAverage: double.parse(voteAverageInput.text),
                      );
                      getBook();
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text(index == null ? "Tambah" : "Simpan"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void fillFormInputs(int index) {
    tittleInput.text = book![index].id.toString();
    judulInput.text = book![index].judul;
    deskripsiInput.text = book![index].deskripsi;
    penerbitInput.text = book![index].penerbit;
    karyaInput.text = book![index].karya;
    stockInput.text = book![index].stock;
    gambarInput.text = book![index].posterPath;
    voteAverageInput.text = book![index].voteAverage.toString();
  }

  void clearFormInputs() {
    tittleInput.clear();
    judulInput.clear();
    deskripsiInput.clear();
    penerbitInput.clear();
    karyaInput.clear();
    stockInput.clear();
    gambarInput.clear();
    voteAverageInput.clear();
  }
}
