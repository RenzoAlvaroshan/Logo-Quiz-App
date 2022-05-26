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
        Logo(name: "Binus",         level: 1, guessImageName: "BINUS",          answerImageName: "BINUS_A"    ),
        Logo(name: "Bluebird",      level: 1, guessImageName: "BLUE BIRD",      answerImageName: "BLUE BIRD_A"),
        Logo(name: "Djarum",        level: 1, guessImageName: "DJARUM",         answerImageName: "DJARUM_A"   ),
        Logo(name: "Pertamina",     level: 1, guessImageName: "PERTAMINA",      answerImageName: "PERTAMINA_A"),
        Logo(name: "PLN",           level: 1, guessImageName: "PLN",            answerImageName: "PLN_A"      ),
        Logo(name: "RCTI",          level: 1, guessImageName: "RCTI",           answerImageName: "RCTI_A"     ),
        Logo(name: "SCTV",          level: 1, guessImageName: "SCTV",           answerImageName: "SCTV_A"     ),
        Logo(name: "Telkom",        level: 1, guessImageName: "TELKOM",         answerImageName: "TELKOM_A"   ),
        Logo(name: "Tiket.com",     level: 1, guessImageName: "TIKET.COM",      answerImageName: "TIKET.COM_A"),
        
        Logo(name: "Ajaib",         level: 2, guessImageName: "AJAIB",          answerImageName: "AJAIB_A"       ),
        Logo(name: "Alfamart",      level: 2, guessImageName: "ALFAMART",       answerImageName: "ALFAMART_A"    ),
        Logo(name: "BCA",           level: 2, guessImageName: "BCA",            answerImageName: "BCA_A"         ),
        Logo(name: "BSD City",      level: 2, guessImageName: "BSD CITY",       answerImageName: "BSD CITY_A"    ),
        Logo(name: "Erafone",       level: 2, guessImageName: "ERAPHONE",       answerImageName: "ERAPHONE_A"    ),
        Logo(name: "Indomaret",     level: 2, guessImageName: "INDOMARET",      answerImageName: "INDOMARET_A"   ),
        Logo(name: "Orang Tua",     level: 2, guessImageName: "ORANG TUA",      answerImageName: "ORANG TUA_A"   ),
        Logo(name: "Pegadaian",     level: 2, guessImageName: "PEGADAIAN",      answerImageName: "PEGADAIAN_A"   ),
        Logo(name: "Siantar Top",   level: 2, guessImageName: "SIANTAR TOP",    answerImageName: "SIANTAR TOP_A" ),
        Logo(name: "Summarecon",    level: 2, guessImageName: "SUMMARECON",     answerImageName: "SUMMARECON_A"  ),
        
        Logo(name: "Anter Aja",     level: 3, guessImageName: "ANTER AJA",      answerImageName: "ANTER AJA_A"   ),
        Logo(name: "Garuda",        level: 3, guessImageName: "GARUDA",         answerImageName: "GARUDA_A"      ),
        Logo(name: "Gojek",         level: 3, guessImageName: "GOJEK",          answerImageName: "GOJEK_A"       ),
        Logo(name: "Gudang Garam",  level: 3, guessImageName: "GUDANG GARAM",   answerImageName: "GUDANG GARAM_A"),
        Logo(name: "Indomeie",      level: 3, guessImageName: "INDOMIE",        answerImageName: "INDOMIE_A"     ),
        Logo(name: "KAI",           level: 3, guessImageName: "KAI",            answerImageName: "KAI_A"         ),
        Logo(name: "SiCepat",       level: 3, guessImageName: "SI CEPAT",       answerImageName: "SI CEPAT_A"    ),
        Logo(name: "Teh Botol",     level: 3, guessImageName: "TEH BOTOL",      answerImageName: "TEH BOTOL_A"   ),
        Logo(name: "TIX ID",        level: 3, guessImageName: "TIX ID",         answerImageName: "TIX ID_A"      ),
        Logo(name: "Tokopedia",     level: 3, guessImageName: "TOKOPEDIA",      answerImageName: "TOKOPEDIA_A"   ),
        
        Logo(name: "ABC",           level: 4, guessImageName: "ABC",            answerImageName: "ABC_A"),
        Logo(name: "Batik Keris",   level: 4, guessImageName: "BATIK KERIS",    answerImageName: "BATIK KERIS_A"),
        Logo(name: "BNI",           level: 4, guessImageName: "BNI",            answerImageName: "BNI_A"),
        Logo(name: "Bukalapak",     level: 4, guessImageName: "BUKALAPAK",      answerImageName: "BUKALAPAK_A"),
        Logo(name: "Dua Kelinci",   level: 4, guessImageName: "DUA KELINCI",    answerImageName: "DUA KELINCI_A"),
        Logo(name: "Hokben",        level: 4, guessImageName: "HOKBEN",         answerImageName: "HOKBEN_A"),
        Logo(name: "Matahari",      level: 4, guessImageName: "MATAHARI",       answerImageName: "MATAHARI_A"),
        Logo(name: "Nutrisari",     level: 4, guessImageName: "NUTRISARI",      answerImageName: "NUTRISARI_A"),
        Logo(name: "Sampoerna",     level: 4, guessImageName: "SAMPOERNA",      answerImageName: "SAMPOERNA_A"),
        Logo(name: "Universitas Indonesia", level: 4, guessImageName: "UNIVERSITAS INDONESIA", answerImageName: "UNIVERSITAS INDONESIA_A"),
        
        Logo(name: "Astra International", level: 5, guessImageName: "ASTRA INTERNATIONAL", answerImageName: "ASTRA INTERNATIONAL_A"),
        Logo(name: "Dana",          level: 5, guessImageName: "DANA",          answerImageName: "DANA_A"),
        Logo(name: "Indihome",      level: 5, guessImageName: "INDIHOME",      answerImageName: "INDIHOME_A"),
        Logo(name: "Indofood",      level: 5, guessImageName: "INDOFOOD",      answerImageName: "INDOFOOD_A"),
        Logo(name: "Kopi Kenangan", level: 5, guessImageName: "KOPI KENANGAN", answerImageName: "KOPI KENANGAN_A"),
        Logo(name: "Kopiko",        level: 5, guessImageName: "KOPIKO",        answerImageName: "KOPIKO_A"),
        Logo(name: "Mandiri",       level: 5, guessImageName: "MANDIRI",       answerImageName: "MANDIRI_A"),
        Logo(name: "Mayora",        level: 5, guessImageName: "MAYORA",        answerImageName: "MAYORA_A"),
        Logo(name: "Universitas Gadjah Mada", level: 5, guessImageName: "UNIVERSITAS GADJAH MADA", answerImageName: "UNIVERSITAS GADJAH MADA_A"),
        Logo(name: "Universitas Brawijaya", level: 5, guessImageName: "UNIVERSITAS BRAWIJAYA", answerImageName: "UNIVERSITAS BRAWIJAYA_A")
    ]
}
