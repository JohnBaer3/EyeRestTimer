//
//  AppDelegate.swift
//  FocusTimer
//
//  Created by John Baer on 6/8/20.
//  Copyright © 2020 John Baer. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var statusBarMenu = NSMenu(title: "Cap Status Bar Menu")
    var statusBarItem: NSStatusItem!
    var time: Int? = nil {
        didSet{
            
        }
    }
    var paused = false
    var timer = Timer()

    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let statusBar = NSStatusBar.system
        statusBarItem = statusBar.statusItem(
            withLength: NSStatusItem.squareLength)
        
        statusBarItem.menu = statusBarMenu

        statusBarItem.button!.title = "⏱"
            
        statusBarMenu.addItem(
            withTitle: "Choose a time",
            action: #selector(AppDelegate.chooseTime),
            keyEquivalent: "")
        
        statusBarMenu.addItem(
            NSMenuItem(title: "Quit",
            action: #selector(NSApplication.terminate(_:)),
            keyEquivalent: "q")
        )
        
    }
    
    
    
    
    
    
    @objc func chooseTime() {
        if time == nil{
            time = 10
            startTimer()
            
            statusBarMenu.removeAllItems()
            statusBarItem.button!.title = convertToTime(number: time!)
            
            statusBarMenu.addItem(
                withTitle: "Pause",
                action: #selector(AppDelegate.pause),
                keyEquivalent: "")
            
            statusBarMenu.addItem(
                withTitle: "Reset",
                action: #selector(AppDelegate.reset),
                keyEquivalent: "")
            
            statusBarMenu.addItem(
                NSMenuItem(title: "Quit",
                action: #selector(NSApplication.terminate(_:)),
                keyEquivalent: "q")
            )
        }
    }
    
    @objc func pause() {
        paused = !paused
        statusBarItem.button!.title = "Resume"
    }
    
    
    @objc func reset() {
        paused = false
        time = nil
        timer.invalidate()
        statusBarItem.button!.title = "⏱"
        statusBarMenu.removeAllItems()
        
        statusBarMenu.addItem(
        withTitle: "Choose a time",
        action: #selector(AppDelegate.chooseTime),
        keyEquivalent: "")
        
        statusBarMenu.addItem(
            NSMenuItem(title: "Quit",
            action: #selector(NSApplication.terminate(_:)),
            keyEquivalent: "q")
        )
    }

    
    func convertToTime(number: Int) -> String{
        let min = String(number / 60)
        let secs = String(number % 60)
        return String(min + ":" + secs)
    }
    
    func startTimer(){
        if !paused{
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.subtractTime), userInfo: nil, repeats: true)
        }else{
            timer.invalidate()
        }
    }
    
    @objc func subtractTime(){
        if(time! > 0){
            time! -= 1
            statusBarItem.button!.title = convertToTime(number: time!)
        }else{
            //popup
            
            reset()
        }
    }
    
    

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    
    
    @IBAction func startButtonClicked(_ sender: Any) {
    }
    
    @IBAction func stopButtonClicked(_ sender: Any) {
    }
    
    @IBAction func resetButtonClicked(_ sender: Any) {
    }
    
    
    


}

