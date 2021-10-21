//
//  Text.swift
//  iMonitaKit
//
//  Created by Petr Guan on 2021/10/21.
//

import SwiftUI

struct TitleText: View {
  let title: String

  var body: some View {
    Text(title)
      .foregroundColor(.gray)
      .font(Font.system(size: 14.0, design: .serif))
      .multilineTextAlignment(.center)
      .padding(EdgeInsets(top: 10.0, leading: 0, bottom: 0, trailing: 0))
  }
}

struct SubtitleText: View {
  let subtitle: String

  var body: some View {
    Text(subtitle)
      .font(Font.system(size: 10.0))
      .foregroundColor(.black)
      .multilineTextAlignment(.center)
  }
}

struct TitleText_Previews: PreviewProvider {
  static var previews: some View {
    TitleText(title: "Hello World")
  }
}
