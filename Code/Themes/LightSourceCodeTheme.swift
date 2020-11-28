//
//  LightSourceCodeTheme.swift
//  Code
//
//  Created by Joshua Rutkowski on 11/28/20.
//

import Sourceful
import Foundation

public struct LightSourceCodeTheme: SourceCodeTheme {
    
    public init() {
        
    }
    
    public func globalAttributes() -> [NSAttributedString.Key: Any] {
        
        var attributes = [NSAttributedString.Key: Any]()
        
        attributes[.font] = font
        attributes[.foregroundColor] = Color.black
        
        return attributes
    }
    
    
    private static var lineNumbersColor: Color {
        return Color(red: 100/255, green: 168/255, blue: 168/255, alpha: 1.0)
    }
    
    public let lineNumbersStyle: LineNumbersStyle? = LineNumbersStyle(font: Font(name: "Menlo", size: 16)!, textColor: lineNumbersColor)
    
    public let gutterStyle: GutterStyle = GutterStyle(backgroundColor: Color(red: 255/255.0, green: 255/255, blue: 255/255, alpha: 1.0), minimumWidth: 32)
    
    public let font = Font(name: "Menlo", size: 15)!
    
    public let backgroundColor = Color(red: 255/255.0, green: 255/255, blue: 255/255, alpha: 1.0)
    
    public func color(for syntaxColorType: SourceCodeTokenType) -> Color {
        
        switch syntaxColorType {
        case .plain:
            return .black
            
        case .number:
            return Color(red: 57/255, green: 59/255, blue: 219/255, alpha: 1.0)
            
        case .string:
            return Color(red: 211/255, green: 59/255, blue: 40/255, alpha: 1.0)
            
        case .identifier:
            return Color(red: 62/255, green: 128/255, blue: 135/255, alpha: 1.0)
            
        case .keyword:
            return Color(red: 173/255, green: 61/255, blue: 164/255, alpha: 1.0)
            
        case .comment:
            return Color(red: 112/255.0, green: 127/255.0, blue: 140/255.0, alpha: 1.0)
        case .editorPlaceholder:
            return backgroundColor
        }
        
    }
    
}
