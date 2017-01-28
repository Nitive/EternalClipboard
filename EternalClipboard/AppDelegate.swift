//
//  AppDelegate.swift
//  EternalClipboard
//
//  Created by Максим Самойлов on 28/01/2017.
//  Copyright © 2017 Maxim Samoilov. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, PasteboardObserverDelegate {
  fileprivate var observer: PasteboardObserver?

  override init() {
    super.init()
    observer = PasteboardObserver(delegate: self)
  }
  
  func pasteboardUpdated(pasteboard: String) {
    print("update", pasteboard)
  }

  func applicationDidFinishLaunching(_ aNotification: Notification) {
    // Insert code here to initialize your application
  }

  func applicationWillTerminate(_ aNotification: Notification) {
    // Insert code here to tear down your application
  }


}

