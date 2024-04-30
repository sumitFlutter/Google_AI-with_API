import 'package:flutter/material.dart';
import 'package:google_gemini/screen/home/provider/gemini_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GeminiProvider? readObject;
  GeminiProvider? watchObject;
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    readObject = context.read<GeminiProvider>();
    watchObject = context.watch<GeminiProvider>();
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: const Text("Gemini Ai"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(height: MediaQuery
                .sizeOf(context)
                .height * 0.8, width: MediaQuery
                .sizeOf(context)
                .width,
              child: ListView.builder
                (itemCount: watchObject!.qnaList.length,
                itemBuilder: (context, index) {
                  return Align(
                      alignment: index % 2 == 1
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      child: Container(padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(watchObject!.qnaList[index],
                          style: const TextStyle(fontWeight: FontWeight.bold),),));
                },),),
            SizedBox(
              height: MediaQuery
                  .sizeOf(context)
                  .height * 0.1,
              width: MediaQuery
                  .sizeOf(context)
                  .width,
              child: TextField(controller: textEditingController,
                decoration: InputDecoration(
                    hintText: "Ask me a Questions",
                    suffixIcon: watchObject!.geminiModel!=null?IconButton(onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      readObject!.getQ(textEditingController.text);
                      textEditingController.clear();
                      readObject!.postAPICall();
                    }, icon: const Icon(Icons.send)):const CircularProgressIndicator()),),
            )
          ],),
        ),
      ),
    ));
  }
}
