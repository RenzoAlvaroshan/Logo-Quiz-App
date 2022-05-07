//
//  Logo.swift
//  Logo Quiz App
//
//  Created by Mohammad Alfarisi on 05/05/22.
//

import Foundation

struct Logo
{
    let name: String
    let imageUrl: String
    let level: Int
    
    static let list = [
        Logo(name: "Aqua",      imageUrl: "AQUA",       level: 0),
        Logo(name: "Djarum",    imageUrl: "DJARUM",     level: 0),
        Logo(name: "Pertamina", imageUrl: "PERTAMINA",  level: 0),
        Logo(name: "PLN",       imageUrl: "PLN",        level: 0),
        Logo(name: "SCTV",      imageUrl: "SCTV",       level: 0),
        Logo(name: "Telkom",    imageUrl: "TELKOM",     level: 0),
        Logo(name: "Tiket.com", imageUrl: "TIKET.COM",  level: 0),
        
        Logo(name: "1Aqua",      imageUrl: "AQUA",       level: 1),
        Logo(name: "1Djarum",    imageUrl: "DJARUM",     level: 1),
        Logo(name: "1Pertamina", imageUrl: "PERTAMINA",  level: 1),
        Logo(name: "1PLN",       imageUrl: "PLN",        level: 1),
        Logo(name: "1SCTV",      imageUrl: "SCTV",       level: 1),
        Logo(name: "1Telkom",    imageUrl: "TELKOM",     level: 1),
        Logo(name: "1Tiket.com", imageUrl: "TIKET.COM",  level: 1),
        
        Logo(name: "2Aqua",      imageUrl: "AQUA",       level: 2),
        Logo(name: "2Djarum",    imageUrl: "DJARUM",     level: 2),
        Logo(name: "2Pertamina", imageUrl: "PERTAMINA",  level: 2),
        Logo(name: "2PLN",       imageUrl: "PLN",        level: 2),
        Logo(name: "2SCTV",      imageUrl: "SCTV",       level: 2),
        Logo(name: "2Telkom",    imageUrl: "TELKOM",     level: 2),
        Logo(name: "2Tiket.com", imageUrl: "TIKET.COM",  level: 2),
    ]
}
