import 'package:flutter/material.dart';

class CallHistoryPage extends StatelessWidget {
  const CallHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          callCard(
            'Bereket Sewnet',
            Icons.call_made,
            Colors.green,
            'july 18, 18:02 AM'
          ),
          callCard(
              'Betelhem Sewnet',
              Icons.call_missed,
              Colors.red,
              'april 12, 18:02 AM'
          ),
          callCard(
              'Selam Walelgn',
              Icons.call_missed,
              Colors.red,
              'april 12, 18:02 AM'
          ),
          callCard(
              'Azmeraw Mekuriya',
              Icons.call_received,
              Colors.blue,
              'april 12, 18:02 AM'
          ),
          callCard(
              'Nobel Azmeraw',
              Icons.call_made,
              Colors.green,
              'april 10, 11:02 AM'
          ),
          callCard(
              'Kaldidan Urga',
              Icons.call_received,
              Colors.blue,
              'april 10, 11:02 AM'
          ),
          callCard(
              'Mesi',
              Icons.call_merge,
              Colors.red,
              'may 10, 11:02 AM'
          ),
          callCard(
              'Nobel Azmeraw',
              Icons.call_made,
              Colors.green,
              'april 10, 11:02 AM'
          ),callCard(
              'HBtamu Melkamu',
              Icons.call_received,
              Colors.blue,
              'april 10, 11:02 AM'
          ),
        ],
      ),
    );
  }

  Widget callCard(String name, IconData icon, Color color, String time) {
    return  Card(
      margin: const EdgeInsets.only(bottom: 0.3),
      color: Colors.white,
      child:  ListTile(
        leading: const CircleAvatar(
          radius: 26,
          backgroundColor: Colors.teal,
          child: Icon(Icons.person, color: Colors.white, size: 28,),
        ),
        title: Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Row(
          children: [
            Icon(
              icon,
              color: color,
              size: 20,
            ),
            const SizedBox(width: 6),
            Text(
              time,
              style: const TextStyle(
                fontSize: 13,
              ),
            ),
          ],
        ),
        trailing: const Icon(
          Icons.call,
          color: Colors.teal,
          size: 28,
        ),
      ),
    );
  }
}
