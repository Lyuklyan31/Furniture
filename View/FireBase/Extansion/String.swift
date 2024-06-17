//
//  String.swift
//  FurnitureBeta
//
//  Created by admin on 27.05.2024.
//

import Foundation

extension String {
    func isValidEmail() -> Bool {
        //test@email.com -> true
        // test.com -> false
        
    let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)

        return regex.firstMatch(in: self, range: NSRange(location: 0, length: count)) != nil
    }
}

extension String {
    func isValidPhoneNumber() -> Bool {
        let phoneNumberRegex = "^(\\+380)\\d{9}$" 
        return NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex).evaluate(with: self)
    }
}

extension String {
    func isValidPassword() -> Bool {
        let passwordRegex = NSPredicate(format: "SELF MATCHES %@",
                                        "^(?=.*[a-z])(?=.*[$@$#!%*?&])(?=.*[A-Z]).{6,}$")
        return passwordRegex.evaluate(with: self)
    }
}
