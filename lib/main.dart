import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:autohub_driverside/pages/sample_maps.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:autohub_driverside/pages/account_created_page.dart';
import 'package:autohub_driverside/pages/auto_details_page.dart';
import 'package:autohub_driverside/pages/bidding_page.dart';
import 'package:autohub_driverside/pages/destination_page.dart';
import 'package:autohub_driverside/pages/driver_info_page.dart';
import 'package:autohub_driverside/pages/home_intro_page.dart';
import 'package:autohub_driverside/pages/home_page.dart';
import 'package:autohub_driverside/pages/login_page.dart';
import 'package:autohub_driverside/pages/otp_page.dart';
import 'package:autohub_driverside/pages/map_ride_price_page.dart';
import 'package:autohub_driverside/pages/profile_completion_page.dart';
import 'package:autohub_driverside/pages/ride_completion.dart';
import 'package:autohub_driverside/pages/ride_confirmation_page.dart';
import 'package:autohub_driverside/pages/search_page.dart';
import 'package:autohub_driverside/pages/sign_in_page.dart';
import 'package:autohub_driverside/pages/sign_up_page.dart';
import 'package:autohub_driverside/pages/user_bid_page.dart';
import 'package:autohub_driverside/pages/user_details_page.dart';
import 'package:autohub_driverside/styles/app_colors.dart';
import 'package:autohub_driverside/pages/bidding_page_ds.dart'; // driver
import 'package:autohub_driverside/pages/driver_bids_page.dart'; // driver
import 'package:autohub_driverside/pages/ride_details_page.dart'; // driver
import 'package:autohub_driverside/pages/auto_details_ds.dart'; // driver
import 'package:autohub_driverside/pages/profile_driver.dart'; // driver
import 'package:autohub_driverside/pages/driver_earning_ds.dart'; // driver
import 'package:autohub_driverside/pages/ride_not.dart'; // driver

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "Lexend",
        scaffoldBackgroundColor: AppColors.backgroundColor,
      ),
      initialRoute: '/bidpage1',
      routes: {
        '/': (context) => LoginPage(),
        '/ride': (context) => MapRidePricePage(),
        '/homepage': (context) => HomePage(),
        '/searchpage': (context) => SearchPage(),
        '/ridecompletion': (context) => RideCompletion(),
        '/Auto_details': (context) => BookingPage(),
        '/userdetails': (context) => UserDetailsPage(),
        '/driverinfo': (context) => DriverDetailsPage(),
        '/homeintro': (context) => SplashScreen(),
        '/signin': (context) => SigninPage(),
        '/otp': (context) => OTPPage(),
        '/signup': (context) => SignupPage(),
        '/bidding': (context) => DriverListPage(),
        '/profilecompletion': (context) => ProfilePage(),
        '/accountcreation': (context) => AccountCreatedPage(),
        '/destination': (context) => DestinationPage(),
        '/rideconfirmation': (context) => RideConfirmationPage(),
        '/userbidpage': (context) => UserBidPage(),
        '/samplemap': (context) => SampleMaps(),
        // driver side
        '/bidpage1': (context) => BiddingPage(),
        '/bidpage2': (context) => DriverBidsPage(driverName: 'YourDriverName', destination: '',), // Pass driverName
        '/ridedetail': (context) => RideDetailsPage(),
        '/bookpgm': (context) => BookingPagem(),
        '/vehicleinfo': (context) => VehicleDetailsPage(),
        '/driverearn': (context) => DriverEarningsPage(),
        '/notride': (context) => RideNotReceivedPage(),
      },
    );
  }
}
