import "package:flutter/material.dart";

class Loading extends StatelessWidget {
  const Loading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: const Center(
        child:
            SizedBox(width: 40, height: 40, child: CircularProgressIndicator()),
      ),
    );
  }
}
