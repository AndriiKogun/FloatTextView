//
//  CFloatTextView.swift
//  MyFloatTextView
//
//  Created by Andrii on 2/1/18.
//  Copyright © 2018 Andrii. All rights reserved.
//

import UIKit

class CFloatTextView: UIView, UITextViewDelegate {
    
    let scale: CGFloat = 0.8
    var label = UILabel()
    var textView = UITextView()
    var centerConstraint: NSLayoutConstraint!
    var topConstraint: NSLayoutConstraint!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor.white
        addSubview(label)
        addSubview(textView)
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.topAnchor.constraint(equalTo: topAnchor, constant: 40).isActive = true
        textView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        textView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        textView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        textView.isScrollEnabled = false
        textView.font = UIFont.systemFont(ofSize: 18)
        
        textView.delegate = self
        textView.backgroundColor = UIColor.clear

        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        label.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
//        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        label.text = "Team Motto"
        label.backgroundColor = UIColor.red
        
        
        centerConstraint = label.centerYAnchor.constraint(equalTo: textView.centerYAnchor)
        topConstraint = label.bottomAnchor.constraint(equalTo: textView.topAnchor)
        
        textView.layoutIfNeeded()
        label.layoutIfNeeded()
        
        if textView.text.isEmpty {
            centerConstraint.isActive = true
        } else {
            topConstraint.isActive = true
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        layoutIfNeeded()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            centerConstraint.isActive = false
            topConstraint.isActive = true
            
            let offset = (self.label.bounds.width - self.label.bounds.width * scale) / 2
            
            
//            (self.label.bounds.width - self.label.bounds.width * 0.3) / 2
            
//            label.text = self.label.text?.uppercased()
            
            UIView.animate(withDuration: 0.3, animations: {
                
                var transform = CGAffineTransform.identity
                transform = transform.scaledBy(x: self.scale, y: self.scale)
                transform = transform.translatedBy(x: -offset / self.scale, y: 0)
                self.label.transform = transform
                self.layoutIfNeeded()
            })
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            topConstraint.isActive = false
            centerConstraint.isActive = true
            
            label.text = self.label.text?.capitalized
            
            UIView.animate(withDuration: 0.3, animations: {
                self.label.transform = .identity
                self.layoutIfNeeded()
            })
        }
    }
    
}
