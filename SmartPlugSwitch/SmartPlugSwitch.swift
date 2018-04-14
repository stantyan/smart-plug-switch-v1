//
//  AppDelegate.swift
//  SmartPlugSwitch
//
//  Created by Stan Tyan on 10/1/17.
//  Copyright © 2017 Stan Tyan. All rights reserved.
//

import Cocoa
import Foundation

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var statusMenu: NSMenu!
    
    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    
    @IBAction func quitClicked(_ sender: NSMenuItem) {
        NSApplication.shared().terminate(self)
    }
    
    var token = "Your_TPLink_Account_Token"
    var movieLightsID = "Your_Device_ID"
    var bathroomFanID = "Your_Device_ID"
    var waterHeaterID = "Your_Device_ID"
    var kitchenLedID = "Your_Device_ID"
    var christmasLightsID = "Your_Device_ID"
    var hotWaterID = "Your_Device_ID"
    
    func plugSwitch(_ token: String, _ movieLightsID: String, _ plugState: String) {
        let headers = [
            "content-type": "application/json",
            "cache-control": "no-cache"
        ]
        let parameters = [
            "method": "passthrough",
            "params": [
                "deviceId": "" + movieLightsID + "",
                "requestData": "{\"system\":{\"set_relay_state\":{\"state\":" + plugState + "}}}"
            ]
            ] as [String : Any]
        
        let postData = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://eu-wap.tplinkcloud.com/?token=" + token + "")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData! as Data
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error!)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse!)
            }
        })
        
        dataTask.resume()
    }

    @IBAction func onBathroomFan(_ sender: NSMenuItem) {
        plugSwitch(token, bathroomFanID, "1")
    }
    
    @IBAction func offBathroomFan(_ sender: NSMenuItem) {
        plugSwitch(token, bathroomFanID, "2")
    }
    
    @IBAction func onKitchenLED(_ sender: NSMenuItem) {
        plugSwitch(token, kitchenLedID, "1")
    }
    
    @IBAction func offKitchenLED(_ sender: NSMenuItem) {
        plugSwitch(token, kitchenLedID, "2")
    }

    @IBAction func onMovieLights(_ sender: NSMenuItem) {
        plugSwitch(token, movieLightsID, "1")
    }
    
    @IBAction func offMovieLights(_ sender: NSMenuItem) {
        plugSwitch(token, movieLightsID, "0")
    }
    
    @IBAction func onWaterHeater(_ sender: NSMenuItem) {
        plugSwitch(token, waterHeaterID, "1")
    }
    
    @IBAction func offWaterHeater(_ sender: NSMenuItem) {
        plugSwitch(token, waterHeaterID, "0")
    }
    
    @IBAction func onHotWater(_ sender: NSMenuItem) {
        plugSwitch(token, hotWaterID, "1")
    }
    
    @IBAction func offHotWater(_ sender: NSMenuItem) {
        plugSwitch(token, hotWaterID, "0")
    }
    
    @IBAction func onChristmas(_ sender: NSMenuItem) {
        plugSwitch(token, christmasLightsID, "1")
    }
    
    @IBAction func offChristmas(_ sender: NSMenuItem) {
        plugSwitch(token, christmasLightsID, "0")
    }
    
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        let icon = NSImage(named: "statusIcon")
        icon?.isTemplate = true // best for dark mode
        statusItem.image = icon
        statusItem.menu = statusMenu
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

