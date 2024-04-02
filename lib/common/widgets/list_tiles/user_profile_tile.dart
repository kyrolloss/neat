import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:neat/common/widgets/custom_shapes/containers/circular_container.dart';

import '../../../cubit/app_cubit.dart';
import '../../../utlis/constants/colors.dart';
import '../../../utlis/constants/image_strings.dart';
import '../images/circular_image.dart';

class TUserProfileTile extends StatelessWidget {
  const TUserProfileTile({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return ListTile(
          leading: Container(
              height: 120,
              width: 120,
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
                  : ClipOval(
                      child: Image(
                        image: AssetImage('assets/images/user/user.png'),
                        fit: BoxFit.cover,
                      ),
                    )),
          title: Text(cubit.name,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .apply(color: Colors.white)),
          subtitle: Text(
            cubit.title,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .apply(color: TColors.secondaryColor),
          ),
          trailing: IconButton(
              onPressed: onPressed,
              icon: const Icon(
                Iconsax.edit,
                color: TColors.backgroundColor,
              )),
        );
      },
    );
  }
}
