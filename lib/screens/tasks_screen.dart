import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:todoey/screens/add_task_screen.dart';
import '../widgets/taskslist.dart';
import 'package:provider/provider.dart';
import 'package:todoey/models/task_data.dart';

class TasksScreen extends StatefulWidget {
  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  void initState() {
    loadBanner();
    loadInterstitial();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final taskCount = Provider.of<TaskData>(context).taskCount;
    checkAndShowInterstitial(taskCount);
  }

  Widget buildBottomSheet(BuildContext context) {
    return Container();
  }

  //variables para el banner
  late BannerAd _bannerAd;
  bool _isLoadedBanner = false;
  final adUnitIdBanner = 'ca-app-pub-3940256099942544/9214589741';

  //variables para el anuncio interstitial
  InterstitialAd? _interstitialAd;
  bool _isLoadedInterstitial = false;
  bool _interstitialShown = false;
  final adUnitIdInterstitial = 'ca-app-pub-3940256099942544/1033173712';

  void loadBanner() {
    _bannerAd = BannerAd(
      size: AdSize.fullBanner,
      adUnitId: adUnitIdBanner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          debugPrint("$ad loaded.");
          setState(() {
            _isLoadedBanner = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint("$ad  failed to load $error");
          ad.dispose();
        },
      ),
      request: const AdRequest(),
    );
    _bannerAd.load();
  }

  void loadInterstitial() {
    InterstitialAd.load(
        adUnitId: adUnitIdInterstitial,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            debugPrint("$ad loaded.");
            setState(() {
              _interstitialAd = ad;
              _isLoadedInterstitial = true;
            });
            _interstitialAd?.fullScreenContentCallback =
                FullScreenContentCallback(
              onAdDismissedFullScreenContent: (ad) {
                debugPrint("$ad onAdDismissedFullScreenContent.");
                _interstitialShown = false;
                loadInterstitial();
              },
              onAdFailedToShowFullScreenContent: (ad, error) {
                debugPrint("$ad onAdFailedToShowFullScreenContent: $error");
                loadInterstitial();
              },
            );
          },
          onAdFailedToLoad: (error) {
            debugPrint("InterstitialAd failed to load: $error");
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    final taskCount = Provider.of<TaskData>(context).taskCount;

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: CircleAvatar(
        radius: 35.0,
        child: FloatingActionButton.large(
          child: Icon(
            size: 35.0,
            Icons.library_add_check,
            color: Colors.white,
          ),
          backgroundColor: Colors.purple[400],
          onPressed: () {
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: AddTaskScreen(),
                      ),
                    ));
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/fondo.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            padding: (EdgeInsets.only(
              top: 60.0,
              left: 30.0,
              right: 30.0,
              bottom: 10.0,
            )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  child: Icon(
                    Icons.list,
                    color: Colors.purple[400],
                    size: 30.0,
                  ),
                  radius: 30.0,
                ),
                SizedBox(height: 10.0),
                Text(
                  "PlanifiKT",
                  style: TextStyle(
                    backgroundColor: Colors.white,
                    color: Colors.black54,
                    fontWeight: FontWeight.w700,
                    fontSize: 40.0,
                  ),
                ),
                Text(
                  "${Provider.of<TaskData>(context).taskCount} Tareas - Dejar presionado para borrar.",
                  style: TextStyle(
                      color: Colors.purple[400],
                      fontSize: 18.0,
                      backgroundColor: Colors.white),
                ),
              ],
            ),
          ),
          Expanded(
              child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/apuntes.webp"), fit: BoxFit.cover),
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.0),
                  topLeft: Radius.circular(20.0)),
            ),
            child: TasksList(),
          )),
        ],
      ),
      bottomNavigationBar: _isLoadedBanner
          ? SizedBox(
              height: _bannerAd.size.height.toDouble(),
              width: _bannerAd.size.width.toDouble(),
              child: AdWidget(ad: _bannerAd),
            )
          : const SizedBox(),
    );
  }

  void showInterstitial() {
    if (_isLoadedInterstitial) {
      _interstitialAd?.show();
      _interstitialShown = true;
    }
  }

  void checkAndShowInterstitial(int taskCount) {
    if (taskCount == 5 && !_interstitialShown) {
      showInterstitial();
    }
  }
}
