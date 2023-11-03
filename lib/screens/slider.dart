import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sih2023/screens/about_first.dart';

class slider extends StatefulWidget {
  slider({Key? key}) : super(key: key);

  static const String page_id = "Slider";

  @override
  _sliderState createState() => _sliderState();
}

class _sliderState extends State<slider> {
  final CarouselController _controller = CarouselController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(

      child: Stack(
        children: <Widget>[
          CarouselSlider(
            options: CarouselOptions(
              onPageChanged: ((index, reason) {
                setState(() {
                  _currentIndex = index;
                  print(index);
                });
              }),
              height: double.infinity,
              viewportFraction: 1.0,
              initialPage: 0,
              enableInfiniteScroll: false,
              reverse: false,
              autoPlay: false,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
            ),
            carouselController: _controller,
            items: [1, 2, 3].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: double.infinity,
                    height: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 0),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (i == 1)
                            _buildSlide1()
                          else if (i == 2)
                            _buildSlide2()
                          else if (i == 3)
                            _buildSlide3()
                        ],
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSlide1() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 300,
          width: 300,
          child: ClipPath(
            child: ClipRRect(
              child: Lottie.asset(
                'assets/first.json',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Text(
                'Login',
                textAlign: TextAlign.center,
                style: whiteHeadText(),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Login With Your Credentials',
                  style: simpleWhiteText(),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.circle,
                    size: 15,
                    color: Colors.black,
                  ),
                  const Icon(
                    Icons.circle,
                    size: 15,
                    color: Colors.black12,
                  ),
                  const Icon(
                    Icons.circle,
                    size: 15,
                    color: Colors.black12,
                  )
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const About()));
                },
                child: Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xffbbebff), Colors.indigo],
                    ),
                  ),
                  child: Container(
                    constraints: const BoxConstraints(
                      maxWidth: 300.0,
                      minHeight: 50.0,
                    ),
                    alignment: Alignment.center,
                    child: Container(
                      constraints: const BoxConstraints(
                        maxWidth: 300.0,
                        minHeight: 50.0,
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'GET STARTED',
                        style: TextStyle(fontFamily: 'bold', fontSize: 16),
                      ),
                    ),
                  ),
                ),
                style: blueButton(),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildSlide2() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 300,
          width: 300,
          child: ClipPath(
            child: ClipRRect(
              child: Lottie.asset(
                'assets/third.json',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Text(
                'Upload',
                textAlign: TextAlign.center,
                style: whiteHeadText(),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Effortlessly Upload Your Audio Conversations',
                  style: simpleWhiteText(),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.circle,
                    size: 15,
                    color: Colors.black12,
                  ),
                  const Icon(
                    Icons.circle,
                    size: 15,
                    color: Colors.black,
                  ),
                  const Icon(
                    Icons.circle,
                    size: 15,
                    color: Colors.black12,
                  )
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const About()));
                },
                child: Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xffbbebff), Colors.indigo],
                    ),
                  ),
                  child: Container(
                    constraints: const BoxConstraints(
                      maxWidth: 300.0,
                      minHeight: 50.0,
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'GET STARTED',
                      style: TextStyle(fontFamily: 'bold', fontSize: 16),
                    ),
                  ),
                ),
                style: blueButton(),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildSlide3() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 300,
          width: 300,
          child: ClipPath(
            child: ClipRRect(
              child: Lottie.asset(
                'assets/second.json',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Text(
                'Get Detailed Analysis',
                textAlign: TextAlign.center,
                style: whiteHeadText(),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Get Detailed Analysis On Your Conversations',
                  style: simpleWhiteText(),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.circle,
                    size: 15,
                    color: Colors.black12,
                  ),
                  const Icon(
                    Icons.circle,
                    size: 15,
                    color: Colors.black12,
                  ),
                  const Icon(
                    Icons.circle,
                    size: 15,
                    color: Colors.black,
                  )
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const About()));
                },
                child: Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xffbbebff), Colors.indigo],
                    ),
                  ),
                  child: Container(
                    constraints: const BoxConstraints(
                      maxWidth: 300.0,
                      minHeight: 50.0,
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'GET STARTED',
                      style: TextStyle(fontFamily: 'bold', fontSize: 16),
                    ),
                  ),
                ),
                style: blueButton(),
              ),
            ],
          ),
        )
      ],
    );
  }
}

blueButton() {
  return ElevatedButton.styleFrom(
    elevation: 0,
    primary: Colors.transparent,
    minimumSize: const Size.fromHeight(50),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
  );
}

simpleInputText(text) {
  return InputDecoration(
    // border: InputBorder.none,
    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    hintText: text,
    hintStyle: TextStyle(color: Colors.grey.shade600),
    filled: true,
    fillColor: Colors.transparent,
  );
}

const styleColor = Color(0xFF6635CC);

styleheadText() {
  return const TextStyle(fontSize: 18.0, fontFamily: '', color: styleColor);
}

whiteHeadText() {
  return const TextStyle(
      fontSize: 18.0, fontFamily: 'lato', color: Colors.black);
}

simpleText() {
  return const TextStyle(fontFamily: 'lato', fontSize: 18);
}

simpleWhiteText() {
  return const TextStyle(fontFamily: 'lato', fontSize: 18, color: Colors.black);
}
