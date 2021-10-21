//
//  Bar.swift
//  iMonitaKit
//
//  Created by Petr Guan on 2021/10/21.
//

public struct Bar: Identifiable {
  public let id: UUID
  let value: Double
  let legend: Legend

  public init(value: Double, legend: Legend) {
    id = UUID()
    self.value = value
    self.legend = legend
  }
}
