
import Foundation

class Operations {
    
    var stackJD:Stack=Stack<String>()
    var output:String=""
    var numbers:String="0123456789."
    
    func infixToPostFixTJ(input:String)->String{
        
        var i: Int = 0
        let soKyTu = input.characters.count
        while i < soKyTu
        {
            
            let index = input.index(input.startIndex, offsetBy: i) //will call succ 2 times
       
            let ch:String=String(input[index])
            
            switch String(ch)!
            {
            case "+":
                XuLyToanTu(pheptinh: String(ch),uuTien: 1)
                break
            case "-":
                XuLyToanTu(pheptinh: String(ch),uuTien: 1)
                break
            case "*":
                XuLyToanTu(pheptinh: String(ch),uuTien: 2)
                break
            case "/":
                XuLyToanTu(pheptinh: String(ch),uuTien: 2)
                break
            case "(":
                stackJD.push(String(ch))
                break
            case ")":
                XuLyDongNgoac(ch: String(ch))
                break
            default:
                
                output+=" "
                while (i<input.characters.count && numbers.contains(String(getChar(input: input,i: i))))
                {
                   
                    output+=String(getChar(input: input,i: i))
                    i+=1
                }
                i-=1
                break
                
            }
            i+=1
        }
        while (!stackJD.isEmpty) {
            output+=" "
            output+=stackJD.pop()!
        }
        return output
    }
    
    func getChar(input:String,i:Int)->String{
        let indexDef = input.index(input.startIndex, offsetBy: i)
        let chDef:String=String(input[indexDef])
        
        return chDef
    }
    public func XuLyToanTu(pheptinh:String,uuTien:Int) {
        while !stackJD.isEmpty {
            let toanTu:String=stackJD.pop()!
        
            if(toanTu=="(")
            {
                stackJD.push(toanTu)
                break
            }
            else{
                var xetUuTien:Int=0
                if(toanTu=="+"||toanTu=="-")
                {
                    xetUuTien=1
                }
                else
                {
                    xetUuTien=2
                }
                if(xetUuTien<uuTien)
                {
                    stackJD.push(toanTu)
                    break
                }
                else
                {
                    output+=" "
                    output+=toanTu
                }
            }
        }
        stackJD.push(pheptinh)
    }
   
     func XuLyDongNgoac(ch:String)
    {
        while !stackJD.isEmpty {
            let chx:String=stackJD.pop()!
            if(chx=="(")
            {
                break
            }
            else
            {
                output+=" "
                output+=chx
            }
        }
    }
    
    
    
}
