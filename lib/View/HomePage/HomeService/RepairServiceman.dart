import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RepairServiceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Repair Service',
          style: GoogleFonts.montserrat(
              color: const Color.fromRGBO(0, 0, 0, 1),
              fontWeight: FontWeight.w600,
              fontSize: 18),
        ),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            const SafeArea(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'All',
                      style: TextStyle(
                          color: Color.fromRGBO(232, 80, 91, 1),
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'HomeServices',
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'CarServices',
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Packers and Movers',
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Electronics Repair',
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Electronics',
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Electronics',
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Electronics',
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    ),
                  ),
                ]),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(16),
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: RepairServiceCard(
                          name: 'John Doe',
                          rating: 4.5,
                          imageUrl: 'assets/images/repairman.png',
                          onPressed: () {
                            Navigator.pushNamed(context,'HomeServiceScreen');
                          },
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: RepairServiceCard(
                          name: 'Jane Smith',
                          rating: 4.2,
                          imageUrl: 'assets/images/repairman.png',
                          onPressed: () {
                            // Add your logic here for tapping the card
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: RepairServiceCard(
                          name: 'John Doe',
                          rating: 4.5,
                          imageUrl: 'assets/images/repairman.png',
                          onPressed: () {
                            // Add your logic here for tapping the card
                          },
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: RepairServiceCard(
                          name: 'Jane Smith',
                          rating: 4.2,
                          imageUrl: 'assets/images/repairman.png',
                          onPressed: () {
                            // Add your logic here for tapping the card
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: RepairServiceCard(
                          name: 'John Doe',
                          rating: 4.5,
                          imageUrl: 'assets/images/repairman.png',
                          onPressed: () {
                            // Add your logic here for tapping the card
                          },
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: RepairServiceCard(
                          name: 'Jane Smith',
                          rating: 4.2,
                          imageUrl: 'assets/images/repairman.png',
                          onPressed: () {
                            // Add your logic here for tapping the card
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: RepairServiceCard(
                          name: 'John Doe',
                          rating: 4.5,
                          imageUrl: 'assets/images/repairman.png',
                          onPressed: () {
                            // Add your logic here for tapping the card
                          },
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: RepairServiceCard(
                          name: 'Jane Smith',
                          rating: 4.2,
                          imageUrl: 'assets/images/repairman.png',
                          onPressed: () {
                            // Add your logic here for tapping the card
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: RepairServiceCard(
                          name: 'John Doe',
                          rating: 4.5,
                          imageUrl: 'assets/images/repairman.png',
                          onPressed: () {
                            // Add your logic here for tapping the card
                          },
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: RepairServiceCard(
                          name: 'Jane Smith',
                          rating: 4.2,
                          imageUrl: 'assets/images/repairman.png',
                          onPressed: () {
                            // Add your logic here for tapping the card
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RepairServiceCard extends StatelessWidget {
  final String name;
  final double rating;
  final String imageUrl;
  final VoidCallback? onPressed;

  const RepairServiceCard({
    required this.name,
    required this.rating,
    required this.imageUrl,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        color: Colors.white,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(Icons.favorite,color: Colors.grey,),
                  onPressed: () {
                    // Add your logic here for tapping the favorite icon
                  },
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(imageUrl),
                ),
              ),
              SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.montserrat(
                      color: Color.fromRGBO(114, 114, 114, 1),
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    'Television Repair',
                    style: GoogleFonts.montserrat(
                      color: const Color.fromRGBO(0, 0, 0, 1),
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 16,
                      ),
                      SizedBox(width: 4),
                      Text(
                        rating.toString(),
                        style: GoogleFonts.montserrat(
                          color: const Color.fromRGBO(0, 0, 0, 1),
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '( 135 Reviews )',
                        style: GoogleFonts.montserrat(
                          color: Color.fromRGBO(114, 114, 114, 1),
                          fontWeight: FontWeight.w600,
                          fontSize: 8,
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        '₹ 500',
                        style: GoogleFonts.montserrat(
                          color: const Color.fromRGBO(0, 0, 0, 1),
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


