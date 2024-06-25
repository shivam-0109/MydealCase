import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'purchase_page.dart';

class CurrentMembershipPage extends StatelessWidget {
  const CurrentMembershipPage({super.key});

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
          'Current Membership',
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
          children: [
            _buildMembershipTable(),
            const SizedBox(height: 20),
            _buildUsageCard(),
            const SizedBox(height: 20),
            _buildUpgradeButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildMembershipTable() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(1),
          1: FlexColumnWidth(1),
          2: FlexColumnWidth(1),
        },
        border: TableBorder.all(color: Colors.grey.withOpacity(0.5)),
        children: [
          _buildTableRow(
            ['Current Membership', 'Basic Member', 'Exclusive Member'],
            isHeader: true,
          ),
          _buildTableRow(['Outbound Chats (per day)', '5/month', '12/month']),
          _buildTableRow(['Live Product Listing', '1/month', '4/month']),
          _buildTableRow(['Rental Service Discount', '-', '10% FLAT']),
        ],
      ),
    );
  }

  TableRow _buildTableRow(List<String> cells, {bool isHeader = false}) {
    return TableRow(
      children: cells.map((cell) {
        return Container(
          padding: const EdgeInsets.all(8.0),
          color: isHeader ? Colors.red.shade50 : Colors.white,
          child: Text(
            cell,
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontWeight: isHeader ? FontWeight.w600 : FontWeight.w400,
              color: isHeader ? Colors.black : Colors.grey.shade700,
              fontSize: 12,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildUsageCard() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Usage',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 10),
          _buildUsageRow('Chats Initiated (today)', '0 out of 5'),
          _buildUsageRow('Live Product Listing', '0'),
          _buildUsageRow('Rental Service Discount', '1 out of 1'),
        ],
      ),
    );
  }

  Widget _buildUsageRow(String title, String usage) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            title,
            style: GoogleFonts.montserrat(
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
          const Spacer(),
          Text(
            usage,
            style: GoogleFonts.montserrat(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 12),
        ],
      ),
    );
  }

  Widget _buildUpgradeButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PurchasePage()),
          );
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          'Upgrade Exclusive Membership',
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
    home: CurrentMembershipPage(),
  ));
}
