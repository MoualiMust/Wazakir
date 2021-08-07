import 'package:flutter/material.dart';
import 'package:wazakir/theme/colors/light_colors.dart';
import 'package:wazakir/widgets/barMenu.dart';
import 'package:wazakir/widgets/top_container.dart';

import '../../size_config.dart';

class Nawm extends StatefulWidget {
  @override
  _NawmState createState() => _NawmState();
}

class _NawmState extends State<Nawm> {
  Widget text(String text) {
    return Center(
        child: Text(
      text,
      style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 26.0),
    ));
  }

  List<Map<String, String>> data = [
    {'dikr': "بِاسْمِكَ رَبِّـي وَضَعْـتُ جَنْـبي ، وَبِكَ أَرْفَعُـه، فَإِن أَمْسَـكْتَ نَفْسـي فارْحَـمْها ، وَإِنْ أَرْسَلْتَـها فاحْفَظْـها بِمـا تَحْفَـظُ بِه عِبـادَكَ الصّـالِحـين", 'number': "1"},
    {'dikr': "اللّهُـمَّ إِنَّـكَ خَلَـقْتَ نَفْسـي وَأَنْـتَ تَوَفّـاهـا لَكَ ممَـاتـها وَمَحْـياها ، إِنْ أَحْيَيْـتَها فاحْفَظْـها ، وَإِنْ أَمَتَّـها فَاغْفِـرْ لَـها . اللّهُـمَّ إِنَّـي أَسْـأَلُـكَ العـافِـيَة", 'number': "1"},
    {'dikr': "اللّهُـمَّ قِنـي عَذابَـكَ يَـوْمَ تَبْـعَثُ عِبـادَك", 'number': "3"},
    {'dikr': "بِاسْـمِكَ اللّهُـمَّ أَمـوتُ وَأَحْـيا", 'number': "1"},
    {'dikr': "الـحَمْدُ للهِ الَّذي أَطْـعَمَنا وَسَقـانا، وَكَفـانا، وَآوانا، فَكَـمْ مِمَّـنْ لا كـافِيَ لَـهُ وَلا مُـؤْوي", 'number': "1"},
    {'dikr': "اللّهُـمَّ عالِـمَ الغَـيبِ وَالشّـهادةِ فاطِـرَ السّماواتِ وَالأرْضِ رَبَّ كُـلِّ شَـيءٍ وَمَليـكَه، أَشْهـدُ أَنْ لا إِلـهَ إِلاّ أَنْت، أَعـوذُ بِكَ مِن شَـرِّ نَفْسـي، وَمِن شَـرِّ الشَّيْـطانِ وَشِـرْكِه، وَأَنْ أَقْتَـرِفَ عَلـى نَفْسـي سوءاً أَوْ أَجُـرَّهُ إِلـى مُسْـلِم ", 'number': "1"},
    {'dikr': "اللّهُـمَّ أَسْـلَمْتُ نَفْـسي إِلَـيْكَ، وَفَوَّضْـتُ أَمْـري إِلَـيْكَ، وَوَجَّـهْتُ وَجْـهي إِلَـيْكَ، وَأَلْـجَـاْتُ ظَهـري إِلَـيْكَ، رَغْبَـةً وَرَهْـبَةً إِلَـيْكَ، لا مَلْجَـأَ وَلا مَنْـجـا مِنْـكَ إِلاّ إِلَـيْكَ، آمَنْـتُ بِكِتـابِكَ الّـذي أَنْزَلْـتَ وَبِنَبِـيِّـكَ الّـذي أَرْسَلْـت", 'number': "1"},
    {'dikr': "سُبْحَانَ اللَّهِ", 'number': "33"},
    {'dikr': "الْحَمْدُ لِلَّهِ", 'number': "33"},
    {'dikr': "اللَّهُ أَكْبَرُ", 'number': "1"},
    {'dikr': "يجمع كفيه ثم ينفث فيهما والقراءة فيهما‏:‏ ‏{‏قل هو الله أحد‏}‏ و‏{‏قل أعوذ برب الفلق‏}‏ و‏{‏قل أعوذ برب الناس‏}‏ ومسح ما استطاع من الجسد يبدأ بهما على رأسه ووجه وما أقبل من جسده", 'number': "3"},
    {'dikr': "اللّهُ لاَ إِلَـهَ إِلاَّ هُوَ الْحَيُّ الْقَيُّومُ لاَ تَأْخُذُهُ سِنَةٌ وَلاَ نَوْمٌ لَّهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الأَرْضِ مَن ذَا الَّذِي يَشْفَعُ عِنْدَهُ إِلاَّ بِإِذْنِهِ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ وَلاَ يُحِيطُونَ بِشَيْءٍ مِّنْ عِلْمِهِ إِلاَّ بِمَا شَاء وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالأَرْضَ وَلاَ يَؤُودُهُ حِفْظُهُمَا وَهُوَ الْعَلِيُّ الْعَظِيمُ", 'number': "1"},
  ];

  final _controller = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          BarMenu(Colors.white, Colors.white, Colors.white, Colors.white),
      backgroundColor: LightColors.kLightYellow,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TopContainer(
              width: MediaQuery.of(context).size.width,
              height: 100,
              child: text('أذكار النوم'),
            ),
            Expanded(
              child: PageView.builder(
                reverse: true,
                controller: _controller,
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.indigo[400],
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 8.0),
                          child: Column(
                            
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(data[index]['dikr'].toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                              ),
                              Text('${data[index]['number'].toString()} عدد التكرارات',
                                  style: TextStyle(
                                      color: Colors.white70, fontSize: 16.0)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: heightSize(context, 1),),
                      Text('${_currentPage+1} / ${data.length}',style: TextStyle(fontSize: 16),)
                    ],
                  );
                },
                onPageChanged: (value) => setState(() => _currentPage = value),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
