import 'package:birthday_reminder/add_birthday_page.dart';
import 'package:birthday_reminder/models/birthday.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Birthday> birthdays = []; //List of birthday
  @override
  Widget build(BuildContext context) {
    //categories the birthdays
    final todayBirthdays = birthdays.where((birthday){
      final daysUntil = calculateDaysToBirthday(birthday.date);
      return daysUntil == 0; //Today
    }).toList();

    final thisWeekBirthdays = birthdays.where((birthday){
      final daysUntil = calculateDaysToBirthday(birthday.date);
      return daysUntil > 0 && daysUntil <=7; //This Week
    }).toList();

    final upcomingBirthdays = birthdays.where((birthday){
      final daysUntil = calculateDaysToBirthday(birthday.date);
      return daysUntil > 7; //Beyond this week
    }).toList()
    ..sort((a, b) => calculateDaysToBirthday(a.date)
      .compareTo(calculateDaysToBirthday(b.date))); //sort by days remaining

    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF38000a),
        title: Text(
          "Upcoming Birthday",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        leading: Icon(
          Icons.cake,
          color: Colors.white,
        ),
        actions: [
          Icon(
            Icons.cake,
            color: Colors.white,
          )
        ],
      ),
      body: birthdays.isEmpty
          ? const Center(
        child: Text(
          "No upcoming birthdays. Add one now!",
          style: TextStyle(
            fontSize: 16
          ),
        ),

      )
      : SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16)
            )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Today Section
              if(todayBirthdays.isNotEmpty)
                buildSection("Today", todayBirthdays),
              if (thisWeekBirthdays.isNotEmpty)
                buildSection("This Week", thisWeekBirthdays),
              if (upcomingBirthdays.isNotEmpty)
                buildSection("Upcoming", upcomingBirthdays)
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddBirthdayPage()),
          );

          if(result != null && result is Birthday){
            setState(() {
              birthdays.add(result);
            });
          }
        },
        backgroundColor: const Color(0xFF9b1313),
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          size: 30,
          color: Colors.white,
        ),

      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10.0,
        color: Color(0xFFffc4c4),
        child: SizedBox(height: 60,),
      ),

    );
  }


  Widget buildSection(String title, List<Birthday> birthdayList)
  {
    final randomColors = [
      Color(0xFF9b1313),
      Color(0xFF8174A0),
      Color(0xFF9ABF80),
      Color(0xFFAA5486),
      Color(0xFF003161),
      Color(0xFF441752),
      Color(0xFF1F4529),
      Color(0xFF89A8B2),
      Color(0xFFFC8F54),
      Color(0xFF7ED4AD),
      Color(0xFF9A7E6F),
      Color(0xFF54473F),
      Color(0xFFBC7C7C),

    ];
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: birthdayList.length,
            itemBuilder: (context, index) {
              final birthday = birthdayList[index];
              final daysUntil = calculateDaysToBirthday(birthday.date);
              final randomColor =
                  randomColors[index % randomColors.length];


              return GestureDetector(
                onLongPress: () {
                  //show conformation dialog for delete
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Delete Birthday"),
                        content: const Text(
                          "Are you sure you want to delete this birthday ?",

                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Cancel")
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                birthdays.remove(birthday);
                              });
                              Navigator.pop(context);
                            },
                            child: const Text("Delete"),
                          ),
                        ],
                      )
                  );
                },
                child: Padding(
                 padding:const EdgeInsets.symmetric(vertical: 8.0),
                  child: Stack(
                    children: [
                      Container(
                        height: 90,
                        decoration: BoxDecoration(
                          color: randomColor,
                          borderRadius: BorderRadius.circular(20)
                        ),
                      ),
                      Positioned(
                        left: 10,
                        right: 0,
                        top: 0,
                        bottom: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                spreadRadius: 2,
                                offset: const Offset(0, 5)
                              ),
                            ],
                          ),
                          child: Padding(
                            padding:const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      birthday.name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      "${birthday.date.day}/${birthday.date.month}/${birthday.date.year}",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  daysUntil == 0 ? "Today" : "$daysUntil Days",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: daysUntil == 0
                                        ? Colors.green
                                        : Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },

          )

        ],
      ),
    );
  }



}

int calculateDaysToBirthday(DateTime dob)
{
  DateTime today = DateTime.now();
  DateTime nextBirthday = DateTime(today.year,dob.month,dob.day);

  if(nextBirthday.day == today.day && nextBirthday.month == today.month)
    {
      return 0;
    }

  if(nextBirthday.isBefore(today)){
    nextBirthday = DateTime(today.year +1, dob.month, dob.day );
  }

  return nextBirthday.difference(today).inDays + 1;
}




