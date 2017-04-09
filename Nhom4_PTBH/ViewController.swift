//
//  ViewController.swift
//  Nhom4_PTBH
//
//  Created by THANH on 4/8/17.
//  Copyright © 2017 THANH. All rights reserved.
//Địa chỉ đã tạo trên GITHUB
//https://github.com/Nhom4CD1/WEEK10_NguyenThanhAn_PTBH.git

import UIKit
extension String {
    static let numberFormatter = NumberFormatter()
    var doubleValue: Double {
        String.numberFormatter.decimalSeparator = "."
        if let result =  String.numberFormatter.number(from: self) {
            return result.doubleValue
        } else {
            String.numberFormatter.decimalSeparator = ","
            if let result = String.numberFormatter.number(from: self) {
                return result.doubleValue
            }
        }
        return 0
    }
}
class ViewController: UIViewController ,UITextFieldDelegate {
    
    @IBOutlet weak var input_a: UITextField!
    @IBOutlet weak var input_b: UITextField!
    @IBOutlet weak var input_c: UITextField!
    @IBOutlet weak var btnKQ: UIButton!
    @IBOutlet weak var btnReset: UIButton!
    @IBOutlet weak var lbKQ: UILabel!
    @IBOutlet weak var lbX1: UILabel!
    @IBOutlet weak var lbX2: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.input_a.delegate = self
        self.input_b.delegate = self
        self.input_c.delegate = self
        //Set đầu vao bàn phím cho TEXTFIELD
        input_a.keyboardType = UIKeyboardType.numberPad
        input_b.keyboardType = UIKeyboardType.numberPad
        input_c.keyboardType = UIKeyboardType.numberPad
        Hide()// Ẩn các label thông báo khi chaỵ úng dungj
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    var a = Double()
    var b = Double()
    var c = Double()
    var delta = Double()
    var x1 = Double()
    var x2 = Double()
    var PTB1 = Bool()
    var PTB2 = Bool()
    
    //1.Hàm kiểm tra điều kiện, nếu a == 0 sẽ gọi hàm giải PTBN ngược lại sẽ Gọi Hàm GPTBH
    func KiemTraDieuKien() {
        if a == 0 {
            PTB1 = true
            PTB2 = false
        } else if a != 0 {
            PTB2 = true
            PTB1 = false
        }
    }
    
    // 2.Hàm tính Delta
    func Delta() -> Double {
        delta = 0
        delta = (b * b) - (4 * a * c)
        return delta
    }
    
    //3. Nếu a =0, quay về giải PT bậc nhất
    func PhuongTrinhBacNhat()
    {
        lbKQ.isHidden = false
        if(b != 0) {
            x1 = -c / b
            lbKQ.text = "Hàm đã cho là PTBN ,có 1 nghiệm: "
            lbX1.isHidden = false
            //Để format số  thực ta có thể định dạng như sau
            lbX1.text = String(format: "X = %.4f", x1)
        }
        else if b == 0{
            if(c == 0) {
                lbKQ.text = "Hàm đã cho là PTBN,có vô số nghiệm: "
            }
            else {
                lbKQ.text = "Hàm đã cho là PTBN ,vô nghiệm: "
            }
        }
    }
    
