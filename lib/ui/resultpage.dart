import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'homepage.dart';

class ResultPage extends StatefulWidget {
  // Home({super.key});

  const ResultPage({Key? key}) : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {



  final Box _boxPaymentResult = Hive.box("paymentResult");
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
        onWillPop: () => Future.value(false),
                            child:  Scaffold(
      appBar: AppBar(
        title: const Text("Payment Result"),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white),
              ),
              child: IconButton(
                onPressed: () {
                  _boxPaymentResult.clear();
                  // _boxPaymentResult.put("loginStatus", false);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const HomePage();
                      },
                    ),
                  );
                },
                // icon: const Icon(Icons.logout_rounded),
                icon: const Icon(Icons.assignment_return_rounded),
              ),
            ),
          )
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              const SizedBox(height: 50),
              Text(
                "🎉 Welcome 🎉",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              // const SizedBox(height: 10),
              // Text(
              //   "Welcome 🎉",
              //   style: Theme.of(context).textTheme.bodyMedium,
              // ),
              const SizedBox(height: 35),
              TextFormField(
                enabled: false,
                readOnly: true,
                // controller: _controllerUsername,
                initialValue: "Welcome 🎉",
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: "Welcome 🎉",
                  // prefixIcon: const Icon(Icons.person_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                enabled: false,
                readOnly: true,
                // controller: _controllerUsername,
                initialValue: _boxPaymentResult.get("paymentStatus"),
                decoration: InputDecoration(
                  labelText: "Payment Status",
                  // prefixIcon: const Icon(Icons.person_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                enabled: false,
                readOnly: true,
                // controller: _controllerUsername,
                initialValue: _boxPaymentResult.get("paymentAmount"),
                decoration: InputDecoration(
                  labelText: "Payment Amount",
                  // prefixIcon: const Icon(Icons.person_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                enabled: false,
                readOnly: true,
                // controller: _controllerUsername,
                initialValue: _boxPaymentResult.get("customerMobile"),
                decoration: InputDecoration(
                  labelText: "Customer Mobile",
                  // prefixIcon: const Icon(Icons.person_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                enabled: false,
                readOnly: true,
                // controller: _controllerUsername,
                initialValue: _boxPaymentResult.get("customerEmail"),
                decoration: InputDecoration(
                  labelText: "Customer Email",
                  // prefixIcon: const Icon(Icons.person_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                enabled: false,
                readOnly: true,
                // controller: _controllerUsername,
                initialValue: _boxPaymentResult.get("paymentRefence"),
                decoration: InputDecoration(
                  labelText: "Refrence Code",
                  // prefixIcon: const Icon(Icons.person_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                enabled: false,
                readOnly: true,
                // controller: _controllerUsername,
                initialValue: _boxPaymentResult.get("paymentMessage"),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: "Payment Result",
                  // prefixIcon: const Icon(Icons.person_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    ),
    );




  }






}






















































//
// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
//
// import 'homepage.dart';
//
// class Home extends StatelessWidget {
//   Home({super.key});
//
//   final Box _boxPaymentResult = Hive.box("paymentResult");
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Payment Result"),
//         elevation: 0,
//         actions: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: DecoratedBox(
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 border: Border.all(color: Colors.white),
//               ),
//               child: IconButton(
//                 onPressed: () {
//                   _boxPaymentResult.clear();
//                   // _boxPaymentResult.put("loginStatus", false);
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) {
//                         return const HomePage();
//                       },
//                     ),
//                   );
//                 },
//                 // icon: const Icon(Icons.logout_rounded),
//                 icon: const Icon(Icons.assignment_return_rounded),
//               ),
//             ),
//           )
//         ],
//       ),
//       backgroundColor: Theme.of(context).colorScheme.primary,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               "Welcome 🎉",
//               style: Theme.of(context).textTheme.bodyLarge,
//             ),
//             const SizedBox(height: 10),
//             Text(
//               " Status: ${_boxPaymentResult.get("paymentStatus")} ",
//               style: Theme.of(context).textTheme.bodyLarge,
//             ),
//
//             const SizedBox(height: 10),
//             Text(
//               " Amount: ${_boxPaymentResult.get("paymentAmount")} ",
//               style: Theme.of(context).textTheme.bodyLarge,
//             ),
//
//
//             const SizedBox(height: 10),
//             Text(
//               " Customer Mobile:${_boxPaymentResult.get("customerMobile")} ",
//               style: Theme.of(context).textTheme.bodyLarge,
//             ),
//
//             const SizedBox(height: 10),
//             Text(
//               " Customer Email:${_boxPaymentResult.get("customerEmail")} ",
//               style: Theme.of(context).textTheme.bodyLarge,
//             ),
//
//             const SizedBox(height: 10),
//             Text(
//               " Refrence Code:${_boxPaymentResult.get("paymentRefence")} ",
//               style: Theme.of(context).textTheme.bodyLarge,
//             ),
//
//             const SizedBox(height: 10),
//             Text(
//               " ${_boxPaymentResult.get("paymentMessage")} ",
//               style: Theme.of(context).textTheme.bodyLarge,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
