import 'package:flutter/material.dart';

class CKD extends StatelessWidget {
  const CKD({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Info Page"),
      ),
      body: ListView(
        children: [
          Image.asset("assets/kidney.jpg",fit: BoxFit.cover,),
          SizedBox(height: 10,),
          Container(
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Chronic Kidney Disease",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                SizedBox(height: 12,),
                Text("\t\t\t\t\t\t\t\tChronic kidney disease, also called chronic kidney failure, involves a gradual "
                    "loss of kidney function. Your kidneys filter wastes and excess fluids from your blood, "
                    "which are then removed in your urine. Advanced chronic kidney disease can cause "
                    "dangerous levels of fluid, electrolytes and wastes to build up in your body.",style: TextStyle(fontSize: 16),textAlign: TextAlign.justify,),
                Text("\n\t\t\t\t\t\t\t\tIn the early stages of chronic kidney disease, you might have "
                    "few signs or symptoms. You might not realize that you have kidney disease until the "
                    "condition is advanced. Treatment for chronic kidney disease focuses on slowing the "
                    "progression of kidney damage, usually by controlling the cause. But, even controlling "
                    "the cause might not keep kidney damage from progressing. Chronic kidney disease can progress "
                    "to end-stage kidney failure, which is fatal without artificial filtering (dialysis) or a "
                    "kidney transplant.\n",style: TextStyle(fontSize: 16),textAlign: TextAlign.justify,),
                Text("Symptoms",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                SizedBox(height: 12,),
                Text("\t\t\t\t\t\t\t\tSigns and symptoms of chronic kidney disease develop over time if "
                    "kidney damage progresses slowly. Loss of kidney function can cause a buildup of fluid "
                    "or body waste or electrolyte problems. Depending on how severe it is, loss of kidney f"
                    "unction can cause:\n",style: TextStyle(fontSize: 16),textAlign: TextAlign.justify,),
                Text("\u2022 Nausea\n\u2022 Vomiting\n\u2022 Loss of appetite\n\u2022 Fatigue and weakness\n\u2022 Sleep problems\n\u2022 Urinating more or less\n\u2022 Decreased mental sharpness "
                    "\n\u2022 Muscle cramps\n\u2022 Swelling of feet and ankles\n\u2022 Dry, itchy skin\n\u2022 High blood pressure (hypertension)\n\u2022 Shortness of breath, if fluid builds up in the lungs "
                    "\n\u2022 Chest pain\n\n\t\t\t\t\t\t\t\tSigns and symptoms of kidney disease are often nonspecific. This means they can also be caused by other illnesses. Because your kidneys are able to make up for lost function, you might not develop signs and symptoms until irreversible damage has occurred.",style: TextStyle(fontSize: 16),textAlign: TextAlign.justify,),
              ],
            ),
          )
        ],
      ),
    );
  }
}
