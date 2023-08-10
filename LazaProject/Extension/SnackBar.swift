//
//  SnackBar.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 09/08/23.
//

import SnackBar

class AppSnackBar: SnackBar {
  
  override var style: SnackBarStyle {
    var style = SnackBarStyle()
    style.background = .green
    style.textColor = .black
    return style
  }
}
