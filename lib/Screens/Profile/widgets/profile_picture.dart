import 'package:flutter/cupertino.dart';

import '../../../cubit/app_cubit.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    super.key,
    required this.cubit, required this.width, required this.height,
  });

  final AppCubit cubit;
  final double width , height ;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: cubit.url != null && cubit.url!.isNotEmpty
            ? ClipOval(
                child: Image.network(
                  cubit.url!,
                  fit: BoxFit.cover,
                ),
              )
            : const ClipOval(
                child: Image(
                  image: AssetImage('assets/images/user/user.png'),
                  fit: BoxFit.cover,
                ),
              ));
  }
}
