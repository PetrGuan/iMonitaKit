//
//  HistogramModel.swift
//  iMonitaKit
//
//  Created by Petr Guan on 2021/10/21.
//

import SwiftUI

public final class HistogramModel: ChartBaseViewModel {
  @Published public var bars: [Bar]
  @Published public var context: HistogramContext

  public init(bars: [Bar], title: String, subtitle: String, context: HistogramContext, contextMenuCommands: [ContextMenuCommand] = [], contextMenuSubmenus: [ContextMenuSubmenu] = []) {
    self.bars = bars
    self.context = context

    super.init(title: title, subtitle: subtitle, contextMenuCommands: contextMenuCommands, contextMenuSubmenus: contextMenuSubmenus)
  }

  override public func createHostingController() -> UIViewController {
    return HostingController(rootView: HistogramView(model: self), frame: displayArea)
  }
}
