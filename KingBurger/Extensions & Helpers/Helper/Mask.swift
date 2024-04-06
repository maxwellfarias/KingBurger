//
//  Mask.swift
//  KingBurger
//
//  Created by Maxwell Farias on 28/08/23.
//

import Foundation
import UIKit

class Mask {
    
    private let mask: String
    var oldString = ""
    
    init(mask: String) {
        self.mask = mask
    }
    
    private func replaceChars(value: String) -> String {
        // receber uma string com . / -, etc
        // e depois iremos remover esses chars
        return value.replacingOccurrences(of: ".", with: "")
            .replacingOccurrences(of: "-", with: "")
            .replacingOccurrences(of: "/", with: "")
            .replacingOccurrences(of: " ", with: "")
        
    }
    
    func process(value: String) -> String? {
        if value.count > mask.count {
            return String(value.dropLast())
        }
       
        // aqui temos a str sem caracteres especiais
        let str = replaceChars(value: value)
        
        let isDeleting = str <= oldString
        
        if value.count == mask.count {
            return nil
        }
        
        
        oldString = str
        
        var result = ""
        // ###.###.###-##
        
        var i = 0
        for char in mask {
            if char != "#" {
                if isDeleting {
                    continue
                }
                
                result = result + String(char)
            } else {
                let character = str.charAtIndex(i)
                guard let c = character else { break }
                
                result = result + String(c)
                i = i + 1
            }
        }
        
        return result
    }
    
}
