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


class ViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {
  private let pasteboardStorage = PasteboardStorage(initialHistory: [])

  override func viewDidLoad() {
    super.viewDidLoad()
    pasteboardStorage.manualUpdate();
    observeGlobalKeyDows(onKeyDown)
    tableView.delegate = self
    tableView.dataSource = self;
  }

  @IBOutlet weak var tableView: NSTableView!

  func numberOfRows(in tableView: NSTableView) -> Int {
    return pasteboardStorage.history.count
  }

  func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
    let cell = tableView.make(withIdentifier: "clipboardContent", owner: self) as! NSTableCellView
    let reversedIndex = pasteboardStorage.history.count - row - 1
    cell.textField?.stringValue = pasteboardStorage.history[reversedIndex]
    return cell
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
    pasteboardStorage.manualUpdate();
    tableView.reloadData()
  }
}

