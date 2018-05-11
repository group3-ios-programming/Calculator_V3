//
//  ViewController.swift
//  CalculatorV01_group3
//
//  Created by Tran Nhat Tuan on 5/3/18.
//  Copyright © 2018 Tran Nhat Tuan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var btnNumber: UIButton!
    @IBOutlet weak var lbKetQua: UILabel!
    @IBOutlet weak var btnAC: UIButton!
    @IBOutlet weak var btnChia: UIButton!
    @IBOutlet weak var btnTru: UIButton!
    @IBOutlet weak var btnNhan: UIButton!
    @IBOutlet weak var btnCong: UIButton!
    @IBOutlet weak var btnDongMoNgoac: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var btnCham: UIButton!
    @IBOutlet weak var btnAmDuong: UIButton!
    
    @IBOutlet weak var btnResult: UIButton!
  
    var demMoNgoac:Int=0
    var isMoNgoac:Bool=true
    var isDaCham:Bool=true
    var operators="+-*/"
    var pressResult:Bool=false
    @IBAction func btnResultAction(_ sender: Any) {
        
        let last1 = String(lbKetQua.text!.characters.suffix(1))
        if(last1=="(")
        {
            showToast(message: "Dạng toán không hợp lệ")
        }
        else
        {
        
        while (demMoNgoac > 0) { /*Kiểm tra dấu đóng ngoặc còn thiếu*/
            lbKetQua.text=lbKetQua.text!+")"
            demMoNgoac-=1;
        }
        result()
    }
    }
    
    
    @IBAction func btnAmDuongAction(_ sender: Any) {
        if(checkFullSize())
        {
        if(lbKetQua.text!==""||lbKetQua.text=="0")
        {
            lbKetQua.text!="(-"
            demMoNgoac+=1
        }
        else
        {
        if(checkLaToanHang(chuoi: lbKetQua.text!))
        {
            let lastChar = String(lbKetQua.text!).characters.suffix(1)
            if(String(lastChar)==")")
            {
                lbKetQua.text! = lbKetQua.text!+"X(-"
                demMoNgoac+=1
            }
            else
            {
                
                    lbKetQua.text! = lbKetQua.text!+"(-"
                    demMoNgoac+=1
            }
        }
        }
        chinhLable()
        pressResult=false
        }
    }
    
    @IBAction func btnChamAction(_ sender: Any) {
        if(checkFullSize())
        {
        if(isDaCham==true)
        {
            if(checkLaToanHang(chuoi:lbKetQua.text!))
            {
                lbKetQua.text=lbKetQua.text!+"0."
            }
            else
            {
                lbKetQua.text=lbKetQua.text!+"."
            }
        }
        isDaCham=false
        chinhLable()
        pressResult=false
        }
    }
    
