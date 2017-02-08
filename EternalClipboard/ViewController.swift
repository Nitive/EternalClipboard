//
//  ViewController.swift
//  EternalClipboard
//
//  Created by Максим Самойлов on 28/01/2017.
//  Copyright © 2017 Maxim Samoilov. All rights reserved.
//

import Cocoa

func observeGlobalKeyDows(_ handler: @escaping (_ event: NSEvent) -> Void) {
  let opts = NSDictionary(object: kCFBooleanTrue, forKey: kAXTrustedCheckOptionPrompt.takeUnretainedValue() as NSString) as CFDictionary

  guard AXIsProcessTrustedWithOptions(opts) == true else { return }
  NSEvent.addGlobalMonitorForEvents(matching: .keyDown, handler: handler)
}


class ViewController: NSViewController {
  fileprivate let pasteboardStorage = PasteboardStorage(initialHistory: [])

  override func viewDidLoad() {
    super.viewDidLoad()
    observeGlobalKeyDows(onKeyDown)
  }

  internal func onKeyDown(event: NSEvent) {
    let control = event.modifierFlags.contains(NSEventModifierFlags.control)
    let cmd = event.modifierFlags.contains(NSEventModifierFlags.command)
    let c = event.keyCode == 8
    if control && cmd && c {
      openSearch()
    }
  }

  internal func openSearch() {
    NSRunningApplication.current().activate(options: [NSApplicationActivationOptions.activateIgnoringOtherApps])
  }

  @IBAction func onClick(_ sender: NSButton) {
    print(pasteboardStorage.history)
  }

}

