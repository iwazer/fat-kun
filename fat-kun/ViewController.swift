//
//  ViewController.swift
//  fat-kun
//
//  Created by 岩澤 英治 on 2016/04/28.
//  Copyright © 2016年 Mapion. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let url = NSURL(fileURLWithPath: NSTemporaryDirectory()).URLByAppendingPathComponent("work").URLByAppendingPathComponent("fat-file.txt")
    let fm = NSFileManager.defaultManager()
    var data: NSData!

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        let attributes = try! fm.attributesOfItemAtPath(url.path!)
        let sizeAttr = attributes[NSFileSize] as! NSNumber
        let size = sizeAttr.unsignedLongLongValue / 1024 / 1024
        infoLabel.text = "\(size) MB"

        // Do any additional setup after loading the view, typically from a nib.
        self.data = createMB().dataUsingEncoding(NSUTF8StringEncoding)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func createFile(sender: UIButton) {
        fm.createFileAtPath(url.path!, contents:NSData(), attributes:nil)
        let file = try! NSFileHandle(forWritingToURL: url)
        var specify = Int(textField.text!)
        if specify == nil {
            specify = 10
        }
        for _ in 1...specify! {
            file.writeData(self.data)
        }
        file.synchronizeFile()
        file.closeFile()
    }

    @IBAction func deleteFile(sender: UIButton) {
        try! fm.removeItemAtURL(url)
        infoLabel.text = "0 byte"
    }

    func createMB() -> String {
        var kb = ""
        for _ in 1...1024 {
            kb += "A"
        }
        var mb = ""
        for _ in 1...1024 {
            mb += kb
        }
        return mb
    }
}

