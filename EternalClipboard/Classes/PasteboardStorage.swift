//
//  PasteboardStorage
//  EternalClipboard
//
//  Created by Максим Самойлов on 28/01/2017.
//  Copyright © 2017 Maxim Samoilov. All rights reserved.
//

import Cocoa

class PasteboardStorage: NSObject, PasteboardObserverDelegate {
  fileprivate var observer: PasteboardObserver?
  public var history: [String]

  init(initialHistory: [String]) {
    history = initialHistory
    super.init()
    observer = PasteboardObserver(delegate: self)
  }

  func addPasteboardToHistory(_ pasteboard: String) {
    history = history.filter({ $0 != pasteboard }) + [pasteboard]
  }

  func pasteboardUpdated(pasteboard: String) {
    addPasteboardToHistory(pasteboard)
  }
}
