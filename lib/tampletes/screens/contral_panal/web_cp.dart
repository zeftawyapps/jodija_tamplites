import 'package:JoDija_view/theams/colors/colors.dart';
import 'package:JoDija_view/util/app_settings/settings_inherted.dart';
import 'package:JoDija_view/util/app_settings/settings_model.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
 import 'package:provider/provider.dart';
 import 'main_logic.dart';
import 'side_bar.dart';

class WebCp extends StatefulWidget {
  const WebCp({super.key});

  @override
  State<WebCp> createState() => _WebCpState();
}

class _WebCpState extends State<WebCp> with TickerProviderStateMixin {
  String oldlen = "ar";
  bool animation = true;
  late AnimationController _animatedContainer;
  @override
  void initState() {
    _animatedContainer = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var dd = SettingChangeLestner.of(context);
    // String lang = dd.state.language!;
    var provider = Provider.of<DashboardMainServices>(context);

    return SafeArea(
      child: Scaffold(
        body: FadeIn(
          controller: (controller) => _animatedContainer = controller,
          animate: animation,
          duration: Duration(seconds: 1),
          child: Container(
            // reach text using q['name']
            decoration: BoxDecoration(

              image: DecorationImage(
                image: AssetImage(
                   provider.logo,
                ),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              children: [
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(

                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.7),
                          blurRadius: 50,
                          offset: Offset(0, 20))
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: SideBar(),
                      ),
                      Expanded(
                        flex: 4,
                        child: Column(
                          children: [
                            Container(
                                height: 120 ,
                                decoration: BoxDecoration(
                                  color:  Theme.of(context).primaryColor ,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.7),
                                        blurRadius: 60,
                                        offset: Offset(0, 5))
                                  ],
                                ),
                                child: Container(

                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      // add image logo

                                      SizedBox(
                                        width: 5 ,
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: Text(
                                             provider.getTittle(),
                                            style: TextStyle(
                                             fontSize: 30,
                                              color: Colors.white,

                                            )),
                                      ),

                                    ],
                                  ),
                                )),
                            Expanded(
                              child: Container(
                                child:   provider.getContent()

                                ,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
