//
//  StringHint.swift
//  Logo Quiz App
//
//  Created by Ramadhan Kalih Sewu on 26/05/22.
//

import Foundation

class StringHint
{
    let hiddenChar: Character = "_"
    let secretString: [Character]
    
    private(set) var hint: [Character]
    
    public init(_ secret: String, reveal: Bool = false)
    {
        secretString = Array(secret)
        hint = reveal ? Array(secret) : [Character](repeating: hiddenChar, count: secret.count)
    }
    
    public init(_ secret: String, hintString: String?)
    {
        secretString = Array(secret)
        hint = hintString == nil ? [Character](repeating: hiddenChar, count: secret.count) : Array(hintString!)
    }
    
    public func fullyHidden() -> Bool
    {
        return hint.contains(where: { $0 != hiddenChar }) == false
    }
    
    public func fullyRevealed() -> Bool
    {
        return hint.contains(where: { $0 == hiddenChar }) == false
    }
    
    public func reveal(_ char: Character)
    {
        hint = hint.enumerated().map { $1 == char ? secretString[$0] : $1 }
    }
    
    public func reveal(at i: Int)
    {
        hint[i] = secretString[i]
    }
    
    public func revealRandom()
    {
        var i = Int(arc4random()) % hint.count
        while (hint[i] != hiddenChar)
        {
            let isEnd = i == hint.count - 1
            i = isEnd ? 0 : i + 1
        }
        reveal(at: i)
    }
}
