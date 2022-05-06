import UIKit
import Flutter
import SCSSDKiOS


@available(iOS 13.0.0, *)
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  )  async -> Bool {
      
      let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
      let paymentChannel = FlutterMethodChannel(name: "flutter.native/helper",
                                                binaryMessenger: controller.binaryMessenger)
       paymentChannel.setMethodCallHandler({
        [weak self](call: FlutterMethodCall, result: @escaping FlutterResult) -> Void async
       

        guard  call.method == "changeColor" else {
            
            result(FlutterMethodNotImplemented)
            return
          }
      await   self?.paymentMethod(result: result,call: call)
          
          
        // Note: this method is invoked on the UI thread.
        // Handle battery messages.
       });

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
 
    private func paymentMethod(result: FlutterResult, call: FlutterMethodCall )   async{
        print ("hello");
        guard let args = call.arguments else {
               return
             }
    
             if let myArgs = args as? [String: Any]
                 {
                
                
                let email =  myArgs["email"];
                let mobileNo  = myArgs["mobileNo"] as? Int;
                let offerCode = myArgs["offerCode"];
                
                let authKey = "2bc12245-fe7f-4f94-a715-ca2ab6ef6f03";
                let apiURL = "https://app.securecreditsystems.com/";
                 
//                let storyboard = UIStoryboard(name: "mainStoryboard", bundle: podBundle)
                 print(email ?? <#default value#>);
                 print(mobileNo ?? <#default value#>);
                 print(offerCode ?? <#default value#>);
               
                
//                let scs = SCSSDK(
//                    authKey
//                    );
                
                     
                     let score  =  	 await SCSSDKiOS.score(<#T##self: SCSSDKiOS##SCSSDKiOS#>)(
                    scsapikey:authKey,
                    scsurl:"", email:email as! String,
                    offerCode : offerCode as! String,
                    mobilenumber: <#String#>
                     ) 	as NSString ;
                     print("the score is $score");

                    if(score.contains("scoreid")){
                        result("$score");
    //                 result.success("$score")
                                            }
                    else{
                     result("400 something went wrong");
    //                                            result.error("400","something went wrong",null)
                      }
               
                 
                
             
                
                

    }

}
    
}
