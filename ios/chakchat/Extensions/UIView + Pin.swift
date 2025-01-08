//
//  UIView + Pin.swift
//  chakchat
//
//  Created by Кирилл Исаев on 07.01.2025.
//

import UIKit
//MARK: - Pins
extension UIView {
    func pinTop(_ otherView: UIView, _ const: Double) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: otherView.topAnchor, constant: const).isActive = true
    }
    
    func pinTop(_ anchor: NSLayoutYAxisAnchor, _ const: Double) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: anchor, constant: const).isActive = true
    }
    
    func pinBottom(_ otherView: UIView, _ const: Double) {
        translatesAutoresizingMaskIntoConstraints = false
        bottomAnchor.constraint(equalTo: otherView.bottomAnchor, constant: -1 * const).isActive = true
    }
    
    func pinBottom(_ anchor: NSLayoutYAxisAnchor, _ const: Double) {
        translatesAutoresizingMaskIntoConstraints = false
        bottomAnchor.constraint(equalTo: anchor, constant: -1 * const).isActive = true
    }
    
    func pinLeft(_ otherView: UIView, _ const: Double) {
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: otherView.leadingAnchor, constant: const).isActive = true
    }
    
    func pinLeft(_ anchor: NSLayoutXAxisAnchor, _ const: Double) {
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: anchor, constant: const).isActive = true // leading аналогично trailing
    }
    
    func pinRight(_ otherView: UIView, _ const: Double) {
        translatesAutoresizingMaskIntoConstraints = false
        trailingAnchor.constraint(equalTo: otherView.trailingAnchor, constant: -1 * const).isActive = true
    }
    
    func pinRight(_ anchor: NSLayoutXAxisAnchor, _ const: Double) {
        translatesAutoresizingMaskIntoConstraints = false
        trailingAnchor.constraint(equalTo: anchor, constant: -1 * const).isActive = true // trailingAnchor == rightAnchor, но он работает в отличие от rightAnchor
    }
    
    func pinCentreX(_ other: UIView, _ const: Double = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: other.centerXAnchor, constant: const).isActive = true
    }
    
    func pinCentreX(_ anchor: NSLayoutXAxisAnchor, _ const: Double = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: anchor, constant: const).isActive = true
    }
    
    func pinCentreY(_ other: UIView, _ const: Double = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: other.centerYAnchor, constant: const).isActive = true
    }
    
    func pinCentreY(_ anchor: NSLayoutYAxisAnchor, _ const: Double = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: anchor, constant: const).isActive = true
    }
    
    func pinCentre(_ otherView: UIView) {
        pinCentreX(otherView)
        pinCentreY(otherView)
    }
    
    func setHeight(_ const: Double) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: const).isActive = true
    }
    
    func setWidth(_ const: Double) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: const).isActive = true
    }
    
    func pinWidth(_ otherView: UIView, _ mult: Double) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalTo: otherView.widthAnchor, multiplier: mult).isActive = true
    }
    
    func pinWidth(_ dimension: NSLayoutDimension, _ mult: Double) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalTo: dimension, multiplier: mult).isActive = true
    }
    
    func pinHeight(_ otherView: UIView, _ mult: Double) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalTo: otherView.heightAnchor, multiplier: mult).isActive = true
    }
    
    func pinHeight(_ dimension: NSLayoutDimension, _ mult: Double) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalTo: dimension, multiplier: mult).isActive = true
    }
        
    func pinHorizontal(_ otherView: UIView, _ const: Double = 0) {
        pinLeft(otherView, const)
        pinRight(otherView, const)
    }
        
    func pinVertical(_ otherView: UIView, _ const: Double = 0) {
        pinTop(otherView, const)
        pinBottom(otherView, const)
    }
        
    func pin(_ otherView: UIView, _ const: Double = 0) {
        pinHorizontal(otherView, const)
        pinVertical(otherView, const)
    }
}
    
