import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moniepoint/features/bottom_appbar/presentation/widgets/custom_appbar.dart';

class CustomBottomAppbarView extends StatelessWidget {
  const CustomBottomAppbarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Bottom App Bar Example'),
      ),
      body: Center(
        child: Text('This is the body of the page.'),
      ),
      bottomNavigationBar: CustomBottomAppBar(
        color: Colors.blue, // Set your desired color
        child: SizedBox(
          height: 56, // Set the height of the bottom app bar
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(Icons.home),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.favorite),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
