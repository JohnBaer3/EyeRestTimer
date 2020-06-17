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
    var time: Int? = nil
    var paused = false
    var timer = Timer()

    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let statusBar = NSStatusBar.system
        statusBarItem = statusBar.statusItem(
            withLength: NSStatusItem.variableLength)
        
        statusBarItem.menu = statusBarMenu

        statusBarItem.button!.title = "⏱"
            
        statusBarMenu.addItem(
        withTitle: "20 minutes",
        action: #selector(AppDelegate.chooseTime20),
        keyEquivalent: "")
        
        statusBarMenu.addItem(
        withTitle: "30 minutes",
        action: #selector(AppDelegate.chooseTime30),
        keyEquivalent: "")
        
        statusBarMenu.addItem(
        withTitle: "40 minutes",
        action: #selector(AppDelegate.chooseTime40),
        keyEquivalent: "")
        
        statusBarMenu.addItem(
        withTitle: "60 minutes",
        action: #selector(AppDelegate.chooseTime60),
        keyEquivalent: "")
        
        statusBarMenu.addItem(
            NSMenuItem(title: "Quit",
            action: #selector(NSApplication.terminate(_:)),
            keyEquivalent: "q")
        )
        
    }
    
    
    
    
    
    
    @objc func chooseTime20() {
        if time == nil{
            time = 1200
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
    
    @objc func chooseTime30() {
        if time == nil{
            time = 1800
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
    
    @objc func chooseTime40() {
        if time == nil{
            time = 2400
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
    
    @objc func chooseTime60() {
        if time == nil{
            time = 3600
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
        statusBarMenu.removeAllItems()
        statusBarItem.button!.title = convertToTime(number: time!)
        
        if(paused){
            statusBarMenu.addItem(
            withTitle: "Resume",
            action: #selector(AppDelegate.pause),
            keyEquivalent: "")
        }else{
            statusBarMenu.addItem(
            withTitle: "Pause",
            action: #selector(AppDelegate.pause),
            keyEquivalent: "")
        }
        
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
    
    
    @objc func reset() {
        paused = false
        time = nil
        timer.invalidate()
        statusBarItem.button!.title = "⏱"
        statusBarMenu.removeAllItems()
        
        statusBarMenu.addItem(
        withTitle: "20 minutes",
        action: #selector(AppDelegate.chooseTime20),
        keyEquivalent: "")
        
        statusBarMenu.addItem(
        withTitle: "30 minutes",
        action: #selector(AppDelegate.chooseTime30),
        keyEquivalent: "")
        
        statusBarMenu.addItem(
        withTitle: "40 minutes",
        action: #selector(AppDelegate.chooseTime40),
        keyEquivalent: "")
        
        statusBarMenu.addItem(
        withTitle: "60 minutes",
        action: #selector(AppDelegate.chooseTime60),
        keyEquivalent: "")
        
        statusBarMenu.addItem(
            NSMenuItem(title: "Quit",
            action: #selector(NSApplication.terminate(_:)),
            keyEquivalent: "q")
        )
    }

    
    func convertToTime(number: Int) -> String{
        let min = String(number / 60)
        var secs = String(number % 60)
        if(secs.count == 1){
            secs = "00"
        }
        return String(min + ":" + secs)
    }
    
    func startTimer(){
        if !paused{
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.subtractTime), userInfo: nil, repeats: true)
        }
    }
    
    @objc func subtractTime(){
        if(!paused && time! > 0){
            time! -= 1
            statusBarItem.button!.title = convertToTime(number: time!)
        }else if(time! == 0){
            let alert = NSAlert()
            alert.messageText = "Timer ended. Do another?"
        }
    }
    
    

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    


}

