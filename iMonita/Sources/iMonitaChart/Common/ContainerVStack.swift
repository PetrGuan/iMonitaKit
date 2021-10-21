//
//  ContainerVStack.swift
//  iMonitaKit
//
//  Created by Petr Guan on 2021/10/21.
//

import SwiftUI

struct ContainerVStack<Content: View>: View {
  @ObservedObject var model: ChartBaseViewModel

  let content: () -> Content

  init(model: ChartBaseViewModel, @ViewBuilder content: @escaping () -> Content) {
    self.model = model
    self.content = content
  }

  var body: some View {
    // There's a nasty blank screen bug for context menu, related to SwiftUI
    if #available(iOS 14.2, *), hasContextMenu {
      base
        .contextMenu {
          // Commands
          ForEach(model.contextMenuCommands) { command in
            Button(action: command.action) {
              Text(command.title)
              Image(systemName: command.glyph)
                .renderingMode(.original)
            }
          }

          // Submenus
          ForEach(model.contextMenuSubmenus) { submenu in
            Menu {
              ForEach(submenu.commands) { command in
                Button(action: command.action) {
                  Text(command.title)
                  Image(systemName: command.glyph)
                    .renderingMode(.original)
                }
              }
            } label: {
              Text(submenu.title)
              Image(systemName: submenu.glyph)
                .renderingMode(.original)
            }
          }
        }
    }
    else {
      base
    }
  }

  private var base: some View {
    VStack {
      TitleText(title: model.title)

      SubtitleText(subtitle: model.subtitle)

      Divider()

      GeometryReader { geo in
        content()
          // on iOS 13, content will get zero size from GeometryReader if we didn't set its frame
          .frame(width: geo.size.width, height: geo.size.height)
      }
    }
    .background(Color.white)
    .overlay(RoundedRectangle(cornerRadius: 2.0).stroke(Color.gray, lineWidth: 1.0))
    .edgesIgnoringSafeArea(.all)
  }

  private var hasContextMenu: Bool {
    return !model.contextMenuCommands.isEmpty || !model.contextMenuSubmenus.isEmpty
  }
}
