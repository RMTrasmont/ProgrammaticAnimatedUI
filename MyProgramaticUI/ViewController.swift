//
//  ViewController.swift
//  MyProgramaticUI
//
//  Created by Rafael M. Trasmontero on 5/1/17.
//  Copyright © 2017 TurnToTech. All rights reserved.
//
import Foundation
import UIKit
import AVFoundation
var audioPlayer1 = AVAudioPlayer()
var audioPlayer2 = AVAudioPlayer()
var audioPlayer3 = AVAudioPlayer()
class MyView: UIView{
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .red
        
    }
}

class StreetFighter{
    var name:String
    var moves:[String]
    var stage:String
    
    init(name:String, moves:[String], stage:String){
        self.name = name
        self.moves = moves
        self.stage = stage
    }
}


class ViewController: UIViewController, UIGestureRecognizerDelegate  {
    var fighterArray = [StreetFighter]()
    var battleStage:[String] = ["kenStage","dhalsimStage","sagatStage","guileStage"]
    var myBackgroundImageView:UIImageView!
    var backgroundImage = UIImage()
    var backgroundImageIndex:Int = 0
    var myBox = MyView()
    var myFighterView = UIImageView()
    var backgroundSwipeLeft = UISwipeGestureRecognizer()
    var backgroundSwipeRight = UISwipeGestureRecognizer()
    var holdToChangeChar = UILongPressGestureRecognizer()
    var movesIndex:Int = 0
    var fighterIndex:Int = 0
    var tripleTapToChangeMoves = UITapGestureRecognizer()
    var tapToAnimate = UITapGestureRecognizer()
    var characterTapped:Bool = false
    var pinchToChangeSize = UIPinchGestureRecognizer()
    var rotateToRotate = UIRotationGestureRecognizer()
    var myCalculator = MyView()
    var textField1 = UITextField()
    var textField2 = UITextField()
    var textField3 = UITextField()
    var button = UIButton()
    //***************************VIEW DID LOAD************************************
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCharacterProfile()
        playBackgroundMusic()
        audioPlayer1.volume = 0.8
        //DETECT CHANGE IN ORIENTATION OF SCREEN
        NotificationCenter.default.addObserver(self, selector: #selector(screenRotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    func loadCharacterProfile(){
        let ken = StreetFighter(name:"Ken", moves: ["kenTatsumaki-","kenHadoken-"], stage:"KenStage")
        fighterArray.append(ken)
        
        let sagat = StreetFighter(name:"Sagat", moves:["sagatShot-", "sagatUppercut-"], stage: "SagatStage")
        fighterArray.append(sagat)
        
        let dhalsim = StreetFighter(name:"Dhalsim", moves:["dhalsimFire-", "dhalsimFlame-"], stage: "DhalsimStage")
        fighterArray.append(dhalsim)
        
        let guile = StreetFighter(name: "Guile", moves: ["guileSonicBoom-","guileFlashKick-"], stage:"GuileStage")
        fighterArray.append(guile)
    }

    
    func screenRotated() {
        //2.DETECT CHANGE IN ORIENTATION OF SCREEN
        if UIDeviceOrientationIsLandscape(UIDevice.current.orientation) {
            print("Landscape")
            myBackgroundImageView = UIImageView(frame:CGRect(x: 0, y: 0, width:self.view.frame.width,height:450))
            myBackgroundImageView.contentMode = .scaleAspectFill
            initBackgroundImageSwipeGestures()
            //SET IMAGE
            let imageToUSe = UIImage.init(named: battleStage[backgroundImageIndex])
            myBackgroundImageView.image = imageToUSe
            //********************IMPORTANT****************************
            myBackgroundImageView.isUserInteractionEnabled = true   //<----***
            myBackgroundImageView.translatesAutoresizingMaskIntoConstraints = false
            //**********************IMPORTANT**************************
            self.view.addSubview(myBackgroundImageView)
            loadMyCornerBox()
            loadFighterImageView()
            loadMyCalculator()
        }
        
        //2.DETECT CHANGE IN ORIENTATION OF SCREEN
        if UIDeviceOrientationIsPortrait(UIDevice.current.orientation) {
            print("Portrait")
            myBackgroundImageView = UIImageView(frame:CGRect(x: 0, y: 0, width:375,height: self.view.frame.height))
            myBackgroundImageView.contentMode = .scaleAspectFill
            initBackgroundImageSwipeGestures()
            //SET IMAGE
            let imageToUSe = UIImage.init(named: battleStage[backgroundImageIndex])
            myBackgroundImageView.image = imageToUSe
            //********************IMPORTANT****************************
            myBackgroundImageView.isUserInteractionEnabled = true
            myBackgroundImageView.translatesAutoresizingMaskIntoConstraints = false
            //********************IMPORTANT****************************
            self.view.addSubview(myBackgroundImageView)
            loadMyCornerBox()
            loadFighterImageView()
            loadMyCalculator()

        }
        
    }

    
    func loadMyCornerBox(){
        myBox.removeFromSuperview()
        myBox = MyView(frame: CGRect(x:self.view.frame.width-50 , y: self.view.frame.height-50, width: 50, height: 50))
        self.view.addSubview(myBox)
    }
    
