//
//  ViewController.swift
//  FanReplay
//
//  Created by Danny Peng on 4/1/17.
//  Copyright © 2017 Danny Peng. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    @IBOutlet var startPreviewButton: NSButton!
    
    @IBOutlet var stopPreviewButton: NSButton!
    
    @IBOutlet var takePictureButton: NSButton!
    
    @IBOutlet var imageView1: NSImageView!
    
    @IBAction func startPreview_click(_ sender: Any) {
    }
    
    @IBAction func stopPreview_click(_ sender: Any) {
    }
    

    @IBAction func takePicture_click(_ sender: Any) {
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        var customView1: CustomView?
        
        customView1 = CustomView(frame: view.bounds)
        view.wantsLayer = true
        view.addSubview(customView1!)
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    
}

