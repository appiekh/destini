import 'package:flutter/material.dart';

void main() {
  runApp(const DestiniBody());
}

class DestiniBody extends StatefulWidget {
  const DestiniBody({super.key});

  @override
  State<DestiniBody> createState() => _DestiniBodyState();
}

class _DestiniBodyState extends State<DestiniBody> {

  SingularChoice? currentChoice;

  @override
  void initState() {
    super.initState();
    init();
  }

  void changeCurrentChoice(SingularChoice newCurrentChoice) {
    setState(() {
      currentChoice = newCurrentChoice;
      print("New choice set: ${currentChoice!.story}");
    });
  }
  void init(){
    setState(() {
      print("setting state LOL");
      SingularChoice leftChoice;
      SingularChoice rightChoice;
      SingularChoice firstChoice;

      // Initialize left and right choices
      leftChoice = SingularChoice(
        currentInstance : this,
        story:
        "You immediately escape, and immediately get shot by a police officer because you produce more melanin. THE END",
        choiceText: "Go left",
      );

      // PANTS CHOICES
      SingularChoice stealPantsChoice = SingularChoice(
        story:
        "You try to steal someone's pants in Amsterdam Centraal, but struggle. Eventually, you do get it, but since it's 5 PM, there's loads of witnesses and you get caught and get the death sentence. THE END",
        choiceText: "Steal pants",
        currentInstance : this,
      );
      SingularChoice buyPantsChoice = SingularChoice(
        currentInstance : this,
        story:
        "You buy some pants, and are extremely happy with it. You decide to walk around with it in the centre of Amsterdam, so thousands can see your awesome pants! But, for some reason, people keep laughing when you walk past them. This continues to happen for 10 more minutes until a nice fellow decides to tell you that your pants has a huge hole and everyone can see your butt since you forgot to put on underwear. You are so embarrassed, you kill yourself on the spot, in front of everyone, scarring a woman of 16 years old for life.  THE END",
        choiceText: "Buy pants",
      );

      SingularChoice attemptToRunAway = SingularChoice(
        story:
        "You ran away! But it appears a much larger problem has risen, your pants are gone! Do you go to the store and go buy one, or do you go steal it from someone?",
        choiceOne: buyPantsChoice,
        choiceTwo: stealPantsChoice,
        choiceText: "Run away",
        currentInstance : this,

      );

      SingularChoice medkitChoice = SingularChoice(
        story:
        "You used a medkit, and are fully healed! You now become a surgeon and die at the age of 87 because of old age. THE END",
        choiceText: "Use medkit",
        currentInstance : this,

      );
      SingularChoice bandageChoice = SingularChoice(
        story:
        "You use a bandages, but bandages only heal you 75%, so you eventually bleed out. THE END",
        choiceText: "use bandages",
        currentInstance : this,

      );

      // MONSTER CHOICES
      SingularChoice attemptToSlayMonster = SingularChoice(
        choiceOne: medkitChoice,
        choiceTwo: bandageChoice,
        story:
        "You tried to slay it and was defeated, your body is now in 2 pieces. Do you use bandages or a medkit?",
        choiceText: "Slay it",
        currentInstance : this,

      );

      // RIGHT CHOICE
      rightChoice = SingularChoice(
        choiceOne: attemptToSlayMonster,
        choiceTwo: attemptToRunAway,
        story:
        "Oh no! Theres a big scary monster who wants to eat you! What do you do?",
        choiceText: "Go right",
        currentInstance : this,

      );

      // FIRST CHOICE
      currentChoice = SingularChoice(
        choiceOne: leftChoice,
        choiceTwo: rightChoice,
        story: "You fall into a maze. Which direction do you go?",
        choiceText: "Choose a direction",
        currentInstance : this,

      );
    });

  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/background.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                currentChoice != null
                    ? currentChoice!.GetUI()  // Use the updated UI
                    : Center(child: CircularProgressIndicator()),  // Loading state in case of null
                SizedBox(height: 50.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Als je op een choice klikt, krijg je nog twee choices te zien, en daarna nog 2 en daarna morgelijk nog twee

// 1 BASE CLASS
// 1 CLASS die 2 properties hebben

class Choice extends StatefulWidget {
  const Choice({super.key});

  @override
  State<Choice> createState() => _ChoiceState();
}

class _ChoiceState extends State<Choice> {
  Choice? choiceOne;
  Choice? choiceTwo;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

// WHAT I NEED TO DO:
class SingularChoice {
  _DestiniBodyState? currentInstance;
  SingularChoice? choiceOne;
  SingularChoice? choiceTwo;
  String story;
  String choiceText;

  SingularChoice({
    this.currentInstance,
    this.choiceOne,
    this.choiceTwo,
    required this.story,
    required this.choiceText,
  });

  Column GetUI() {
    List<Widget> allChildren = [
      Center(
        child: Text(
          story,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
            // fontWeight: FontWeight.bold,
          ),
        ),
      ),
      SizedBox(height: 275.0),
    ];

    // Only add buttons if there are choices available
    if (choiceOne != null) {
      allChildren.add(
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 25.0),
          ),
          child: Text(choiceOne!.choiceText),
          onPressed: () {
            print("Pressed choiceOne: ${choiceOne!.story}");
            currentInstance?.changeCurrentChoice(choiceOne!);
          },
        ),
      );
      allChildren.add(SizedBox(height: 50.0));
    }

    if (choiceTwo != null) {
      allChildren.add(
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 25.0),
          ),
          child: Text(choiceTwo!.choiceText),
          onPressed: () {
            print("Pressed choiceTwo: ${choiceTwo!.story}");
            currentInstance?.changeCurrentChoice(choiceTwo!);
          },
        ),
      );
    } else {
      allChildren.add(
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 25.0),
          ),
          child: Text("RESTART"),
          onPressed: () {

            currentInstance?.init();
          },
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: allChildren,
    );
  }
}