    func loadMyCalculator(){
        myCalculator.removeFromSuperview()
        myCalculator = MyView(frame: CGRect(x:0, y: 15, width: 250, height: 50))
        myCalculator.backgroundColor = .red   //<-- Change To Clear After

        self.view.addSubview(myCalculator)
        
        textField1 = UITextField(frame:CGRect(x: 5, y: 10, width: 50, height: 30))
        textField1.backgroundColor = .white
        textField1.alpha = 0.50 // OPACITY
        textField1.textAlignment = .center
        myCalculator.addSubview(textField1)
        
        textField2 = UITextField(frame:CGRect(x: 75, y: 10, width: 50, height: 30))
        textField2.backgroundColor = .white
        textField2.alpha = 0.50 // OPACITY
        textField2.textAlignment = .center
        myCalculator.addSubview(textField2)
        
        textField3 = UITextField(frame:CGRect(x: 145, y: 10, width: 50, height: 30))
        textField3.backgroundColor = .white
        textField3.alpha = 0.50 // OPACITY
        textField3.textAlignment = .center
        myCalculator.addSubview(textField3)
        
        let label1 = UILabel(frame:CGRect(x: 60, y: 20, width: 10, height: 10 ))
        label1.text = "+"
        label1.textColor = .black
        label1.backgroundColor = .clear
        myCalculator.addSubview(label1)
        
        let label2 = UILabel(frame:CGRect(x: 130, y: 20, width: 10, height: 10 ))
        label2.text = "="
        label2.textColor = .black
        label2.backgroundColor = .clear
        myCalculator.addSubview(label2)
        
        button = UIButton(frame:CGRect(x: 205, y: 10, width: 30, height: 30))
        button.setTitle("ANS", for:.normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.lineBreakMode = NSLineBreakMode.byClipping
        button.backgroundColor = .white
        button.alpha = 0.50
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(findSum), for:.touchUpInside)
        myCalculator.addSubview(button)
    }
    
