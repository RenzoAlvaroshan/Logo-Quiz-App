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
    let level: Int
    let guessImageName: String
    let answerImageName: String
    
    static let list = [
        Logo(name: "Aqua",      level: 1, guessImageName: "AQUA",       answerImageName: "AQUA_A"     ),
        Logo(name: "Djarum",    level: 1, guessImageName: "DJARUM",     answerImageName: "DJARUM_A"   ),
        Logo(name: "Pertamina", level: 1, guessImageName: "PERTAMINA",  answerImageName: "PERTAMINA_A"),
        Logo(name: "PLN",       level: 1, guessImageName: "PLN",        answerImageName: "PLN_A"      ),
        Logo(name: "SCTV",      level: 1, guessImageName: "SCTV",       answerImageName: "SCTV_A"     ),
        Logo(name: "Telkom",    level: 1, guessImageName: "TELKOM",     answerImageName: "TELKOM_A"   ),
        Logo(name: "Tiket.com", level: 1, guessImageName: "TIKET.COM",  answerImageName: "TIKET.COM_A"),
    ]
}
