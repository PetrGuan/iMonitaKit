//
//  ContextMenuSubmenu.swift
//  iMonitaKit
//
//  Created by Petr Guan on 2021/10/21.
//

/// Represents the context menu submenu, contains multiple commands
public struct ContextMenuSubmenu: Identifiable {
  public var id: String { title }

  public let title: String
  public let glyph: String
  /// We should keep submenus to one level.
  public let commands: [ContextMenuCommand]

  public init(title: String, glyph: String, commands: [ContextMenuCommand]) {
    self.title = title
    self.glyph = glyph
    self.commands = commands
  }
}
