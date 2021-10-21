//
//  Legend.swift
//  iMonitaKit
//
//  Created by Petr Guan on 2021/10/21.
//

import SwiftUI

/// The legend of chart
public struct Legend {
  let label: String
  let color: Color

  public init(label: String, color: Color) {
    self.label = label
    self.color = color
  }
}
