import 'package:birthday_reminder/models/birthday.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddBirthdayPage extends StatefulWidget {
  const AddBirthdayPage({super.key});

  @override
  State<AddBirthdayPage> createState() => _AddBirthdayPageState();
}

class _AddBirthdayPageState extends State<AddBirthdayPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  void dispose()
  {
    _nameController.dispose();
    _dateController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Birthday",
          style: TextStyle(
            color: Colors.white
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        backgroundColor: const Color(0xFF38000a),
      ),
      body: Padding(
        padding:const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Name",
              style: TextStyle(
                fontSize: 16
              ),
            ),
            const SizedBox(height: 8,),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter Name"
              ),
            ),
            const SizedBox(height: 8,),
            const Text(
              "Date of Birth",
              style: TextStyle(
                fontSize: 16
              ),
            ),
            const SizedBox(height: 8,),
            TextField(
              controller: _dateController,
              readOnly: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Select Date",
                suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                  onPressed: () async{
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100)
                      );
                      if(pickedDate !=null)
                        {
                          setState(() {
                            _dateController.text =
                                "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                          });
                        }
                  },
                )
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    if(_nameController.text.isNotEmpty && _dateController.text.isNotEmpty){
                      final name = _nameController.text;
                      final date = DateFormat("dd/MM/yyyy").parse(_dateController.text);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Added Successfully"),
                        )
                      );
                      Navigator.pop(context, Birthday(name: name, date: date));
                    }else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please fill all fields"),
                        ),
                      );
                    }
                  },
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(Color(0xFF9b1313)),
                ),
                child: const Text(
                  "Save",
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
                  ),
            )
          ],
        ),
      ),
    );
  }
}
