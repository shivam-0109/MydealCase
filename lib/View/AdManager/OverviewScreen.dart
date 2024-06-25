import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart'; // Import fl_chart package

class OverviewScreen extends StatefulWidget {
  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  String past = 'Last 7 Days';
  List<String> Past = ['Last 7 Days', 'Last 15 Days', 'Last 1 month'];

  // Sample data for line chart
  final List<FlSpot> sampleData = [
    FlSpot(0, 1050), // Monday
    FlSpot(1, 2000), // Tuesday
    FlSpot(2, 3000), // Wednesday
    FlSpot(3, 4100), // Thursday
    FlSpot(4, 5000), // Friday
    FlSpot(5, 3300), // Saturday
    FlSpot(6, 5000), // Sunday
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(
          'Dashboard',
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
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: InkWell(
                    onTap: () {},
                    child: const Padding(
                      padding: EdgeInsets.only(left: 6),
                      child: Icon(
                        Icons.search,
                        color: Color.fromRGBO(164, 164, 164, 1),
                        size: 15,
                      ),
                    ),
                  ),
                  filled: true,
                  fillColor: const Color.fromRGBO(245, 245, 245, 1),
                  contentPadding: const EdgeInsets.only(top: 10),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Search',
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(164, 164, 164, 1),
                  ),
                ),
                cursorColor: Colors.grey,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildSalesCard('assets/admanager/c1.png'),
                  _buildSalesCard('assets/admanager/c2.png'),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildSalesCard('assets/admanager/c3.png'),
                  _buildSalesCard('assets/admanager/c4.png'),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Sales Report',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(width: 100),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: past,
                      style: GoogleFonts.montserrat(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                      items: Past.map((type) {
                        return DropdownMenuItem<String>(
                          value: type,
                          child: Text(type),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          past = value!;
                        });
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 200,
                  child: LineChart(
                    LineChartData(
                      gridData: FlGridData(
                        show: false,
                        horizontalInterval:
                            1000.0, // Interval between horizontal grid lines
                        verticalInterval:
                            1.0, // Interval between vertical grid lines
                      ),
                      titlesData: FlTitlesData(
                        bottomTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 22,
                          getTitles: (value) {
                            switch (value.toInt()) {
                              case 0:
                                return 'Mon';
                              case 1:
                                return 'Tue';
                              case 2:
                                return 'Wed';
                              case 3:
                                return 'Thu';
                              case 4:
                                return 'Fri';
                              case 5:
                                return 'Sat';
                              case 6:
                                return 'Sun';
                              default:
                                return '';
                            }
                          },
                        ),
                        leftTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 28,
                          getTitles: (value) {
                            if (value % 1000 == 0) {
                              return '${(value / 1000).toInt()}k';
                            }
                            return '';
                          },
                        ),
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      minX: 0,
                      maxX: 6,
                      minY: 0,
                      maxY: 6000,
                      lineBarsData: [
                        LineChartBarData(
                          spots: sampleData,
                          isCurved: true,
                          colors: [
                            const Color.fromRGBO(232, 80, 91, 1),
                          ],
                          barWidth: 2,
                          isStrokeCapRound: false,
                          belowBarData: BarAreaData(show: false),
                        ),
                      ],
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

  Widget _buildSalesCard(String imagePath) {
    return Expanded(
      child: Card(
        color: const Color.fromRGBO(243, 244, 246, 1),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: ClipOval(
                      child: Image(
                        image: AssetImage(imagePath),
                        height: 24,
                        width: 24,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '15%',
                    style: GoogleFonts.montserrat(
                      color: const Color.fromRGBO(25, 146, 25, 1),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Total Sales',
                style: GoogleFonts.montserrat(
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '300',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
