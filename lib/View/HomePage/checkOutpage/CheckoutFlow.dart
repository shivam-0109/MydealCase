import 'package:another_stepper/another_stepper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Checkoutflow extends StatelessWidget {
  List<StepperData> stepperData =[
    StepperData(
      title: StepperText("Product Order Recieved",
        textStyle: GoogleFonts.montserrat(
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),),
      subtitle: StepperText("02 may 2024 | 02:00 PM",
        textStyle: GoogleFonts.montserrat(
          color: Color.fromRGBO(114, 114, 114, 1),
          fontWeight: FontWeight.w400,
          fontSize: 12,
        ),),
      iconWidget: Container(
        padding: EdgeInsets.all(4), // Adjusted padding
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color.fromRGBO(232, 80, 91, 1),
        ),
        child: Icon(Icons.check,color: Colors.white,size: 18,),
      )
    ),
    StepperData(
        title: StepperText("Product Sent",
          textStyle: GoogleFonts.montserrat(
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),),
        subtitle: StepperText("04 may 2024 | 02:00 PM",
          textStyle: GoogleFonts.montserrat(
            color: Color.fromRGBO(114, 114, 114, 1),
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),),
        iconWidget: Container(
          padding: EdgeInsets.all(4), // Adjusted padding
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color.fromRGBO(232, 80, 91, 1),
          ),
          child: Icon(Icons.check,color: Colors.white,size: 18,),
        )
    ),
    StepperData(
        title: StepperText("Product Arrived",
          textStyle: GoogleFonts.montserrat(
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),),
        subtitle: StepperText("",
          textStyle: GoogleFonts.montserrat(
            color: Color.fromRGBO(114, 114, 114, 1),
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),),
        iconWidget: Container(
          padding: EdgeInsets.all(4), // Adjusted padding
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color:  const Color.fromRGBO(232, 80, 91, 1),
              width: 3
            ),
            color: Colors.white,
          ),

        )
    ),
    StepperData(
        title: StepperText("Product Delivered",
          textStyle: GoogleFonts.montserrat(
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),),
        subtitle: StepperText("",
          textStyle: GoogleFonts.montserrat(
            color: Color.fromRGBO(114, 114, 114, 1),
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),),
        iconWidget: Container(
          padding: EdgeInsets.all(4), // Adjusted padding
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
                color:  const Color.fromRGBO(232, 80, 91, 1),
                width: 3
            ),
            color: Colors.white,
          ),

        )
    ),
    StepperData(
        title: StepperText("Paid",
          textStyle: GoogleFonts.montserrat(
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),),
        subtitle: StepperText("",
          textStyle: GoogleFonts.montserrat(
            color: Color.fromRGBO(114, 114, 114, 1),
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),),
        iconWidget: Container(
          padding: EdgeInsets.all(4), // Adjusted padding
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
                color:  const Color.fromRGBO(232, 80, 91, 1),
                width: 3
            ),
            color: Colors.white,
          ),

        )
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: (){
              Navigator.pushNamed(context, 'ProductDetails');
            },
            icon: Icon(Icons.arrow_back_ios,color: Colors.black,size: 20,)),
        title: Text(
          'Checkout',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Card(
                color: const Color.fromRGBO(255, 255, 255, 1),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selected product',
                        style: GoogleFonts.montserrat(
                          color: const Color.fromRGBO(0, 0, 0, 1),
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: const Color.fromRGBO(245, 245, 245, 1),
                            ),
                            child: Center(
                              child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: Image.asset(
                                    'assets/admanager/iphone.png'), // Replace with your CircleAvatar or image
                              ),
                            ),
                          ),
                          SizedBox(width: 15,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Vishal Sharma',
                                style: GoogleFonts.montserrat(
                                  color: const Color.fromRGBO(232, 80, 91, 1),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                'Swift Dzire F9 AMT',
                                style: GoogleFonts.montserrat(
                                  color: const Color.fromRGBO(0, 0, 0, 1),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 30),
                          Text(
                            '\$ 7000',
                            style: GoogleFonts.montserrat(
                              color: const Color.fromRGBO(232, 80, 91, 1),
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.location_pin,color: const Color.fromRGBO(232, 80, 91, 1),size: 17,),
                          SizedBox(
                            width: 9,
                          ),
                          Text(
                            'Mayo College , Ajmer',
                            style: GoogleFonts.montserrat(
                              color: const Color.fromRGBO(92, 92, 92, 1),
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.punch_clock,color: const Color.fromRGBO(232, 80, 91, 1),size: 17,),
                          SizedBox(
                            width: 9,
                          ),
                          Text(
                            '02:00 PM',
                            style: GoogleFonts.montserrat(
                              color: const Color.fromRGBO(92, 92, 92, 1),
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 20,left: 50),
              child: AnotherStepper(
                stepperList: stepperData,
               // inActiveBarColor: Colors.black,
                inActiveBarColor:   Color.fromRGBO(232, 80, 91, 1),
                stepperDirection: Axis.vertical,
                iconHeight: 30, // Adjusted icon height
                iconWidth: 30, // Adjusted icon width
              ),
            )

          ],
        ),
      ),
      bottomNavigationBar: Row(
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 9,),
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Container(
                alignment: Alignment.center,
                height: 34,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  border: Border.all(
                    color: Color.fromRGBO(232, 80, 91, 1),
                    width: 2
                  )
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 9,),
                  Icon(Icons.book,color: const Color.fromRGBO(232, 80, 91, 1),size: 17,),
                SizedBox(
                  width: 9,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Invoice #1001f55',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                            color: Colors.black,
                          ),
                        ),

                        Text(
                          '12/04/2024',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            fontSize: 8,
                            color: const Color.fromRGBO(92, 92, 92, 1),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 9,),
                    Icon(Icons.save_alt,color: const Color.fromRGBO(232, 80, 91, 1),size: 17,),
                    SizedBox(
                      width: 9,),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  alignment: Alignment.center,
                  height: 34,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: Border.all(
                          color: Color.fromRGBO(232, 80, 91, 1),
                          width: 2
                      )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 9,),
                      Icon(Icons.chat,color: const Color.fromRGBO(232, 80, 91, 1),size: 17,),
                      SizedBox(
                        width: 9,),
                      Text(
                        'Chat With partner',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: 9,),
                    ],
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );

  }
}
