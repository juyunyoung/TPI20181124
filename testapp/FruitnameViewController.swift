//
//  FruitnameViewController.swift
//  testapp
//
//  Created by 주 윤령 on 14/01/2019.
//  Copyright © 2019 주 윤령. All rights reserved.
//

import UIKit

class FruitnameViewController: UIViewController {

    @IBOutlet var imageview: UIImageView!
    var timer:Timer?
    var count = 0
    let fruitimageDic = [0:"apple.png",1:"pear.png",2:"peach.png",3:"strawberry.png",4:"weatermelon.png",5:"plum.png",6:"orientalmelon.png",7:"orange.png"]
    let fruitNameDic = [0:"사과",1:"배",2:"복숭아",3:"딸기",4:"수박",5:"자두",6:"참외",7:"오렌지"]
    var imageValueArr:Array = Array<Int>()
   
    @IBOutlet weak var namebutton1: UIButton!
    @IBOutlet weak var namebutton2: UIButton!
    @IBOutlet weak var namebutton3: UIButton!
    @IBOutlet weak var namebutton4: UIButton!
    @IBOutlet weak var namebutton5: UIButton!
    @IBOutlet weak var nextlevelbutton: UIButton!
  //  var buttonObjectDic = [0:self.namebutton1,1:self.namebutton2,2:self.namebutton3,3:self.namebutton4,4:self.namebutton5]
    var clickcount:Int = 0
    var rightanswer:Int = 0
    
    @IBAction func itemButton(_ sender: UIButton) {
         let buttonname:String = sender.currentTitle!
        
        if(buttonname == fruitNameDic[imageValueArr[clickcount]]){
            setdata("nameR")
            if(clickcount == 4){
                
                rightanswer += 1
                if(rightanswer == 1){
                    
                    let alertController  = UIAlertController(title: "축하해요", message: "NEXT 버튼을 클릭해서 다음 스테이지로 갈까요?", preferredStyle: .alert)
                    let alertAction  = UIAlertAction(title: "확인", style: .destructive) { (result:UIAlertAction) -> Void in }
                    alertController.addAction(alertAction)
                    self.present(alertController, animated: true, completion: setdefault)
                    nextlevelbutton.isHidden = false
                }else{
                    setdefault()
                }
            }else{
                sender.isHidden = true
                clickcount += 1
            }

        }else{
            setdata("nameW")
            let alertController = UIAlertController(title: "이런", message: "다시한번 해볼까요?", preferredStyle: .alert)
            let alertbutton = UIAlertAction(title: "확인", style: .destructive) { (result:UIAlertAction) ->  Void in }
            alertController.addAction(alertbutton)
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setdefault()
        nextlevelbutton.isHidden = true
    }
    
  
    func setdefault(){
        namebutton1.isHidden = true
        namebutton2.isHidden = true
        namebutton3.isHidden = true
        namebutton4.isHidden = true
        namebutton5.isHidden = true
        imageview.isHidden = false
        count = 0
        clickcount = 0
        setimage()
        startTimer()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startTimer(){
        
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
    
    @objc func update(){
        if(count < 5){
           imageview.image = UIImage(named: fruitimageDic[imageValueArr[count]]!)
            count += 1
        }else{
            self.timer?.invalidate()
            self.timer = nil
            var temp = imageValueArr
            temp.shuffle()
            namebutton1.setTitle(fruitNameDic[temp[0]], for: .normal)
            namebutton2.setTitle(fruitNameDic[temp[1]], for: .normal)
            namebutton3.setTitle(fruitNameDic[temp[2]], for: .normal)
            namebutton4.setTitle(fruitNameDic[temp[3]], for: .normal)
            namebutton5.setTitle(fruitNameDic[temp[4]], for: .normal)
            imageview.isHidden = true
            namebutton1.isHidden = false
            namebutton2.isHidden = false
            namebutton3.isHidden = false
            namebutton4.isHidden = false
            namebutton5.isHidden = false
        }
    }
    
    func setimage(){
        imageValueArr.removeAll()
        while imageValueArr.count < 5 {
            let numValue:Int = Int.random(in: 0...7)
            if(!imageValueArr.contains(numValue)){
                imageValueArr.append(numValue)
            }
        }
    }
    
    func setdata(_ buttonname:String){
        let path = Bundle.main.path(forResource: "data", ofType:"plist")
        let data = NSMutableDictionary(contentsOfFile: path!)
        
        var countnum:Float = data?.value(forKey: buttonname)as! Float
        countnum += 1
        data?.setValue(countnum, forKey: buttonname)
        data?.write(toFile: path!, atomically: true)
        
    }
}
