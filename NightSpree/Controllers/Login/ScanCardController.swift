//
//  ScanCardController.swift
//  NightSpree
//
//  Created by AppsCreationTech on 2/7/18.
//  Copyright © 2018 AppsCreationTech. All rights reserved.
//

import UIKit
import PayCardsRecognizer

class ScanCardController: Controller, PayCardsRecognizerPlatformDelegate {
    
    @IBOutlet var emptyView: UIView!
    @IBOutlet var cardView: UIView!
    
    @IBOutlet var recognizerContainer: UIView!
    
    var recognizer: PayCardsRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.loadLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        recognizer.startCamera()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        recognizer.stopCamera()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Layout
    
    func loadLayout() {
        cardView.layer.borderColor = colorHEX("00ff01").withAlphaComponent(0.1).cgColor
        initScanCardView()
        
        recognizer = PayCardsRecognizer(delegate: self, resultMode: .sync, container: self.recognizerContainer, frameColor: .clear)
    }
    
    func initScanCardView() {
        emptyView.isHidden = false
        cardView.layer.borderWidth = 0.0
    }
    
    func scannedCardView() {
        emptyView.isHidden = true
        cardView.layer.borderWidth = 14.0
    }
    
    // MARK: PayCardsRecognizerPlatformDelegate
    
    func payCardsRecognizer(_ payCardsRecognizer: PayCardsRecognizer, didRecognize result: PayCardsRecognizerResult) {
        
        scannedCardView()
        
        print("Card number : " + result.recognizedNumber!)
        print("Card holder : " + result.recognizedHolderName!)
        print("Expire month : " + result.recognizedExpireDateMonth!)
        print("Expire year : " + result.recognizedExpireDateYear!)
    }
    
    // MARK: Actions
    
    @IBAction func navbarBackButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
//        initScanCardView()
    }
    
}
