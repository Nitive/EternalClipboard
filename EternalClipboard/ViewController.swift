//
//  ViewController.swift
//  EternalClipboard
//
//  Created by Максим Самойлов on 28/01/2017.
//  Copyright © 2017 Maxim Samoilov. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
  fileprivate let pasteboardStorage = PasteboardStorage(initialHistory: [])

  @IBAction func onClick(_ sender: NSButton) {
    print(pasteboardStorage.history)
  }

}

