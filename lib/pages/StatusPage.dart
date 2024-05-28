import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Easy/CustomUi/StatusPageUi/HeadOwnStatus.dart';
import 'package:Easy/CustomUi/StatusPageUi/OtherStatus.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({super.key});

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: 48,
            child: FloatingActionButton(
              backgroundColor: Colors.blueGrey[100],
              elevation: 8,
              onPressed: () {},
              child: Icon(
                Icons.edit,
                color: Colors.blueGrey[900],
              ),
            ),
          ),
          const SizedBox(height: 13),
          FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            backgroundColor: Colors.greenAccent[700],
            elevation: 5,
            onPressed: () {},
            child: const Icon(
              Icons.camera_alt,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body:  SingleChildScrollView(
        child: Column(
          children: [
            // SizedBox(height: 10),
            const HeadOwnStatus(),
            label('Recent update'),
             const OtherStatus(
               name: 'Bereket Sewnet',
               time: '01:45',
               imageName: 'assets/2.jpeg',
               isSeen: false,
               statusNum: 3,
             ),
            const OtherStatus(
              name: 'Bereket Sewnet',
              time: '02:15',
              imageName: 'assets/3.jpg',
              isSeen: false,
              statusNum: 1,
            ),
            const OtherStatus(
              name: 'Bereket Sewnet',
              time: '12:02',
              imageName: 'assets/1.jpg',
              isSeen: false,
              statusNum: 7,
            ),
            const SizedBox(height: 10),
            label('Viewed update'),
            const OtherStatus(
              name: 'Eyasiyas Urga',
              time: '06:03',
              imageName: 'assets/balram.jpg',
              isSeen: true,
              statusNum: 5,
            ),
            const OtherStatus(
              name: 'Samrawit Azmeraw',
              time: '04:25',
              imageName: 'assets/3.jpg',
              isSeen: true,
              statusNum: 2,
            ),
            const OtherStatus(
              name: 'Selam Walelgn',
              time: '11:20',
              imageName: 'assets/1.png',
              isSeen: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget label(String text){
    return Container(
      height: 33,
      width: MediaQuery.of(context).size.width,
      color: Colors.grey[300],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
