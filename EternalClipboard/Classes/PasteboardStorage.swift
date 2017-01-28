//
//  PasteboardStorage
//  EternalClipboard
//
//  Created by Максим Самойлов on 28/01/2017.
//  Copyright © 2017 Maxim Samoilov. All rights reserved.
//

import Cocoa

class PasteboardStorage: NSObject, PasteboardObserverDelegate {
  private(set) public var history: [String]

  init(initialHistory: [String]) {
    history = initialHistory
    super.init()
    let _ = PasteboardObserver(delegate: self)
  }

  func addPasteboardToHistory(_ pasteboard: String) {
    history = history.filter({ $0 != pasteboard }) + [pasteboard]
  }

  func pasteboardUpdated(pasteboard: String) {
    addPasteboardToHistory(pasteboard)
  }
}
