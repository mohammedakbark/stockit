import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class mavorder extends StatefulWidget {
  const mavorder({super.key});

  @override
  State<mavorder> createState() => _mavorderState();
}

class _mavorderState extends State<mavorder> {
  int _selectedindex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
         leading: IconButton(onPressed: (){
          Navigator.pop(context);
         }, icon:Icon(Icons.arrow_back_ios_sharp) ),
        title: Text(
          'Orders',
          style: GoogleFonts.inknutAntiqua(fontSize: 30),
        ),
        backgroundColor: const Color.fromARGB(136, 255, 255, 255),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/image 5.png'), fit: BoxFit.cover)),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 80, bottom: 30, left: 30, right: 30),
          child: Container(
            color: const Color.fromARGB(181, 12, 12, 12),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: 3,
                      itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.only(
                                top: 20, left: 20, right: 20, bottom: 20),
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color.fromARGB(185, 255, 255, 255)),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, bottom: 10, left: 10,),
                                      child: Image.asset('images/chilli.png'),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20,bottom: 10),
                                      child: Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Chilli',
                                              style: GoogleFonts.inknutAntiqua(
                                                  fontSize: 20)),
                                          const Row(
                                            children: [
                                              Icon(Icons.currency_rupee_sharp),
                                              Text(
                                                '35/Kg',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w500),
                                              )
                                            ],
                                          ),
                                             Padding(
                                               padding: const EdgeInsets.only(left: 8),
                                               child: Text('1kg',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w500)),
                                             ),
                                           Padding(
                                               padding: const EdgeInsets.only(left: 8),
                                               child: Text('Date:',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w500)),
                                             ),        
                                        ],
                                      ),
                                    )
                                  ],
                                )),
                          )),
                ),
                        
              ],
            ),
                  
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: true,
          elevation: 0,
          backgroundColor: const Color.fromARGB(139, 255, 255, 255),
          items: [
            const BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: 35,
                ),
                label: ('Home')),
            const BottomNavigationBarItem(
                icon: Icon(
                  Icons.library_books_rounded,
                  size: 35,
                ),
                label: ('Items')),
            const BottomNavigationBarItem(
                icon: Icon(Icons.production_quantity_limits_rounded, size: 35),
                label: ('Orders')),
                const BottomNavigationBarItem(
                icon: Icon(Icons.local_offer, size: 35),
                label: ('Special item')),
          ],
          currentIndex: _selectedindex,
          selectedItemColor: const Color.fromARGB(255, 100, 74, 1),
          unselectedItemColor: Colors.black,
          onTap: (index) {
            setState(() {
              _selectedindex = index;
            });
          }),
    );
  }
}