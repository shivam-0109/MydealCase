import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_deal_case/View/HomePage/BuysellPage/Buy_Sell.dart';
import 'package:my_deal_case/View/HomePage/Rentalpage/Rental.dart';
import 'package:my_deal_case/View/HomePage/servicesPage/Services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  Widget _buildTextButton(String label, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
          _pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _selectedIndex == index
                ? Color.fromRGBO(44, 42, 42, 1)
                : Colors.transparent,
            width: 1,
          ),
          color: _selectedIndex == index
              ? Color.fromRGBO(44, 42, 42, 1)
              : Colors.transparent,
        ),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(
          label,
          style: TextStyle(
            color: _selectedIndex == index ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // Add padding from the top here
        toolbarHeight: 100.0, // Adjust the height as needed

        title: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(
                left: 0,
                right: 10,
              ),
              child: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage("assets/images/avatar.png"),
              ),
            ),
            SizedBox(
              width: 170,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, 'MyAddress');
                        },
                        child: const Text(
                          'Home',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(232, 80, 91, 1),
                          ),
                        ),
                      ),
                      SvgPicture.asset('assets/images/arrowDown.svg'),
                    ],
                  ),
                  const Text(
                    'Sector 125, Raipur, Khaddar, Noida, UP',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(132, 132, 132, 1),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding:
                const EdgeInsets.only(left: 15, top: 15, right: 10, bottom: 15),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, 'searchBar');
              },
              child: SvgPicture.asset('assets/images/search.svg'),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 15, top: 15, right: 25, bottom: 15),
            child: SvgPicture.asset('assets/images/bellIcon.svg'),
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: const [
          BuySell(),
          RentalPage(),
          ServicesPage(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 35),
        child: Container(
          alignment: Alignment.center,
          height: 45,
          width: 270,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(255, 255, 255, 1),
            border: Border.all(
              width: 1,
              color: const Color.fromRGBO(0, 0, 0, 0.15),
            ),
            borderRadius: BorderRadius.circular(36),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildTextButton('Buy/Sell', 0),
              _buildTextButton('Rental', 1),
              _buildTextButton('Services', 2),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
