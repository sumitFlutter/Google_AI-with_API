import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_gemini/screen/home/provider/gemini_provider.dart';
import 'package:google_gemini/utils/helpers/db_helper.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<GeminiProvider>().readList();
  }
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
                      alignment: watchObject!.qnaList[index].isQ==1
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      child: InkWell(
                        onLongPress: () {
                          showDialog(context: context, builder: (context) {
                            return AlertDialog(
                              title: Text("Are You Sure?"),
                              content: Column(mainAxisSize: MainAxisSize.min,
                                children: [
                                Text(watchObject!.qnaList[index].text!,style: TextStyle(overflow: TextOverflow.ellipsis),),
                                SizedBox(height: 4,),
                                Text("Will be deleted."),
                              ],),

                              actions: [
                                ElevatedButton(onPressed: () {
                                  Navigator.pop(context);
                                }, child: Text("No!")),
                                ElevatedButton(onPressed: () {
                                  DBHelper.dbHelper.deleteChat(id: watchObject!.qnaList[index].id!);
                                  watchObject!.readList();
                                  Navigator.pop(context);
                                }, child: Text("Yes!"))
                              ],
                            );
                          },);
                        },
                        child: Container(padding: const EdgeInsets.all(10),
                          width:watchObject!.qnaList[index].text!.length>=60? MediaQuery.sizeOf(context).width*0.45:watchObject!.qnaList[index].text!.length>=15?MediaQuery.sizeOf(context).width*0.30:MediaQuery.sizeOf(context).width*0.20,
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(color: Colors.green.shade50,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                             Center(
                               child: SelectableText(watchObject!.qnaList[index].text!,
                                  style: const TextStyle(fontWeight: FontWeight.bold),),
                             ),
                              const SizedBox(height: 10,),
                              Align(alignment: Alignment.centerRight,child: watchObject!.qnaList[index].date=="${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}"?Text("${watchObject!.qnaList[index].time}"):Text("${watchObject!.qnaList[index].date}  ${watchObject!.qnaList[index].time}"),)
                            ],
                          ),),
                      ));
                },),),
            SizedBox(
              height: MediaQuery
                  .sizeOf(context)
                  .height * 0.08,
              width: MediaQuery
                  .sizeOf(context)
                  .width,
              child: TextField(controller: textEditingController,
                decoration: InputDecoration(
                    hintText: "Ask me Questions",
                    suffixIcon: watchObject!.geminiModel!=null?IconButton(onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      readObject!.getQ(textEditingController.text);
                      textEditingController.clear();
                      readObject!.postAPICall();
                    }, icon: const Icon(Icons.send)):const CircularProgressIndicator()),),
            ),
            Center(child: Text("On Long Press you can delete the Chat"),)
          ],),
        ),
      ),
    ));
  }
}
