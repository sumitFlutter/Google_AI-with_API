import 'dart:convert';
import 'package:http/http.dart 'as http;

import '../../screen/home/model/gemini_model.dart';
class APIHelper{
  Future<GeminiModel?> apiCall(String question)
  async {
    var bodyJson={
      "contents": [{
        "parts":[{
          "text": question}]}]};
   var body= jsonEncode(bodyJson);
   var APIcalled =await http.post(Uri.parse("https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=AIzaSyB9JVxZkKD0C9AnFCQBcFv-hs9o8SpE6So"),headers: {"Content-Type":"application/json"},body: body);
   if(APIcalled.statusCode==200)
     {
       var jsonDecoded=jsonDecode(APIcalled.body);
       GeminiModel g1=GeminiModel.mapToModel(jsonDecoded);
       return g1;
     }
   return null;
  }
}
/*
curl  \
    -H ': application/json' \
    -X POST \
    -d '' 2> /dev/null
 */
/*
{
  "candidates": [
    {
      "content": {
        "parts": [
          {
            "text": "In the quaint town of Willow Creek, nestled amidst rolling hills and whispering willows, there lived an ordinary boy named Ethan. Ethan's life took an extraordinary turn the day he stumbled upon an enigmatic backpack hidden in the depths of his attic.\n\nCuriosity ignited within Ethan as he lifted the worn leather straps and unzipped its mysterious contents. Inside lay a shimmering array of vibrant objects and peculiar trinkets. There was a glowing orb that pulsated with an ethereal glow, a feather that seemed to have a life of its own, and a small, enigmatic key.\n\nAs Ethan explored each item, he realized they possessed astonishing abilities. The orb illuminated his path, casting a warm glow in the darkest of nights. The feather granted him the power of flight, allowing him to soar through the skies with newfound freedom. And the key opened a portal to a hidden world, a realm of endless wonder.\n\nArmed with his magical backpack, Ethan embarked on countless adventures. He flew over the towering mountains of Willow Creek, exploring their hidden secrets. He navigated the treacherous depths of the Enchanted Forest, where he encountered mythical creatures and ancient spirits. And he ventured into distant, unknown lands, uncovering lost civilizations and forgotten treasures.\n\nWith each adventure, Ethan's knowledge and abilities grew. He learned to harness the power of his backpack wisely, using its magic to help others and protect the world from evil forces. The backpack became an extension of himself, a symbol of hope and wonder in the face of adversity.\n\nAs the years went by, Ethan's reputation as the boy with the magic backpack spread far and wide. People from all walks of life came to him, seeking his guidance and protection. And Ethan never hesitated to lend a helping hand, using his extraordinary abilities to make the world a better place.\n\nIn the end, the magic backpack became more than just a collection of objects. It was a representation of Ethan's unwavering spirit, his boundless imagination, and his unwavering belief in the power of dreams. And as long as Ethan carried it with him, the magic of Willow Creek would live on, illuminating the darkest corners of the world with hope, wonder, and the limitless possibilities that resided within the heart of a child."
          }
        ],
        "role": "model"
      },
      "finishReason": "STOP",
      "index": 0,
      "safetyRatings": [
        {
          "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
          "probability": "NEGLIGIBLE"
        },
        {
          "category": "HARM_CATEGORY_HATE_SPEECH",
          "probability": "NEGLIGIBLE"
        },
        {
          "category": "HARM_CATEGORY_HARASSMENT",
          "probability": "NEGLIGIBLE"
        },
        {
          "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
          "probability": "NEGLIGIBLE"
        }
      ]
    }
  ],
  "promptFeedback": {
    "safetyRatings": [
      {
        "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
        "probability": "NEGLIGIBLE"
      },
      {
        "category": "HARM_CATEGORY_HATE_SPEECH",
        "probability": "NEGLIGIBLE"
      },
      {
        "category": "HARM_CATEGORY_HARASSMENT",
        "probability": "NEGLIGIBLE"
      },
      {
        "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
        "probability": "NEGLIGIBLE"
      }
    ]
  }
}
curl ?key=$GOOGLE_API_KEY \
    -H 'Content-Type: application/json' \
    -X POST \
    -d '{
      "contents": [{
        "parts":[{
          "text": "Write a story about a magic backpack."}]}]}' 2> /dev/null
 */