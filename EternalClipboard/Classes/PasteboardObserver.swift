//
//  PasteboardObserver.swift
//  EternalClipboard
//
//  Created by Максим Самойлов on 28/01/2017.
//  Copyright © 2017 Maxim Samoilov. All rights reserved.
//

import Cocoa

protocol PasteboardObserverDelegate {
  func pasteboardUpdated(pasteboard: String) -> Void
}

class PasteboardObserver: NSObject {
  fileprivate let timeInterval = TimeInterval(0.65)
  fileprivate let delegate: PasteboardObserverDelegate
  fileprivate var lastPasteboardItem: String?

  init(delegate: PasteboardObserverDelegate) {
    self.delegate = delegate
    super.init()
    startObserving()
  }

  fileprivate func startObserving() {
    Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true, block: self.update)
  }

  fileprivate func update(timer: Timer) {
    if let copiedText = getPasteboardContext() {
      if (copiedText != lastPasteboardItem) {
        self.delegate.pasteboardUpdated(pasteboard: copiedText)
        lastPasteboardItem = copiedText
      }
    }
  }

  fileprivate func getPasteboardContext() -> String? {
    return NSPasteboard.general().string(forType: NSPasteboardTypeString)
  }
}
