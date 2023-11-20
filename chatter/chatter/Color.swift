//
//  Color.swift
//  chatter
//
//  Created by 이민규 on 11/20/23.
//

import SwiftUI

public extension Color {
  
  static func hexToColor(hex: String) -> UIColor {
    let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
    var int: UInt64 = 0
    Scanner(string: hex).scanHexInt64(&int)
    return UIColor(red: CGFloat(int >> 16) / 255,
                   green: CGFloat(int >> 8 & 0xFF) / 255,
                   blue: CGFloat(int & 0xFF) / 255,
                   alpha: 1)
  }
  
  static func dynamicColor(_ light: String, dark: String? = nil) -> Color {
    let lightColor = hexToColor(hex: light)
    if dark == nil {
      return Color(lightColor)
    } else {
      let darkColor = hexToColor(hex: dark!)
      return Color(UIColor { $0.userInterfaceStyle == .dark ? darkColor : lightColor })
    }
  }
  
  static let background: Color = dynamicColor("#27262C")
}
