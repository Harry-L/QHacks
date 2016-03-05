//
//  ViewController.swift
//  SocialSelf
//
//  Created by Harry Liu on 2016-03-05.
//  Copyright © 2016 SocialSelf. All rights reserved.
//

import UIKit
import AVFoundation
import MobileCoreServices

class ViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var qrCodeFrameView: UIView?
    var accounts = [(String, String)]()
    var possibleAccounts = ["facebook", "instagram", "twitter", "linkedin"]
    
    @IBOutlet weak var qrCode: UIImageView!
    @IBOutlet weak var button: UIButton!
    
    @IBAction func buttonPress(sender: AnyObject) {
        initializingCapture()
        initializingFrame()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        layoutFix()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initColors()
        tapGestureRecognizer()
    }
    
    func tapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("qrTapped"))
        qrCode.userInteractionEnabled = true
        qrCode.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func layoutFix() {
        self.navigationController!.navigationBar.barTintColor = UIColor.init(red: 63.0/255.0, green: 63.0/255.0, blue: 63.0/255.0, alpha: 1)
        //view.bringSubviewToFront(qrCode)
        //view.bringSubviewToFront(button)
        //captureSession?.delete(self)
        //qrCodeFrameView?.removeFromSuperview()
        //videoPreviewLayer?.delete(self)
        captureSession?.startRunning()
        qrCodeFrameView?.frame = CGRectZero
    }
    
    func qrTapped() {
        if (qrCode.alpha == 1) {
            UIView.animateWithDuration(0.4, animations: {
                self.qrCode.alpha = 0.0
                }, completion: nil)
            self.button.hidden = false
        }
        else {
            UIView.animateWithDuration(0.4, animations: {
                self.qrCode.alpha = 1
                }, completion: nil)
            self.button.hidden = true
        }
    }
    
    func initColors() {
        navigationController!.navigationBar.barTintColor = UIColor.init(red: 201.0/255.0, green: 34.0/255.0, blue: 40.0/255.0, alpha: 1)
        navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController!.navigationBar.translucent = false
        
        self.view.backgroundColor = UIColor.init(red: 56.0/255.0, green: 87.0/255.0, blue: 151.0/255.0, alpha: 1)
        self.edgesForExtendedLayout = UIRectEdge.None
    }
    
    func grabAccounts(text: String) {
        let arr = text.characters.split{$0 == "/"}.map(String.init)
        
        var index = 0;
        for s in arr {
            if (s != "#f"){
                accounts.append((possibleAccounts[index], s))
            }
            index++
        }
    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        if metadataObjects == nil || metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRectZero
            return;
        }
        
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if metadataObj.type == AVMetadataObjectTypeQRCode {
            let barCodeObject = videoPreviewLayer?.transformedMetadataObjectForMetadataObject(metadataObj as AVMetadataMachineReadableCodeObject) as! AVMetadataMachineReadableCodeObject
            qrCodeFrameView?.frame = barCodeObject.bounds
            
            if metadataObj.stringValue != nil {
                print(metadataObj.stringValue)
                captureSession?.stopRunning()
                grabAccounts(metadataObj.stringValue)
                performSegueWithIdentifier("next", sender: self)
            }
        }
    }
    
    func initializingFrame() {
        qrCodeFrameView = UIView()
        qrCodeFrameView?.tag = 100
        qrCodeFrameView?.layer.borderColor = UIColor.greenColor().CGColor
        qrCodeFrameView?.layer.borderWidth = 2
        view.addSubview(qrCodeFrameView!)
        view.bringSubviewToFront(qrCodeFrameView!)
    }
    
    func initializingCapture() {
        let captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            captureSession = AVCaptureSession()
            captureSession?.addInput(input)
            
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession?.addOutput(captureMetadataOutput)
            
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
            
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            view.layer.addSublayer(videoPreviewLayer!)
            
            captureSession?.startRunning()
        } catch {
            print("error")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "next" {
            let destination = segue.destinationViewController as! PageViewController
            print(accounts)
            destination.accounts = accounts
            
        }
    }


}

