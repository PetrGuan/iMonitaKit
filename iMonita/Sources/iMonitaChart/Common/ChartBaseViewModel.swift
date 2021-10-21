//
//  BaseViewModel.swift
//  iMonitaKit
//
//  Created by Petr Guan on 2021/10/21.
//

import SwiftUI

public class ChartBaseViewModel: ObservableObject {
  @Published public var title: String
  @Published public var subtitle: String

  /// Display Area of the monitor
  public var displayArea = CGRect(x: 0, y: 100, width: 200, height: 160)

  // Context Menu
  public var contextMenuCommands: [ContextMenuCommand]
  public var contextMenuSubmenus: [ContextMenuSubmenu]

  public init(title: String, subtitle: String, contextMenuCommands: [ContextMenuCommand], contextMenuSubmenus: [ContextMenuSubmenu]) {
    self.title = title
    self.subtitle = subtitle
    self.contextMenuCommands = contextMenuCommands
    self.contextMenuSubmenus = contextMenuSubmenus
  }

  /// For UIKit/SwiftUI to work together, wrapping your SwiftUI view with a UIHostingController
  public func createHostingController() -> UIViewController {
    fatalError("Subclass required override")
  }
}
