//
//  InfixToPostfixSW.swift
//  CalculatorV01_group3
//
//  Created by Tran Nhat Tuan on 5/4/18.
//  Copyright © 2018 Tran Nhat Tuan. All rights reserved.
//

import Foundation

class InfixToPostfixSW{
    
    var numbers="0123456789."
    var output:String=""
    class func infixToPostfixEvaluation(input: String) -> String {
    let stack: Stack = Stack<Character>(size: input.characters.count)
        
            for j in 0..<input.characters.count {
                var ch: String = input.index(after: String.Index,1)
                switch ch {
                case "+":
                    break
                case "-":
                    XuLyToanTu(ch,1)
                    break
                case "*":
                    break
                case "/":
                     XuLyToanTu(ch,2)
                     break
                case "(":
                    stack.push(ch)
                    break
                case ")":
                    XuLyDongNgoac(ch)
                    break
                default:
                    output+=" "
                    while j < input.length() && numbers.contains(input.charAt(j) + "") {
                        output += input.charAt(j) + ""
                        j += 1
                    }
                    j -= 1

                }
            }
        }
            while !stack.isEmpty() {
                output += " "
                output += stack.pop()
        }
        System.out.println(output)
        return output
        
    }
}
