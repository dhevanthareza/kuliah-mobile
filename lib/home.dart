import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_1/components/app_button.dart';
import 'package:flutter_application_1/components/app_text_field.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              "Catat\nPengeluaran",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            AppTextField(
              label: "Keterangan",
            ),
            const SizedBox(
              height: 20,
            ),
            AppTextField(
              label: "Jumlah Pengeluaran",
            ),
            const SizedBox(
              height: 20,
            ),
            AppButton(
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
            )
          ],
        ),
      ),
    );
  }
}
