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
        Logo(name: "Aqua",          level: 1, guessImageName: "AQUA",           answerImageName: "AQUA_A"     ),
        Logo(name: "Djarum",        level: 1, guessImageName: "DJARUM",         answerImageName: "DJARUM_A"   ),
        Logo(name: "Pertamina",     level: 1, guessImageName: "PERTAMINA",      answerImageName: "PERTAMINA_A"),
        Logo(name: "PLN",           level: 1, guessImageName: "PLN",            answerImageName: "PLN_A"      ),
        Logo(name: "SCTV",          level: 1, guessImageName: "SCTV",           answerImageName: "SCTV_A"     ),
        Logo(name: "Telkom",        level: 1, guessImageName: "TELKOM",         answerImageName: "TELKOM_A"   ),
        Logo(name: "RCTI",          level: 1, guessImageName: "RCTI",           answerImageName: "RCTI_A"     ),
        Logo(name: "Tiket.com",     level: 1, guessImageName: "TIKET.COM",      answerImageName: "TIKET.COM_A"),
        
        Logo(name: "Ajaib",         level: 2, guessImageName: "AJAIB",          answerImageName: "AJAIB_A"       ),
        Logo(name: "Alfamart",      level: 2, guessImageName: "ALFAMART",       answerImageName: "ALFAMART_A"    ),
        Logo(name: "Anter Aja",     level: 2, guessImageName: "ANTER AJA",      answerImageName: "ANTER AJA_A"   ),
        Logo(name: "Binus",         level: 2, guessImageName: "BINUS",          answerImageName: "BINUS_A"       ),
        Logo(name: "Bluebird",      level: 2, guessImageName: "BLUE BIRD",      answerImageName: "BLUE BIRD_A"   ),
        Logo(name: "BSD City",      level: 2, guessImageName: "BSD CITY",       answerImageName: "BSD CITY_A"    ),
        Logo(name: "Erafone",       level: 2, guessImageName: "ERAPHONE",       answerImageName: "ERAPHONE_A"    ),
        Logo(name: "Gudang Garam",  level: 2, guessImageName: "GUDANG GARAM",   answerImageName: "GUDANG GARAM_A"),
        Logo(name: "Indomaret",     level: 2, guessImageName: "INDOMARET",      answerImageName: "INDOMARET_A"   ),
        Logo(name: "Orang Tua",     level: 2, guessImageName: "ORANG TUA",      answerImageName: "ORANG TUA_A"   ),
        Logo(name: "Pegadaian",     level: 2, guessImageName: "PEGADAIAN",      answerImageName: "PEGADAIAN_A"   ),
        Logo(name: "SiCepat",       level: 2, guessImageName: "SI CEPAT",       answerImageName: "SI CEPAT_A"    ),
        Logo(name: "Siantar Top",   level: 2, guessImageName: "SIANTAR TOP",    answerImageName: "SIANTAR TOP_A" ),
        Logo(name: "Summarecon",    level: 2, guessImageName: "SUMMARECON",     answerImageName: "SUMMARECON_A"  ),
        Logo(name: "TIX ID",        level: 2, guessImageName: "TIX ID",         answerImageName: "TIX ID_A"      ),
    ]
}
