//
//  ContextMenuCommand.swift
//  iMonitaKit
//
//  Created by Petr Guan on 2021/10/21.
//

/// Represents a context menu command
/// Note: Currently only >= iOS 14.2 supports our context menu feature
public struct ContextMenuCommand: Identifiable {
  public var id: String { title }

  public let title: String
  public let glyph: String
  public let action: () -> Void

  public init(title: String, glyph: String, action: @escaping () -> Void) {
    self.title = title
    self.glyph = glyph
    self.action = action
  }
}
