//
//  CardViewDelegate.swift
//  FamousSaying
//
//  Created by peo on 2022/07/26.
//

protocol CardViewDelegate: AnyObject {
    func didLeftSwipe()
    
    func didRightSwipe()
    
    func didTapFavoriteButton()
}
