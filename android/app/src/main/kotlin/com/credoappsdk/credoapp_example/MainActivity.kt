package com.credoappsdk.credoapp_example

import android.Manifest
import android.app.ProgressDialog
import android.os.Build
import android.os.StrictMode
import android.widget.ProgressBar
import androidx.annotation.NonNull
import androidx.core.app.ActivityCompat
import com.scs.scssdk.SCSSDK
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

val arrPerms = arrayOf(
        Manifest.permission.WRITE_EXTERNAL_STORAGE,
        Manifest.permission.READ_EXTERNAL_STORAGE,
        Manifest.permission.READ_CONTACTS,
        Manifest.permission.INTERNET,
        Manifest.permission.READ_CALENDAR,
        Manifest.permission.GET_ACCOUNTS,
        Manifest.permission.BLUETOOTH,
        Manifest.permission.ACCESS_WIFI_STATE,
        Manifest.permission.ACCESS_NETWORK_STATE,
        Manifest.permission.USE_FINGERPRINT,
        Manifest.permission.QUERY_ALL_PACKAGES
)
class MainActivity: FlutterActivity() {
    
     val CHANNEL = "flutter.native/helper"

    @ExperimentalStdlibApi
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler{
            call, result ->

            when {

                call.method.equals("changeColor") -> {

                    ActivityCompat.requestPermissions(this@MainActivity, arrPerms,200)


                    println("the email is ${call.argument<String>("email").toString()}")
                    println("the offerCode is ${call.argument<String>("offerCode").toString()}")
                    println("the mobileNo is ${call.argument<String>("mobileNo").toString()}")
                    val em=call.argument<String>("email").toString()
                    val mobile=call.argument<String>("mobileNo").toString()
                    val oferCode=call.argument<String>("offerCode").toString()
                    val authKey ="2bc12245-fe7f-4f94-a715-ca2ab6ef6f03"
                    val apiURL ="https://app.securecreditsystems.com/"
                    println("the auth key is $authKey")
                    println("the api url key is $apiURL")
                  val scs = SCSSDK(
                          authKey,
                  )

                    println("our scs is: ${scs.UserId}, ${scs.instanceId}, ")
                    if (Build.VERSION.SDK_INT > 9) {
                        val policy = StrictMode.ThreadPolicy.Builder()
                                .detectAll()
                                .penaltyLog()
                                .build()
                        StrictMode.setThreadPolicy(policy)
                    }
                    var progress=   ProgressDialog(context)
                    progress.show()
                    try {


                        val score  = scs.score(
                                email=em,
                                offerCode = oferCode,
                                minCollect=true,
                                context=context,
                                mobileNumber = mobile
                        ).toString()
                        println("the score is $score")

                        if(score.toString().contains("scoreid")){
                            progress.hide()
                            result.success("$score")
                        }
                        else{progress.hide()
                            result.error("400","something went wrong",null)
                        }

                    }

                    catch (indexOutOfBoundsException:IndexOutOfBoundsException){
                        progress.hide()
                        //your error handling code here
                        println("Exception is handled. ${indexOutOfBoundsException}")
                        result.error("${indexOutOfBoundsException.localizedMessage}","something went wrong",null)
                    } catch (nullpointer : NullPointerException){
                        progress.hide()
                        //your error handling code here
                        println("Exception is handled. ${nullpointer}")
                        result.error("${nullpointer.localizedMessage}","something went wrong",null)
                    }
                    catch (e : Exception){
                        progress.hide()
                        println("Exception is handled. ${e}")
                        result.error("${e.localizedMessage}","something went wrong",null)
                    }

                }
            }
        }
    }



}



