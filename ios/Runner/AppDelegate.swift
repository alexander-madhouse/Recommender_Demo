import UIKit
import Flutter
import SCSSDKiOS


@available(iOS 13.0.0, *)
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate  {
//    override func application(
//    _ application: UIApplication,
//    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
//  )   -> Bool {
//
//      let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
//      let paymentChannel = FlutterMethodChannel(name: "flutter.native/helper",
//                                                binaryMessenger: controller.binaryMessenger)
//       paymentChannel.setMethodCallHandler({
//        [weak self](call: FlutterMethodCall, result: @escaping FlutterResult) -> Void
//
//
//        guard  call.method == "changeColor" else {
//
//            result(FlutterMethodNotImplemented)
//            return
//          }
//         self?.paymentMethod(result: result,call: call)
//
//
//        // Note: this method is invoked on the UI thread.
//        // Handle battery messages.
//       });
//
//    GeneratedPluginRegistrant.register(with: self)
//    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
//  }
    override func application(
            _ application: UIApplication,
            didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    )  -> Bool {
            
            let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
            let batteryChannel = FlutterMethodChannel(name: "flutter.native/helper",
                                                      binaryMessenger: controller.binaryMessenger)
        batteryChannel.setMethodCallHandler  ({
              (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
              // Note: this method is invoked on the UI thread.
              // Handle battery messages.
            async {
              await  self.paymentMethod(result: result, call: call)
//                        semaphore.signal()
                }
             
               
            })

            GeneratedPluginRegistrant.register(with: self)
            return super.application(application, didFinishLaunchingWithOptions: launchOptions)
          }
 
    private func paymentMethod(result: FlutterResult, call: FlutterMethodCall ) async {
        print ("hello");
await  callingscoring(result: result, call: call );
    

}
    private func callingscoring(result: FlutterResult, call: FlutterMethodCall ) async {
        print ("hello");
        guard let args = call.arguments else {
               return
             }

             if let myArgs = args as? [String: Any]
                 {
                let email =  myArgs["email"];
                let mobileNo  = myArgs["mobileNo"] ;
                let offerCode = myArgs["offerCode"];
                
                let authKey = "2bc12245-fe7f-4f94-a715-ca2ab6ef6f03";
                let apiURL = "https://app.securecreditsystems.com/";
                 
        //                let storyboard = UIStoryboard(name: "mainStoryboard", bundle: podBundle)
                 print(email );
                 print(mobileNo);
                 print(offerCode);
               
                 let scr =  await SCSSDKiOS.score(SCSSDKiOS.init())(
                    scsapikey:authKey ,
                    scsurl:"",
                    email:email as! String,
                    offerCode : offerCode as! String, mobilenumber: ""
                 ) as NSString ;
                 
                    if(scr.contains("scoreid")){
                        result("$scr");
        //                 result.success("$score")
                                            }
                    else{
                      print("dsadasdasd: $scr");
                     result(scr);
        //                                            result.error("400","something went wrong",null)
                      }
               
                 
                
             
                
                

        }


}
    
}

