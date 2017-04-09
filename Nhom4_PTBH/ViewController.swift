//
//  ViewController.swift
//  Nhom4_PTBH_DuongVanPhu
//
//  Created by PHU on 4/8/17.
//  Copyright © 2017 PHU. All rights reserved.
//Địa chỉ đã tạo trên GITHUB
//https://github.com/Nhom4CD1/W10_G4_D-ngVanPhu_PTBH.git

import UIKit
class ViewController: UIViewController ,UITextFieldDelegate {
    
    
    @IBOutlet weak var input_a: UITextField!
    @IBOutlet weak var input_b: UITextField!
    @IBOutlet weak var btnKQ: UIButton!
    @IBOutlet weak var input_c: UITextField!
    @IBOutlet weak var lbKQ: UILabel!
    @IBOutlet weak var X1: UILabel!
    @IBOutlet weak var X2: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Set đầu vao bàn phím cho TEXTFIELD
        input_a.keyboardType = UIKeyboardType.numberPad
        input_b.keyboardType = UIKeyboardType.numberPad
        input_c.keyboardType = UIKeyboardType.numberPad
        Hide()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //Khai báo biến toàn cục
    var a = Double()
    var b = Double()
    var c = Double()
    var delta = Double()
    var sox1 = Double()
    var sox2 = Double()

    //1. Hàm giải PT bậc hai
    func GiaiPhuongTrinhBacHai() {
        delta = 0
        delta = (b * b) - (4 * a * c)
        lbKQ.isHidden = false
        //delta > 0 có 2no phân biệt
        if delta > 0
        {
            sox1 = ( -b + sqrt(delta)) / (2*a)
            sox2 = ( -b - sqrt(delta)) / (2*a)
            X1.isHidden = false
            X2.isHidden = false
            lbKQ.text = "Hàm đã cho có nghiệm: "
            X1.text = String(format: "X1 = %.4f", sox1)
            X2.text = String(format: "X2 = %.4f", sox2)
        }
            //Có no kép
        else if delta == 0
        {
            sox1 = ( -b + sqrt(delta)) / (2*a)
            X1.isHidden = false
            lbKQ.text = "Hàm đã cho có nghiệm kép: "
            X1.text = String(format: "X1 = X2 =  %.4f", sox1)
        }
            //vô no
        else if delta < 0 {
            lbKQ.text = "Hàm vô nghiệm"
            Hide()
        }
    }
    //2.Hàm  ẩn Kết quả, điều khiển hiển thị của các Label
    func Hide() {
        X2.isHidden = true
        X1.isHidden = true
    }
    
    
    //3. Hàm xu li khi nhan button Giai
    @IBAction func btnKQ_Act(_ sender: Any) {
       //Kiểm tra điều kiện đầu vào nếu rỗng thị hiện cảnh báo
        if (input_a.text == "" || input_b.text == "" || input_c.text == "")
        {
            lbKQ.isHidden = false
            lbKQ.text = "Bạn cần điền đầy đủ giá trị!"
            return
        }
        //Lấy giá trị Input gán cho các biến
        
        a = Double(input_a.text!)!
        b = Double(input_b.text!)!
        c = Double(input_c.text!)!

        //Nếu a=0  PhuongTrinhBacNhat
        if a == 0 {
            Hide()
            lbKQ.isHidden = false
            lbKQ.text = "Không phải Phương trình bậc hai. Vui lòng nhập lại"
        }
            //Nếu không, gọi hàm GiaiPhuongTrinhBacHai
        else if a != 0 {
            Hide()
            GiaiPhuongTrinhBacHai()
        }
    }
}




