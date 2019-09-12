//
//  UIFont+Extension.swift
//  BanjoLocation
//
//  Created by Carlos Jimenez on 9/11/19.
//

import UIKit

//swiftlint:disable all
extension UIFont {

    @objc class func mySystemFont(ofSize size: CGFloat) -> UIFont {
        return banjo_normalFont(withSize: size)
    }

    @objc class func myBoldSystemFont(ofSize size: CGFloat) -> UIFont {
        return banjo_boldFont(withSize: size)
    }

    @objc class func myLightSystemFont(ofSize size: CGFloat) -> UIFont {
        return banjo_boldFont(withSize: size)
    }

    @objc class func myItalicSystemFont(ofSize size: CGFloat) -> UIFont {
        return banjo_italicFont(withSize: size)
    }

    public class func overrideInitialize() {
        guard self == UIFont.self else { return }

        if let systemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:))),
            let mySystemFontMethod = class_getClassMethod(self, #selector(mySystemFont(ofSize:))) {
            method_exchangeImplementations(systemFontMethod, mySystemFontMethod)
        }

        if let boldSystemFontMethod = class_getClassMethod(self, #selector(boldSystemFont(ofSize:))),
            let myBoldSystemFontMethod = class_getClassMethod(self, #selector(myBoldSystemFont(ofSize:))) {
            method_exchangeImplementations(boldSystemFontMethod, myBoldSystemFontMethod)
        }

        if let italicSystemFontMethod = class_getClassMethod(self, #selector(italicSystemFont(ofSize:))),
            let myItalicSystemFontMethod = class_getClassMethod(self, #selector(myItalicSystemFont(ofSize:))) {
            method_exchangeImplementations(italicSystemFontMethod, myItalicSystemFontMethod)
        }
    }

    static private func loadFontWith(name: String) {
        let bundle = Bundle(for: DashboardFactory.self)
        let pathForResourceString = bundle.path(forResource: name, ofType: "ttf")
        let fontData = NSData(contentsOfFile: pathForResourceString!)
        let dataProvider = CGDataProvider(data: fontData!)
        let fontRef = CGFont(dataProvider!)
        var errorRef: Unmanaged<CFError>?

        if !CTFontManagerRegisterGraphicsFont(fontRef!, &errorRef) {
            NSLog("Failed to register font - register graphics font failed - this font may have already been registered in the main bundle.")
        }
    }

    static private func banjoFont(name: String, size: CGFloat) -> UIFont {
        if let font = UIFont(name: name, size: size) {
            return font
        } else {
            loadFontWith(name: name)
            return UIFont(name: name, size: size)!
        }
    }
    /// Return the default font type used in the app
    ///
    /// - Parameter withSize: The font size
    /// - Returns: An instance of UIFont
    static func banjo_normalFont(withSize size: CGFloat) -> UIFont {
        return banjoFont(name: "OpenSans-Regular", size: size)
    }

    /// Return the default  bold type
    ///
    /// - Parameters:
    /// - Parameter withSize: The font size
    /// - Returns: An instance of UIFont
    static func banjo_boldFont(withSize size: CGFloat) -> UIFont {
        return banjoFont(name: "OpenSans-Bold", size: size)
    }

    /// Return the default italic type
    ///
    /// - Parameters:
    /// - Parameter withSize: The font size
    /// - Returns: An instance of UIFont
    static func banjo_italicFont(withSize size: CGFloat) -> UIFont {
        return banjoFont(name: "OpenSans-RegularItalic", size: size)
    }

    /// Return the default light type
    ///
    /// - Parameters:
    /// - Parameter withSize: The font size
    /// - Returns: An instance of UIFont
    static func banjo_LightFont(withSize size: CGFloat) -> UIFont {
        return banjoFont(name: "OpenSans-Light", size: size)
    }
}
