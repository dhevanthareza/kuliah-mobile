import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/app_button.dart';
import 'package:flutter_application_1/components/app_text_field.dart';
import 'package:flutter_application_1/edit.dart';
import 'package:flutter_application_1/login.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> pengeluaran_list = [];

  TextEditingController keteranganController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  void fetchData() async {
    dynamic response = await Supabase.instance.client
        .from('expense')
        .select<List<Map<String, dynamic>>>();
    print(response);
    setState(() {
      pengeluaran_list = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                "Catat\nPengeluaran",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              AppButton(
                text: "Logout",
                color: Colors.red,
                onPressed: () {
                  final box = GetStorage();
                  box.remove('username');
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (ctx) => LoginPage()),
                      (route) => false);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              AppTextField(
                controller: keteranganController,
                label: "Keterangan",
              ),
              const SizedBox(
                height: 20,
              ),
              AppTextField(
                controller: amountController,
                label: "Jumlah Pengeluaran",
              ),
              const SizedBox(
                height: 20,
              ),
              AppButton(
                onPressed: () async {
                  await Supabase.instance.client.from('expense').insert({
                    'amount': int.parse(amountController.text),
                    'description': keteranganController.text
                  });
                  fetchData();
                },
                text: "Simpan",
                color: Colors.black,
              ),
              SizedBox(
                height: 5,
              ),
              AppButton(
                text: "Reset",
                color: Colors.grey.shade200,
                textColor: Colors.black,
              ),
              Visibility(
                visible: pengeluaran_list.isEmpty,
                child: Image.asset("images/empty_image.png"),
              ),
              Column(
                children: pengeluaran_list
                    .map(
                      (pengeluaran) => Card(
                        child: Container(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(pengeluaran['description']),
                                  Text(pengeluaran['amount'].toString()),
                                ],
                              ),
                              AppButton(
                                text: "Delete",
                                color: Colors.red,
                                onPressed: () async {
                                  await Supabase.instance.client
                                      .from('expense')
                                      .delete()
                                      .match({"id": pengeluaran['id']});
                                  fetchData();
                                },
                              ),
                              AppButton(
                                text: "Edit",
                                color: Colors.orange,
                                onPressed: () async {
                                  Navigator.of(context)
                                      .push(
                                    MaterialPageRoute(
                                      builder: (ctx) => EditPage(
                                        id: pengeluaran['id'],
                                        description: pengeluaran['description'],
                                        amount:
                                            pengeluaran['amount'].toString(),
                                      ),
                                    ),
                                  )
                                      .then((value) {
                                    fetchData();
                                  });
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
