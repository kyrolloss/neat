import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:neat/Screens/Profile/performance/performance.dart';
import 'package:neat/components/color.dart';

import '../../Screens/Profile/widgets/profile_picture.dart';
import '../../Screens/chat/chat_screen.dart';
import '../../Screens/chat/widgets/user_tile.dart';
import '../../common/widgets/appbar/appbar.dart';
import '../../common/widgets/custom_shapes/containers/circular_container.dart';
import '../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../components/components.dart';
import '../../cubit/app_cubit.dart';
import '../../utlis/constants/colors.dart';
import '../../utlis/constants/sizes.dart';

class AdminPerformance extends StatelessWidget {
  const AdminPerformance({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);

        return Scaffold(
          appBar:   TAppBar(
            backgroundColor: TColors.primaryColor,
            iconColor: Colors.white,
            leadingIcon: Iconsax.arrow_left,
            title: Text("Check Your Team's Performance",
                style: Theme.of(context).textTheme.headlineSmall!.apply(
                    color: Colors.white,
                    fontWeightDelta: 2,
                    fontSizeDelta: -8,
                    letterSpacingDelta: 1)),
          ),
          backgroundColor: AppColor.primeColor,
          body: Column(
            children: [
              TPrimaryHeaderContainer(
                  child: Column(
                children: [
                  /// -- AppBar


                  /// User Profile Card

                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                ],
              )),
              Expanded(
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25)),
                    child: StreamBuilder(
                      stream: cubit.getTeamStream(),
                      builder: (context, snapshot) {
                        /// error
                        if (snapshot.hasError) {
                          return const Text("Error");
                        }

                        /// loading
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        /// return listview
                        if (!snapshot.hasData) {
                          return const Text("no members..");
                        }


                        return ListView(
                          children: snapshot.data!
                              .map<Widget>((userData) =>
                                  _buildUserListItem(userData, context))
                              .toList(),
                        );
                      },
                    )),
              ),
            ],
          ),
        );
      },
    );
  }
  Widget _buildUserListItem(Map<String, dynamic> userData,
      BuildContext context) {
    /// display all users except current user
    if (userData['email'] !=
        AppCubit.get(context).getCurrentUser()!.email) {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: TCircularContainer(
          child: UserTile(
            text: userData['name'],
            onTap: () async {
              await AppCubit.get(context)
                  .adminGetPerformance(context: context , receiverId: userData['uid']);

              /// pass the clicked user's UID to the chat page
            },
          ),
        ),
      );
    } else {
      /// return empty container
      return Container();
    }
  }
}
