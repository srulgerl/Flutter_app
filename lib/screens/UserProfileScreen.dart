import 'package:ecommerce/providers/app_auth_provider.dart';
import 'package:ecommerce/routes/routes.dart';
import 'package:ecommerce/widgets/ProfileMenuItem.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class Userprofilescreen extends StatefulWidget {
  const Userprofilescreen({super.key});

  @override
  State<Userprofilescreen> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<Userprofilescreen> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AppAuthProvider>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                "Profile",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(223, 37, 37, 37),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                            'https://images.unsplash.com/photo-1615751072497-5f5169febe17?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8Y3V0ZSUyMGRvZ3xlbnwwfHwwfHx8MA%3D%3D',
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                authProvider.displayName ?? "guest",
                                // '${provider.username?.capitalize()} ',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                        // DropdownButton<String>(
                        //   value:
                        //       Provider.of<LocaleModel>(
                        //         context,
                        //       ).locale?.languageCode ??
                        //       'en',
                        //   items: const [
                        //     DropdownMenuItem(
                        //       value: 'en',
                        //       child: Text('English'),
                        //     ),
                        //     DropdownMenuItem(
                        //       value: 'mn',
                        //       child: Text('Монгол'),
                        //     ),
                        //   ],
                        //   onChanged: (value) {
                        //     if (value != null) {
                        //       Provider.of<LocaleModel>(
                        //         context,
                        //         listen: false,
                        //       ).setLocale(Locale(value));
                        //     }
                        //   },
                        // ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ProfileMenuItem(
                      icon: Icons.shopping_bag_outlined,
                      title: "My Orders",
                      onTap: () {},
                    ),
                    ProfileMenuItem(
                      icon: Icons.home,
                      title: "Shipping Addresses",
                      onTap: () {},
                    ),
                    const Divider(),
                    ProfileMenuItem(
                      icon: Icons.payment_rounded,
                      title: "Promotion Codes",
                      onTap: () {},
                    ),
                    ProfileMenuItem(
                      icon: Icons.qr_code,
                      title: "My Reviews",
                      onTap: () {},
                    ),
                    ProfileMenuItem(
                      icon: Icons.settings,
                      title: "Settings",
                      onTap: () {},
                    ),
                    const Spacer(),
                    ElevatedButton.icon(
                      onPressed: () async {
                        await authProvider.signOut();
                        print(FirebaseAuth.instance.currentUser != null);
                        context.go(AppRoutes.login); // redirect to login screen
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 24,
                        ),
                      ),
                      icon: const Icon(Icons.logout),
                      label: const Text("Гарах"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
