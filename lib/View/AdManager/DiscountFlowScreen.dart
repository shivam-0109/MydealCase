import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DiscountFlowScreen extends StatefulWidget {
  @override
  State<DiscountFlowScreen> createState() => _DiscountFlowScreenState();
}

class _DiscountFlowScreenState extends State<DiscountFlowScreen> {
  String type = 'Select Items';

  List<String> Type = ['Select Items', 'Mobile', 'Laptop','Appliances'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Discounts',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Discount Name',
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color.fromRGBO(125, 125, 125, 1),),
                  ),
                ),
                style: GoogleFonts.montserrat(
                  color:const Color.fromRGBO(125, 125, 125, 1),
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Discount Percentage',
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color:Color.fromRGBO(125, 125, 125, 1),),
                  ),
                ),
                style: GoogleFonts.montserrat(
                color:const Color.fromRGBO(125, 125, 125, 1),
                fontWeight: FontWeight.w500,
                  fontSize: 14,
                 ),
              ),
             const  SizedBox(height: 50),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'From Date',
                        style: GoogleFonts.montserrat(
                          color:const Color.fromRGBO(125, 125, 125, 1),
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                      const  SizedBox(height: 10),
                      Container(
                        height: 40,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[200],
                        ),
                        alignment: Alignment.center,
                        child: const TextField(
                          decoration: InputDecoration(
                            hintText: 'e.g 12 Nov',
                            border: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color.fromRGBO(125, 125, 125, 1),),
                            ),
                            contentPadding: EdgeInsets.all(10),
                          ),
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Center(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 50),
                        height: 2,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'To Date',
                        style: GoogleFonts.montserrat(
                          color:const Color.fromRGBO(125, 125, 125, 1),
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                      const  SizedBox(height: 10),
                      Container(
                        height: 40,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),

                          color: Colors.grey[200],
                        ),
                        alignment: Alignment.center,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'e.g 15 Nov',
                            border: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                              borderSide:const BorderSide(color:const Color.fromRGBO(125, 125, 125, 1),),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: EdgeInsets.all(10),
                          ),
                          style: GoogleFonts.montserrat(
                            color:const Color.fromRGBO(125, 125, 125, 1),
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 50),
              DropdownButtonFormField<String>(
                value: type,
              style: GoogleFonts.montserrat(
              color:const Color.fromRGBO(125, 125, 125, 1),
                   fontWeight: FontWeight.w500,
                  fontSize: 14,
               ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide:const BorderSide(color:const Color.fromRGBO(125, 125, 125, 1),),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                items: Type.map((type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    type = value!;
                  });
                },
              ),
              const SizedBox(height: 100,),
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Container(
                    alignment: Alignment.center,
                    height: 34,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromRGBO(44, 42, 42, 1),
                    ),
                    child: Text(
                      'Save',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
