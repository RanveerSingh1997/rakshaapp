import 'package:flutter/material.dart';
import 'package:call_number/call_number.dart';
class LocationInput extends StatefulWidget {
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  final TextEditingController _controller = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  initState() {
    super.initState();
  }

  _initCall() async {
    if(_controller.text != null)
      await new CallNumber().callNumber('+91' + _controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor:Colors.green ,
        centerTitle:true,
        title:Text('Emergency Info'),
      ),
      body: Form(
        key:_formKey,
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller:_controller,
                      keyboardType:TextInputType.number,
                      decoration:InputDecoration(
                        labelText:'Mobile Number',
                      ),
                      validator:(value){
                         if(value.isEmpty){
                           return 'Enter mobile number';
                         }
                         if(value.length <10){
                           return 'Enter valid mobile number';
                         }
                         return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: FlatButton(
                    color:Colors.green,
                    child:Text('Add'),
                    onPressed:(){
                      setState(() {

                        });

                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: IconButton(
                    color:Colors.green,
                    icon:Icon(Icons.phone) ,
                    onPressed:(){
                      if(_formKey.currentState.validate()){
                        setState(() {
                          _initCall();
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            Text('Messsage',style:TextStyle(fontSize:20.0,fontWeight:FontWeight.w600),),
            Row(
              crossAxisAlignment:CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    maxLength:200,
                    maxLines:3,
                    autocorrect:true,
                    enableSuggestions:true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlatButton(
                    color:Colors.green,
                    child:Text('SAVE'),
                    onPressed:(){
                      if(_formKey.currentState.validate()){
                        setState(() {

                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView(
                 children: <Widget>[

                 ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