//    func layViTriCanChenDauAm(chuoi:String)->Int
//    {
//        var pos = -1
//        for char in chuoi.characters{
//            if(checkLaToanHang(chuoi: String(char)))
//            {
//                if let idx = chuoi.characters.index(of: char) {
//                    pos = chuoi.characters.distance(from: chuoi.startIndex, to: idx)
//                }
//            }
//            
//        }
//         return pos
//    }
    
    func getChar(input:String,i:Int)->String{
        let indexDef = input.index(input.startIndex, offsetBy: i)
        let chDef:String=String(input[indexDef])
        
        return chDef
    }
    
    func checkChia0(input:String)->Bool
    {
        let check1="/0*"
        let check2="/0+"
        let check3="/0-"
        let check4="/0)"
        let check5="/0/"
        let check6="/0.*"
        let check7="/0.+"
        let check8="/0.-"
        let check9="/0.)"
        let check10="/0./"
        let last2 = String(input.characters.suffix(2))
        let last3 = String(input.characters.suffix(3))
      
        if(input.contains(check1)||input.contains(check2)||input.contains(check3)||input.contains(check4)||input.contains(check5)||input.contains(check6)||input.contains(check7)||input.contains(check8)||input.contains(check9)||input.contains(check10)||last2=="/0"||last3=="/0.")
        {
            return true

        }
        return false
    }
 
    func checkPress0(input:String)->Bool{
        
        let last2 = String(input.characters.suffix(2))
        let check1="÷0"
        let check2="X0"
        let check3="-0"
        let check4="+0"
        let check5="(0"
        
        if(last2==check1||last2==check2||last2==check3||last2==check4||last2==check5)
        {
            return true
            
        }
        return false
    }
    
    func checkKhongHopLe(input:String)->Bool
    {
        let last1 = String(input.characters.suffix(1))
        let last2 = String(input.characters.suffix(2))
        if(last1=="+"||last1=="-"||last1=="*"||last1=="/"||last1=="("||last2=="()"||last2=="((")
        {
            return true
        }
        return false
    }
    
    
    func result()
    {
        
        var stackTinh=Stack<String>()
        var inputVL=lbKetQua.text
        var result:String=""
        var tinhToan=[String]()
        var ketqua=0.0
       
     
        inputVL=inputVL!.replacingOccurrences(of: "X", with: "*")
        inputVL=inputVL!.replacingOccurrences(of: "÷", with: "/")
        inputVL=inputVL!.replacingOccurrences(of: "(-", with: "(0-")
        
       
        
        if(checkKhongHopLe(input: inputVL!)){
            showToast(message: "Ký tự cuối không hợp lệ")
        }
        else
        {
        if(checkChia0(input: inputVL!))
        {
            showToast(message: "Lỗi chia cho 0")
        }
        else
        {
            result = Operations().infixToPostFixTJ(input: inputVL!)
            //let result2 = Operations.infixToPostfixEvaluation(evaluation!)
            print("input: "+inputVL!)
            // print("result2: "+result2)
            print("result: "+String(result))
            //lbKetQua.text=String(result)
            
            result=result.trimmingCharacters(in: .whitespacesAndNewlines) //Xoa khoang trang thua
            tinhToan = result.components(separatedBy: " ") // cat chuoi theo tung khoang trang
            for i in 0..<tinhToan.count
            {
                if(operators.contains(tinhToan[i])){
                    var num1:Double=Double(stackTinh.pop()!)!
                    var num2:Double=Double(stackTinh.pop()!)!
                    var num=0.0
                    var s=tinhToan[i]
                    switch (s)
                    {
                    case "+":
                        num = num2 + num1;
                        break;
                    case "-":
                        num = num2 - num1;
                        break;
                    case "*":
                        num = num2 * num1;
                        break;
                    case "/":
                        num = num2 / num1;
                        break;
                    default:
                        break;
                    }
                    stackTinh.push(String(num))
                }
                else
                {
                    stackTinh.push(tinhToan[i])
                }
            }
            ketqua=Double(stackTinh.top!)!
            print("ketqua:"+String(ketqua))
            lbKetQua.text=String(ketqua)
            pressResult=true
            isMoNgoac=true
            demMoNgoac=0
        }
        }
    }

    func chinhLable()
    {
        if(lbKetQua.text!.characters.count>12)
        {
            lbKetQua.font=UIFont.systemFont(ofSize: 30.0)
        }
        else
        {
            lbKetQua.font=UIFont.systemFont(ofSize: 50.0)
        }
    }
    
    func checkFullSize()->Bool
    {
        if(lbKetQua.text!.characters.count<30)
        {
            return true
        }
        return false
    }
    
    func checkNhanTruocDongNgoac(chuoi:String)->Bool
    {
        let lastChar = String(chuoi.characters.suffix(1))
        if (lastChar==")")
        {
            return true
        }
        return false
    }
    
    func checkMoNgoacLast(chuoi:String)->Bool
    {
        let lastChar = String(chuoi.characters.suffix(1))
        if (lastChar=="(")
        {
            return true
        }
        return false
    }
    
    
    func checkLaToanHang(chuoi:String) -> Bool
    {
        let lastChar = String(chuoi.characters.suffix(1))
        if (lastChar=="X" || lastChar=="-" || lastChar=="+" || lastChar=="÷"||lastChar=="("||lastChar==")")
        {
            return true
        }
        return false
    }

    func checkMoNgoac(chuoi:String)->Bool
    {
            let lastChar = String(chuoi.characters.suffix(1))
            if(lastChar=="1" || lastChar=="2" || lastChar=="3" || lastChar=="4"||lastChar=="5" || lastChar=="6" || lastChar=="7" || lastChar=="8"||lastChar=="9" || lastChar=="0"||lastChar=="+" || lastChar=="-" || lastChar=="X" || lastChar=="÷"||lastChar=="."||lastChar=="("||(lastChar==")"&&demMoNgoac==0))
            {
                return true;
            }
            return false;
    }
    
    
    func checkKyTuAmDauTieu(chuoi:String)->Bool
    {
        let char=chuoi.characters.first
        if(char=="-")
        {
            return true
        }
        return false
    }
    
    func checkDongNgoac(chuoi:String)->Bool
    {
            let lastChar = String(chuoi.characters.suffix(1))
            if((lastChar=="1" || lastChar=="2" || lastChar=="3" || lastChar=="4"||lastChar=="5" || lastChar=="6" || lastChar=="7" || lastChar=="8"||lastChar=="9"||lastChar=="0"||lastChar==")") && isMoNgoac==false && demMoNgoac>0)
            {
                return true
            }
            return false
    }

    func checkSo0(chuoi:String)->Bool
    {
      
        if(chuoi=="0"||chuoi=="")
        {
            return true
        }
        return false

    }
    func kiemTraTruocDolaSo(chuoi:String)->Bool
    {
        let lastChar = String(chuoi.characters.suffix(1))
        if(lastChar=="1" || lastChar=="2" || lastChar=="3" || lastChar=="4"||lastChar=="5" || lastChar=="6" || lastChar=="7" || lastChar=="8"||lastChar=="9"||lastChar=="0")
        {
            return true
        }
        return false
    }
    
    @IBAction func btnDongMoNgoacAction(_ sender: Any) {
        if(checkFullSize())
        {
        isDaCham=true
        if(lbKetQua.text=="0"||((checkMoNgoac(chuoi: lbKetQua.text!)==true&&isMoNgoac==true)))
            {
                if(lbKetQua.text=="0") {
                    lbKetQua.text=""
                }
                if(kiemTraTruocDolaSo(chuoi:lbKetQua.text!))
                {
                    lbKetQua.text=lbKetQua.text!+"X("
                }
                else{
                    if(checkNhanTruocDongNgoac(chuoi: lbKetQua.text!)&&demMoNgoac==0)
                    {
                        lbKetQua.text=lbKetQua.text!+"X("
                    }
                    else
                    {
                    lbKetQua.text=lbKetQua.text!+"("
                    }
                }
            isMoNgoac=true
            demMoNgoac += 1
            
        }
        else
        {
            if(checkDongNgoac(chuoi: lbKetQua.text!)&&demMoNgoac > 0)
            {
                lbKetQua.text=lbKetQua.text!+")" 
                demMoNgoac-=1
                if(demMoNgoac==0)
                {
                    isMoNgoac=true
                }
            }
            
            
        }
        chinhLable()
        pressResult=false
        }
    }
    @IBAction func btnXoaAction(_ sender: Any) {
        
        let lastChar = String(lbKetQua.text!.characters.suffix(1))
        if(String(lastChar)==")")
        {
            demMoNgoac+=1
            if (isDaCham == true) {
                isDaCham = true;
            } else {
                isDaCham = false;
            }
        }
        else
        {
            if(String(lastChar)=="("){
                demMoNgoac-=1
                if (isDaCham == true) {
                    isDaCham = true;
                } else {
                    isDaCham = false;
                }
            }
            else
            {
                if(String(lastChar)=="+"||String(lastChar)=="-"||String(lastChar)=="X"||String(lastChar)=="÷")
                {
                    if (isDaCham == true) {
                        isDaCham = true;
                    } else {
                        isDaCham = false;
                    }

                }
                else
                {
                if(String(lastChar)==".")
                {
                    isDaCham=true
                    }}
            }

        }
        
        lbKetQua.text=String(lbKetQua.text!.characters.dropLast())
        if(lbKetQua.text!=="")
        {
            lbKetQua.text="0"
            demMoNgoac=0
            isDaCham=true
        }
        chinhLable()
          pressResult=false
    }
    
    
    func laPhepTinh(pheptinh:String) -> Bool
    {
        let lastChar = String(pheptinh.characters.suffix(1))
        if(lastChar=="+" || lastChar=="-" || lastChar=="X" || lastChar=="÷" )
        {
            return true;
        }
        return false;
    }
    
    
    func showToast(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    func kiemTraNhapDau1Lan(pheptinh:Character)
    {
        if(checkSo0(chuoi:lbKetQua.text!))
        {
            lbKetQua.text="0"
        }
        else{
        if(laPhepTinh(pheptinh: lbKetQua.text!))
        {
            lbKetQua.text!=String(lbKetQua.text!.characters.dropLast())
            lbKetQua.text=(lbKetQua.text!+String(pheptinh))
        }
        else
        {
            lbKetQua.text=(lbKetQua.text!+String(pheptinh))
        }
 }
    }
    
    @IBAction func btnChiaAction(_ sender: Any) {
        if(checkFullSize()&&checkMoNgoacLast(chuoi: lbKetQua.text!)==false)
        {
        isDaCham=true
        kiemTraNhapDau1Lan(pheptinh:"÷")
        pressResult=false
        isMoNgoac=true
        chinhLable()
        }
    }

    
    @IBAction func btnNhanAction(_ sender: Any) {
        if(checkFullSize()&&checkMoNgoacLast(chuoi: lbKetQua.text!)==false)
        {
        isDaCham=true
        kiemTraNhapDau1Lan(pheptinh:"X")
        pressResult=false
        isMoNgoac=true
        chinhLable()
        }
    }
    @IBAction func btnTruAction(_ sender: Any) {
        if(checkFullSize()&&checkMoNgoacLast(chuoi: lbKetQua.text!)==false)
        {
        isDaCham=true
        kiemTraNhapDau1Lan(pheptinh:"-")
        pressResult=false
        chinhLable()
        isMoNgoac=true
        }
    }
    @IBAction func btnCongAction(_ sender: Any) {
        if(checkFullSize()&&checkMoNgoacLast(chuoi: lbKetQua.text!)==false)
        {
        isDaCham=true
        kiemTraNhapDau1Lan(pheptinh:"+")
        pressResult=false
        chinhLable()
        isMoNgoac=true
        }
    }
    
    @IBAction func btnACAction(_ sender: Any) {
        
         lbKetQua.text="0"
         demMoNgoac=0
         isDaCham=true
        isMoNgoac=true
        pressResult=false
        chinhLable()
    }
    @IBAction func btnNumberAction(_ sender: Any) {
        if(checkFullSize())
        {
        if (lbKetQua.text == "0"||pressResult==true)
        {
            
            lbKetQua.text=""
            lbKetQua.text = lbKetQua.text! + String((sender as AnyObject).tag - 1)
            pressResult=false
            
        }
        else
        {
            if(checkNhanTruocDongNgoac(chuoi: lbKetQua.text!))
            {
                lbKetQua.text=String(lbKetQua.text!)+"X("+String((sender as AnyObject).tag - 1)
                pressResult=false
                demMoNgoac+=1
            }
            else
            {
                //check nhan 0 truoc cac dau x/+-
                if(checkPress0(input: lbKetQua.text!))
                {
                    lbKetQua.text=String(lbKetQua.text!.characters.dropLast())
                lbKetQua.text = lbKetQua.text! + String((sender as AnyObject).tag - 1)
                    pressResult=false
}
                else
                {
                    lbKetQua.text = lbKetQua.text! + String((sender as AnyObject).tag - 1)
                    pressResult=false
}
            }
        }
      
            
            
        if(kiemTraTruocDolaSo(chuoi: lbKetQua.text!)==true&&demMoNgoac>0){
            isMoNgoac=false
        }
        chinhLable()
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

