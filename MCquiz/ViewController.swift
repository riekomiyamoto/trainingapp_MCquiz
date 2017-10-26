//
//  ViewController.swift
//  MCquiz
//
//  Created by RiekoMiyamoto on 2017/01/30.
//  Copyright © 2017年 RiekoMiyamoto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    
    var questionList:[String] = []
    var popViewController : PopUpViewControllerSwift!
    var judgeComment:String = ""
    var judgeImageName:String = ""
    //解答を読み込む配列を書く
    var answerList:[String] = []
    //問題数を定義する配列を書く
    var questionCount: Int = 0
    let NextQuestion = "NextQuestion"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        do {
            let csvPath = Bundle.main.path(forResource: "question", ofType: "csv")
            let csvData = try String(contentsOfFile:csvPath!,
                                     encoding:String.Encoding.utf8)
            questionList = csvData.components(separatedBy: "\n")
        } catch {
            print(error)
        }
        
        do {
            let csvPath = Bundle.main.path(forResource: "answer", ofType: "csv")
            let csvData = try String(contentsOfFile:csvPath!, encoding:String.Encoding.utf8)
            answerList = csvData.components(separatedBy: "\n")
        } catch {
            print(error)
        }
        
      //  questionLabel.text = questionList[0]
        
    }
    
    //○×解答後、次の問題を表示させる処理を書く
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        questionLabel.text = questionList[questionCount]
        NotificationCenter.default.addObserver(self, selector:
            #selector(ViewController.nextQ(_:)), name: NSNotification.Name(rawValue:
                NextQuestion), object: nil)
    }
    
    // MARK: - NSNotification Action -
    func nextQ(_ notification: Notification?) {
        
        questionCount += 1
        if (questionCount == 20) {
            questionCount = 0
            questionLabel.text = questionList[questionCount]
        } else {
            questionLabel.text = questionList[questionCount]
        }
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    @IBAction func answerButton(_ sender: AnyObject) {
        
        //クイズ問題の○×解答からtrueまたはfalseを出す処理を書く
        if (sender.tag == Int(answerList[questionCount])) {
            judgeComment = "正解"
            judgeImageName = "true"
        } else {
            judgeComment = "ハズレ"
            judgeImageName = "false"
        }
        
        // popup view.
        if UIScreen.main.bounds.size.width > 320 {
            if UIScreen.main.scale == 3 {
                self.popViewController = PopUpViewControllerSwift(nibName: "PopUpViewController_iPhone6Plus", bundle: nil)
            } else {
                self.popViewController = PopUpViewControllerSwift(nibName: "PopUpViewController_iPhone6", bundle: nil)
            }
        } else {
            self.popViewController = PopUpViewControllerSwift(nibName: "PopUpViewController", bundle: nil)
        }
        self.popViewController.title = ""
        self.popViewController.showInView(self.view, withImage: UIImage(named: judgeImageName), withMessage: judgeComment,
                                          animated: true)

    
    }
    
    
    
    
    


}

