//
//  BaseLabel.swift
//  FamousSaying
//
//  Created by peo on 2022/07/23.
//

import UIKit

final class BaseLabel: UILabel {
    
    enum Size: CGFloat {
        case small = 16
        case normal = 20
        case large = 24
        case extraLarge = 28
    }
    
    init(
        size: Size = .normal,
        textColor: UIColor? = .cBlack,
        weight: UIFont.Weight = .regular
    ) {
        super.init(frame: .zero)
        self.textColor = textColor
        self.font = .systemFont(ofSize: size.rawValue, weight: weight)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
