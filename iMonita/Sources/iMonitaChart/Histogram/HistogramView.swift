//
//  HistogramView.swift
//  iMonitaKit
//
//  Created by Petr Guan on 2021/10/21.
//

import SwiftUI

public struct HistogramView: View {
  @ObservedObject private var model: HistogramModel

  public init(model: HistogramModel) {
    self.model = model
  }

  public var body: some View {
    ContainerVStack(model: model) {
      Histogram(model: model)
    }
  }
}

struct HistogramView_Previews: PreviewProvider {
  static var previews: some View {
    let bars = [
      Bar(value: 15.0, legend: Legend(label: "Memory", color: .blue)),
      Bar(value: 25.0, legend: Legend(label: "Memory", color: .blue)),
      Bar(value: 35.0, legend: Legend(label: "Memory", color: .blue)),
      Bar(value: 40, legend: Legend(label: "Memory", color: .blue)),
      Bar(value: 40, legend: Legend(label: "Memory", color: .red)),
    ]
    let model = HistogramModel(bars: bars, title: "Hello", subtitle: "World", context: HistogramContext(displayLimit: 10))

    HistogramView(model: model)
  }
}
