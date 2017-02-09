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
  public func manualUpdate() {
    update();
  }

  private let timeInterval = TimeInterval(0.65)
  private let delegate: PasteboardObserverDelegate
  private var lastPasteboardItem: String?

  init(delegate: PasteboardObserverDelegate) {
    self.delegate = delegate
    super.init()
    startObserving()
  }

  private func startObserving() {
    Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true, block: { _ in self.update() })
  }

  private func update() {
    if let copiedText = getPasteboardContext() {
      if (copiedText != lastPasteboardItem) {
        self.delegate.pasteboardUpdated(pasteboard: copiedText)
        lastPasteboardItem = copiedText
      }
    }
  }

  private func getPasteboardContext() -> String? {
    return NSPasteboard.general().string(forType: NSPasteboardTypeString)
  }
}
