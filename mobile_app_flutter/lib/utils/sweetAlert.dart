import 'package:flutter/material.dart';


showLoader(BuildContext context , {String title = 'Veuillez Patienter svp ...' , String desc = ''}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            )),
        child: Padding(
          padding: const EdgeInsets.all(9.6),
          child:  Container(
            height: 50,
            child: new Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.blue)),
                SizedBox(width: 18.6,),
                Flexible(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("${title}" , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 17),),
                        (desc.length > 0) ?SizedBox(height: 3,) :Container(),
                        (desc.length > 0) ?Text("${desc}" , maxLines: 1 , overflow: TextOverflow.ellipsis , style: TextStyle(fontSize: 15),) :Container(),
                      ],
                    )
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

hideLoader(context){
  Navigator.of(context).pop();
}