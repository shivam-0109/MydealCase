import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PurchasePage extends StatelessWidget {
  const PurchasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Padding(
            padding: EdgeInsets.all(19),
            child: Icon(Icons.arrow_back, color: Colors.black),
          ),
        ),
        centerTitle: true,
        title: Text(
          'Purchase an Exclusive Membership',
          style: GoogleFonts.montserrat(
            color: const Color.fromRGBO(0, 0, 0, 1),
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam tristique massa vel neque feugiat, non viverra ex vehicula. Sed auctor justo nec urna consequat, eget lacinia arcu varius.',
              style: GoogleFonts.montserrat(
                color: const Color.fromRGBO(154, 154, 154, 1),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Current Membership',
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600,
                color: const Color.fromRGBO(0, 0, 0, 1),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),
            _buildMembershipCard(
              'Basic Member',
              'FREE',
              ['Outbound Chats (per day): 10', 'Live Product Listing: 1', 'Rental Service Discount: 2'],
              isSelected: false,
            ),
            const SizedBox(height: 10),
            _buildMembershipCard(
              'Exclusive - 30 days',
              '₹450/day',
              ['Outbound Chats (per day): 50', 'Live Product Listing: 1', 'Rental Service Discount: 2'],
              isSelected: true,
              discount: '₹450/day',
              extraInfo: '10% FLAT OFF',
            ),
            const SizedBox(height: 20),
            _buildProceedButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildMembershipCard(
      String title,
      String price,
      List<String> benefits, {
        bool isSelected = false,
        String? discount,
        String? extraInfo,
      }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isSelected ? Colors.red.shade50 : Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
        border: isSelected ? Border.all(color: Colors.red, width: 2) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              if (isSelected)
                const Icon(Icons.check_circle, color: Colors.red),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            price,
            style: GoogleFonts.montserrat(
              color: Colors.black,
              fontSize: 14,
              decoration: discount != null ? TextDecoration.lineThrough : null,
            ),
          ),
          if (discount != null)
            Text(
              discount,
              style: GoogleFonts.montserrat(
                color: Colors.red,
                fontSize: 14,
              ),
            ),
          const SizedBox(height: 10),
          for (String benefit in benefits)
            Text(
              benefit,
              style: GoogleFonts.montserrat(
                color: Colors.grey.shade700,
                fontSize: 12,
              ),
            ),
          if (extraInfo != null)
            Text(
              extraInfo,
              style: GoogleFonts.montserrat(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildProceedButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Show success message
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Payment Successful'),
                content: const Text('Your membership has been upgraded to Exclusive.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      // Close the dialog
                      Navigator.of(context).pop();
                      // Navigate back to profile page
                      Navigator.of(context).pop();
                      // Update profile page (if needed)
                      // You may need to use a state management solution for this
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );

          // Call API to update membership status in the database
          // Example API call
          // await http.patch(
          //   Uri.parse('your-api-url'),
          //   headers: {'Content-Type': 'application/json'},
          //   body: jsonEncode({
          //     'membershipId': 'exclusive',
          //     'membershipStatus': 'active',
          //   }),
          // );

          // Handle API response

        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          'Pay ₹13,500 to Proceed',
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: PurchasePage(),
  ));
}