    func findSum(){
        
        do {
            audioPlayer3 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource:"SFEnter", ofType:"mp4")!))
            audioPlayer3.prepareToPlay()
        } catch let error as NSError {
            print(error.description)
        }
        audioPlayer3.play()
        
        guard let input1 = textField1.text else {
            return
        }
        
        guard let input2  = textField2.text else {
            return
        }
    
        guard let input1Int = Int(input1) else {
            return
        }
        
        guard let input2Int = Int(input2) else {
            return
        }
    
        let sum = input1Int + input2Int
        textField3.text = String(sum)

    }
    
    
    func loadFighterImageView(){
        myFighterView.removeFromSuperview()
        myFighterView.frame = CGRect(x:0, y: 0, width: 400, height: 350)
        myFighterView.backgroundColor = .clear
        myFighterView.isUserInteractionEnabled = true
        //ALWAYS CENTER OF SUPERVIEW
        myFighterView.center = self.view.convert(self.view.center, from: self.view)
        initPan()
        initHoldToChange()
        initTripleTap()
        initTap()
        stillVSAnimate()
        initPinch()
        initRotate()
        
        self.view.addSubview(myFighterView)
    }
    
    //A.INITIATE PAN MOVE FIGHTER AROUND
    func initPan(){
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        myFighterView.addGestureRecognizer(panGesture)
    }
    //B.INITIATE PAN MOVE FIGHTER AROUND
    func handlePan(sender:UIPanGestureRecognizer){
        sender.view?.center = sender.location(in: sender.view?.superview)
    }
    
    
    //A.BACKGROUND SWIPE LEFT RIGHT
    func initBackgroundImageSwipeGestures(){
        backgroundSwipeLeft = UISwipeGestureRecognizer(target:self,action:#selector(handleBackgroundSwipe))
        backgroundSwipeRight = UISwipeGestureRecognizer(target:self,action:#selector(handleBackgroundSwipe))
        backgroundSwipeLeft.direction = .left
        backgroundSwipeRight.direction = .right
        myBackgroundImageView.addGestureRecognizer(backgroundSwipeLeft)
        myBackgroundImageView.addGestureRecognizer(backgroundSwipeRight)
        
    }
    
    //B.BACKGROUND SWIPE LEFT RIGHT
    func handleBackgroundSwipe(sender:UISwipeGestureRecognizer){
        
        if (audioPlayer1.isPlaying){
            audioPlayer1.stop()
        }
        
        if (sender.direction == .left){
            backgroundImageIndex += 1
        }
        
        if(sender.direction == .right){
            backgroundImageIndex -= 1
        }
        
        if (backgroundImageIndex > battleStage.count - 1){
            backgroundImageIndex = 0
        }
        
        if(backgroundImageIndex < 0){
            backgroundImageIndex = battleStage.count - 1
        }
        
        let imageToUSe = UIImage.init(named: battleStage[backgroundImageIndex])
        myBackgroundImageView.image = imageToUSe
        
        playBackgroundMusic()
        
    }
    
    
    //SOUND HANDLING / BASE ON BACKGROUND IMAGE INDEX
    func playBackgroundMusic(){
    
        switch backgroundImageIndex {
        case 0:
            do {
                audioPlayer1 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource:"KenThemeMusic", ofType:"mp4")!))
                audioPlayer1.prepareToPlay()
            } catch let error as NSError {
                print(error.description)
            }
            audioPlayer1.play()
        case 1:
            
            do {
                audioPlayer1 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource:"DhalsimThemeMusic", ofType:"mp4")!))
                audioPlayer1.prepareToPlay()
            } catch let error as NSError {
                print(error.description)
            }
            audioPlayer1.play()
        case 2:
            
            do {
                audioPlayer1 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource:"SagatThemeMusic", ofType:"mp4")!))
                audioPlayer1.prepareToPlay()
            } catch let error as NSError {
                print(error.description)
            }
            audioPlayer1.play()
        case 3:
            
            do {
                audioPlayer1 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource:"GuileThemeMusic", ofType:"mp4")!))
                audioPlayer1.prepareToPlay()
            } catch let error as NSError {
                print(error.description)
            }
            audioPlayer1.play()
        default:
            audioPlayer1.stop()
            print("error playing sound")
        }
    }
    
    
    //A.LONGHOLD TO CHANGE CHARACTER
    func initHoldToChange(){
        holdToChangeChar = UILongPressGestureRecognizer(target: self, action: #selector(handleHold))
        holdToChangeChar.minimumPressDuration = 1.0
        myFighterView.addGestureRecognizer(holdToChangeChar)
        
    }
    
    //B.LONGHOLD TO CHANGE CHARACTER
    func handleHold(sender:UILongPressGestureRecognizer){
        
            if(sender.state == .ended){
            fighterIndex += 1
            
            if (fighterIndex > fighterArray.count - 1) {
                fighterIndex = 0
            }

            var nonAnimatedImageName = fighterArray[fighterIndex].moves[movesIndex]
            nonAnimatedImageName.append("0")
            let nonAnimatedCharacterToDisplay = UIImage.init(imageLiteralResourceName: nonAnimatedImageName)
            myFighterView.image = nonAnimatedCharacterToDisplay
        
        }
    }
    
    //A. TRIPLE TAP TO CHANGE MOVES
    func initTripleTap(){
        tripleTapToChangeMoves = UITapGestureRecognizer(target: self, action:#selector(handleTripleTap))
        tripleTapToChangeMoves.numberOfTapsRequired = 2
        myFighterView.addGestureRecognizer(tripleTapToChangeMoves)
    }
    
    //B. TRIPLE TAP TO CHANGE MOVES
    func handleTripleTap(sender:UITapGestureRecognizer){
        if (sender.state == .ended){
            movesIndex += 1
        
            if (movesIndex > 1){
                movesIndex = 0
            }
            var nonAnimatedImageName = fighterArray[fighterIndex].moves[movesIndex]
            nonAnimatedImageName.append("0")
            let nonAnimatedCharacterToDisplay = UIImage.init(imageLiteralResourceName: nonAnimatedImageName)
            myFighterView.image = nonAnimatedCharacterToDisplay
        }
    }

    //A. TAP TO EXECUTE MOVE
    func initTap(){
        characterTapped = false
        tapToAnimate = UITapGestureRecognizer(target: self, action:#selector(handleTap))
        tapToAnimate.numberOfTapsRequired = 1
        myFighterView.addGestureRecognizer(tapToAnimate)
        
    }

    //B. TAP TO EXECUTE MOVE
    func handleTap(sender:UITapGestureRecognizer){
        let nameOfMoveToAnimate = fighterArray[fighterIndex].moves[movesIndex]
        playSoundEffects()
        let imagesForAnimation = UIImage.animatedImageNamed(nameOfMoveToAnimate, duration: 0)?.images
        myFighterView.animationImages = imagesForAnimation
        myFighterView.animationRepeatCount = 1
        myFighterView.startAnimating()
        
        if (sender.state == .ended){
            characterTapped = true
        }
    }
    
    //A. HANDLE SOUND EFFECTS FOR SPECIAL MOVES   ***********************************
    func playAudioForMove(moveName:String){
        do {
            audioPlayer2 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource:moveName, ofType:"mp4")!))
            audioPlayer2.prepareToPlay()
        } catch let error as NSError {
            print(error.description)
        }
        audioPlayer2.play()
    }
    
    //B. HANDLE SOUND EFFECTS FOR SPECIAL MOVES
    func playSoundEffects(){
        
        let nameOfMoveToAnimate = fighterArray[fighterIndex].moves[movesIndex]

//        LOOOK OVER, CODE BELOW REPLACES SWITCH STATEMENT
//        let hyphenSet = CharacterSet.init(charactersIn: "-")
//        let actualName = nameOfMoveToAnimate.trimmingCharacters(in: hyphenSet)
//        playAudioForMove(moveName: actualName)
        
        switch nameOfMoveToAnimate {
        case "kenTatsumaki-":
            playAudioForMove(moveName:"kenTatsumaki")
        case "kenHadoken-":
            playAudioForMove(moveName: "kenHadoken")
        case "sagatShot-":
            playAudioForMove(moveName: "sagatShot")
        case "sagatUppercut-":
            playAudioForMove(moveName: "sagatUppercut")
        case "dhalsimFire-":
            playAudioForMove(moveName: "dhalsimFire")
        case "dhalsimFlame-":
            playAudioForMove(moveName: "dhalsimFlame")
        case "guileSonicBoom-":
            playAudioForMove(moveName: "guileSonicBoom")
        case "guileFlashKick-":
            playAudioForMove(moveName: "guileFlashKick")
        default:
            audioPlayer2.stop()
            print("error playing move sound effects")
        }
        
    }
    
    //STILL VS ANIMATE
    func stillVSAnimate(){
        if (characterTapped == true){
            let nameOfMoveToAnimate = fighterArray[fighterIndex].moves[movesIndex]
            let imagesForAnimation = UIImage.animatedImageNamed(nameOfMoveToAnimate, duration: 0)?.images
            myFighterView.animationImages = imagesForAnimation
            myFighterView.animationRepeatCount = 1
            myFighterView.startAnimating()
            characterTapped = false
            
        } else {
            myFighterView.stopAnimating()
            var nonAnimatedImageName = fighterArray[fighterIndex].moves[movesIndex]
            nonAnimatedImageName.append("0")
            let nonAnimatedCharacterToDisplay = UIImage.init(imageLiteralResourceName: nonAnimatedImageName)
            myFighterView.image = nonAnimatedCharacterToDisplay
        }
    }

    //A. PINCH TO CHANGE SIZE
    func initPinch(){
        pinchToChangeSize = UIPinchGestureRecognizer(target: self, action:#selector(handlePinch))
        myFighterView.addGestureRecognizer(pinchToChangeSize)
    }
    
    //B. PINCH TO CHANGE SIZE
    func handlePinch(sender:UIPinchGestureRecognizer){
        myFighterView.transform = myFighterView.transform.scaledBy(x: sender.scale, y: sender.scale)
        sender.scale = 1
    }

    
    //A. ROTATE IMAGE
    func initRotate(){
        rotateToRotate = UIRotationGestureRecognizer(target: self, action: #selector(handleRotation))
        myFighterView.addGestureRecognizer(rotateToRotate)
        
    }
    
    //B. ROTATE IMAGE
    func handleRotation(sender: UIRotationGestureRecognizer){
        myFighterView.transform = myFighterView.transform.rotated(by: sender.rotation)
        sender.rotation = 0
    }

}