    //4. Hàm giải PT bậc hai
    func GiaiPhuongTrinhBacHai() {
        lbKQ.isHidden = false
        if delta > 0
        {
            x1 = ( -b + sqrt(delta)) / (2*a)
            x2 = ( -b - sqrt(delta)) / (2*a)
            lbX1.isHidden = false
            lbX2.isHidden = false
            lbKQ.text = "Hàm đã cho có nghiệm: "
            lbX1.text = String(format: "X1 = %.4f", x1)
            lbX2.text = String(format: "X2 = %.4f", x2)
        }
        else if delta == 0
        {
            x1 = ( -b + sqrt(delta)) / (2*a)
            lbX1.isHidden = false
            lbKQ.text = "Hàm đã cho có nghiệm kép: "
            lbX1.text = String(format: "X1 = X2 =  %.4f", x1)
        }
        else if delta < 0 {
            lbKQ.text = "Hàm vô nghiệm"
            Hide()
        }
    }
    //5.Hàm  ẩn Kết quả, điều khiển hiển thị của các Label
    func Hide() {
        lbX2.isHidden = true
        lbX1.isHidden = true
    }
    
    
    //Hàm xu li khi nhan button Giai
    @IBAction func btnKQ_Act(_ sender: Any) {
       //Kiểm tra điều kiện đầu vào
        if (input_a.text == "" || input_b.text == "" || input_c.text == "")
        {
            lbKQ.isHidden = false
            lbKQ.text = "Bạn cần điền đầy đủ giá trị!"
            return
        }
        //Lấy giá trị Input gán cho các biến
        // let a1 = String(format:"%.4f", input_a.text!.doubleValue)
        a = Double(String(format:"%.4f", input_a.text!.doubleValue))!
        b = Double(String(format:"%.4f", input_b.text!.doubleValue))!
        c = Double(String(format:"%.4f", input_c.text!.doubleValue))!
        
        KiemTraDieuKien()
        //Nếu a=0 Gọi hàm PhuongTrinhBacNhat
        if PTB1 == true {
            Hide()
            PhuongTrinhBacNhat()
        }
            //Nếu không, gọi hàm GiaiPhuongTrinhBacHai
        else if PTB2 == true {
            Hide()
            Delta()
            GiaiPhuongTrinhBacHai()
        }
    }
    //Set lai gia tri ban dau
    @IBAction func btnReset_Act(_ sender: Any) {
        Hide()
        input_a.text = ""
        input_b.text = ""
        input_c.text = ""
        lbKQ.text = ""
        input_a.isFocused
    }
    
    //========Hàm KIỂM TRA tính hợp lệ của dữ liệu đầu vào nhập vào TEXT FIELD
    // SẼ CHẠY VÀ KIỂM TRA LIÊN TỤC INPUT TRONG LÚC NHẬP, CHỈ CHẤP NHẬN GIÁ TRỊ KHI
    //HÀM TRẢ VỀ LÀ     TRUE , NGƯỢC LẠI SẼ HIỆN CẢNH BÁO
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //Input chỉ chứa các CHỮ SỐ từ 0 -> 9
        let inverseSet = NSCharacterSet(charactersIn:"0123456789").inverted
        
        //CHỨA CÁC CHỮ SỐ TÁCH RA TỪ STRING
        let components = string.components(separatedBy: inverseSet)
        //NỐI CÁC KÍ TỰ SỐ LẠI
        let filtered = components.joined(separator: "")
        
        //NẾU INPUT KHÔNG CHỨA THÊM KÍ TỰ KHÔNG HỢP LỆ(), SẼ TRẢ VỀ TRUE
        if filtered == string {
            lbKQ.isHidden = true
            return true
        }
            //KIỂM TRA SỐ DẤU CHẤM THẬP PHÂN (<=1 :HỢP LỆ)
        else if string == "." || string == ","
        {
            let countdots = textField.text!.components(separatedBy:".").count - 1
            let countcommas = textField.text!.components(separatedBy:",").count - 1
            if countdots == 0 && countcommas == 0
            {
                lbKQ.isHidden = true
                return true
            }
            else
            {
                if (countdots > 0 && (string == "." || string == "," )) || (countcommas > 0 && (string == "," || string == "." ))
                {
                    lbKQ.isHidden = false
                    lbKQ.text = "Giá trị không hợp lệ"
                    return false
                } else
                {
                    lbKQ.isHidden = true
                    return true
                }
            }
        }
            
            //TRƯỜNG HỢP KIỂU SỐ CÓ DẤU ()
        else {
            if string == "-" || string == "+"
            {
                if (textField.text!.isEmpty == true)
                {
                    return true
                }
                else
                {
                    lbKQ.isHidden = false
                    lbKQ.text = "Giá trị không hợp lệ"
                    return false
                }
            }
            else {
                lbKQ.isHidden = false
                lbKQ.text = "Giá trị không hợp lệ"
                return false
            }
        }
    }
}




