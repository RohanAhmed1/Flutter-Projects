import 'package:first_app/about.dart';
import 'package:first_app/login.dart';
import 'package:first_app/tasks.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Practice'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPageIndex = 0;  

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return SafeArea(child: 
    Scaffold(  
      appBar: AppBar(
        leading: IconButton(
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        title: Text(
          widget.title,
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            tooltip: "Favorite",
            icon: const Icon(
              Icons.favorite,
            ),
            onPressed: () {},
          ),
          IconButton(
            tooltip: "Search",
            icon: const Icon(
              Icons.search,
            ),
            onPressed: () {},
          ),
          PopupMenuButton<Text>(
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  child: Text(
                    "First",
                  ),
                ),
                const PopupMenuItem(
                  child: Text(
                    "Second",
                  ),
                ),
                const PopupMenuItem(
                  child: Text(
                    "Third",
                  ),
                ),
              ];
            },
          )
        ],
      ),
      body: _getPage(currentPageIndex), // Display the selected screen based on the index
      bottomNavigationBar: NavigationBar(
        destinations: const <NavigationDestination>[
          NavigationDestination(icon: Icon(Icons.badge), label: "About"),
          NavigationDestination(icon: Icon(Icons.login), label: "Login"),
          NavigationDestination(icon: Icon(Icons.task), label: "Tasks"),
        ],
        onDestinationSelected: (int index) => {
          setState(() {
            // result in termiinal
            debugPrint('Page Index = $index');
            currentPageIndex = index;
          })
        },
        selectedIndex: currentPageIndex,
        animationDuration: const Duration(milliseconds: 1000),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    )
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return const About();
      case 1:
        return const Login();
      case 2:
        return const Tasks();
      default:
        return const About();
    }
  }
}
