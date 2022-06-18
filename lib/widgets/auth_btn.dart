import 'package:asensiofinal/Animation/fade_animation.dart';
import 'package:flutter/material.dart';

class AuthBtn extends StatelessWidget {
  final bool isLoading;
  final String text;
  final VoidCallback onTap;
  const AuthBtn({required this.isLoading,required this.text,required this.onTap});
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: FadeAnimation(
                                  2,
                                  Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        gradient: const LinearGradient(colors: [
                                          Color.fromRGBO(143, 148, 251, 1),
                                          Color.fromRGBO(143, 148, 251, .6),
                                        ])),
                                    child:  Center(
                                      child: 
                                      isLoading?
                                      const CircularProgressIndicator(
                                        color: Colors.white
                                      )
                                      :
                                      Text(
                                        text,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )),
    );
  }
}