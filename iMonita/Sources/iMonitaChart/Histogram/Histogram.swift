//
//  Histogram.swift
//  iMonitaKit
//
//  Created by Petr Guan on 2021/10/21.
//

import SwiftUI

struct Histogram: View {
  private enum Constants {
    static let cornerRadius: CGFloat = 4.0
  }

  @ObservedObject private var model: HistogramModel

  private var max: Double {
    let value = model.bars.map { $0.value }.max() ?? 1.0
    return value == 0 ? 1.0 : value
  }

  private var suffixBars: [Bar] {
    return model.bars.suffix(model.context.displayLimit)
  }

  init(model: HistogramModel) {
    self.model = model
  }

  var body: some View {
    GeometryReader { geometry in
      HStack(alignment: .bottom) {
        ForEach(suffixBars) { bar in
          RoundedRectangle(cornerRadius: Constants.cornerRadius)
            .fill(bar.legend.color)
            .frame(height: CGFloat(bar.value) / CGFloat(max) * geometry.size.height)
        }
      }
      .frame(minHeight: geometry.size.height, alignment: .bottom)
    }
  }
}

struct Histogram_Previews: PreviewProvider {
  static var previews: some View {
    let bars = [
      Bar(value: 15.0, legend: Legend(label: "Memory", color: .blue)),
      Bar(value: 25.0, legend: Legend(label: "Memory", color: .blue)),
      Bar(value: 35.0, legend: Legend(label: "Memory", color: .blue)),
      Bar(value: 40, legend: Legend(label: "Memory", color: .blue)),
      Bar(value: 40, legend: Legend(label: "Memory", color: .red)),
    ]
    let model = HistogramModel(bars: bars, title: "Hello", subtitle: "World", context: HistogramContext(displayLimit: 10))

    Histogram(model: model)
  }
}
