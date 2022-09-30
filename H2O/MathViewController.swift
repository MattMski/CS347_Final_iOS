//
//  Math.swift
//  H2O
//
//  Created by Scott Simon & Matthew Mola on 4/16/18.
//  Copyright © 2018 neiu.edu. All rights reserved.
//
//  Math View is a tool to help 1st graders practice their addition and subtraction skills
//  You can choose between addition and subtraction with a selector at the top of the screen
//  Sums / Differences will never be less than 0 or greater than 20
//  Answers can only be numbers and no more than 2 digits at a time
//  If an incorrect answer is supplied, a prompt will appear to have them try another answer
//  If a correct answer is supplied, there will be a confirmation with the option to choose another question
//  Horizontal form will be displayed on a landscape orientation
//  Vertical form will be displayed on a portrait landscape
//  ---------------------
//  Future version(s) will include:
//  - provide feedback / statistics regarding how many questions attempted, how many correct answers, etc.
//  - the option to practice specific number sets instead of a random sampling of questions
//  - the option to choose whether you work on sums /differences
//  - or choose which addends to supply the answer to
//  - or which minuends and subtrahends to supply the answer to
/***************************************************************************************************/

import UIKit

class MathViewController: UIViewController, UITextFieldDelegate  {
    
    @IBOutlet weak var SumValue: UILabel!
    @IBOutlet weak var Addend_1: UILabel!
    @IBOutlet weak var Operand: UILabel!
    @IBOutlet weak var Addend_2: UILabel!
    @IBOutlet weak var Sum: UILabel!
    @IBOutlet weak var Answer: UITextField!
    @IBOutlet weak var Submit: UIButton!
    @IBOutlet weak var Verify: UILabel!
    @IBOutlet weak var Toggle: UISegmentedControl!
    
    
    //set constansts for when view loads
    var correct: Bool = false;
    var newQuestion: Bool = false;
    var diff: Int? = 0
    var answerDiff: Int? = 0
    
    var answerValue: Int? {
        didSet{
            //print("answerValue property observer called")
            checkAnswer()
            //print("Answer is correct: \(correct)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // make the Submit button a little rounded
        Submit.clipsToBounds = true
        
        //randomize whether the view displays the subtraction or addition screens
        let operationRand = Int(arc4random_uniform(2))
        //print("operationRand: \(operationRand % 2)")
        //print("operationRand: \(operationRand)")
        
        // if randomnumber is odd, start subtraction
        if operationRand % 2 == 0  {
            updateAddition()
            Toggle.selectedSegmentIndex = 0
        }
        else {
            updateSubtraction()
            Toggle.selectedSegmentIndex = 1
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // this will reset all of the variables to their "starting" point
    func checkEntryPoint(){
        newQuestion = false
        correct = false
        Sum.text = nil
        Answer.text = nil
        Verify.text = nil
        Submit.setTitle("Submit", for: .normal)
        Submit.backgroundColor = UIColor(hex: "E6E6E6")
        Submit.setTitleColor(UIColor.blue, for: .normal)
        Submit.layer.cornerRadius = 10
    }
    
    func updateAddition(){
        //set the screen to new
        checkEntryPoint()
        
        //what operation was called?
        //print("Addition operation called")
        
        //update the title to display what was selected
        self.title = "Addition"
        
        // choose random numbers for number 1 and number 2
        let b = arc4random_uniform(11)
        let a = arc4random_uniform(11)
        
        // set the sum value to determine the correct answer
        let sum = (a + b)
        
        //Draw the numbers on the canvas
        Addend_1.text = "\(a)"
        Addend_2.text = "\(b)"
        Operand.text = "+"
        
        // obtain the integer value of the number text that was entered into the box
        SumValue.text = "\(sum)"
        if let text = SumValue.text, let value = Int(text){
            answerDiff = value
        }
        else {
            answerDiff = nil
        }
    }
    
    func updateSubtraction(){
        //reset the screen
        checkEntryPoint()
        
        //troubleshoot
        //print("Subtraction operation called")
        
        //update the title to display what was selected
        self.title = "Subtraction"
        
        //Submit.clipsToBounds = true
        
        //set random numbers for minuend and subtrahend
        let b = arc4random_uniform(21)
        let a = arc4random_uniform(21)
        
        //let b = 2
        
        //Force the top number to be the largest number so only positive answers are available
        if(b < a){
            let diff = (a - b)
            //let sumValue = Int(diff)
            Addend_1.text = "\(a)"
            Addend_2.text = "\(b)"
            //Operand.text = "-"
            SumValue.text = "\(diff)"
            if let text = SumValue.text, let value = Int(text){
                answerDiff = value
            }
            else {
                answerDiff = nil
            }
        }
        else{
            let diff = (b - a)
            //let sumValue = Int(diff)
            Addend_1.text = "\(b)"
            Addend_2.text = "\(a)"
            SumValue.text = "\(diff)"
            if let text = SumValue.text, let value = Int(text){
                answerDiff = value
            }
            else {
                answerDiff = nil
            }
            //let diffValue = diff
        }
        
        Operand.text = "-"
        //Sum.text = "\(diff)"
    }
    
    // callback to determine whether submission is correct
    func checkAnswer(){
        //print("checkAnswer property observer called")
        
        if(answerValue == answerDiff){
            correct = true
            //print("answerValue: \(String(describing: answerValue))")
            //print("answerDiff: \(String(describing: answerDiff))")
        }
        else{
            correct = false
            //print("answerValue: \(String(describing: answerValue))")
            //print("answerDiff: \(String(describing: answerDiff))")
        }
    }
    
    // use a delegate to prevent unwanted entries
    func textField(_ Answer: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // only allow numbers and no more than 2 digits at a time
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        if ((Answer.text?.count ?? 0) < 2 || string == "") {
            return allowedCharacters.isSuperset(of: characterSet)
        }
        else {
            return false
        }
    }
    
    //segment selector will determine what type of operational view is displayed
    @IBAction func segmentedControlAction(sender: AnyObject) {
        // content is changed based on the toggle name selected
        if(Toggle.selectedSegmentIndex == 0)
        {
            updateAddition()
            //print("Addition")
        }
        else if(Toggle.selectedSegmentIndex == 1)
        {
            updateSubtraction()
            //print("Subraction")
        }
    }
    
    // if answer is correct, display confirmation
    // if answer is incorrect, prompt for new answer
    // if answer was not submitted, reset all of the variables for a new question
    @IBAction func verifyAnswer(sender: UIButton){
        if newQuestion && Toggle.selectedSegmentIndex == 0{
            updateAddition()
        }
        else if newQuestion && Toggle.selectedSegmentIndex == 1{
            updateSubtraction()
        }
        else
            if correct {
                Verify.text = "Correct!"
                newQuestion = true
                
                //request by Mrs. Simon to have the answer reiterated on the screen
                Sum.text = "\(Addend_1.text!) \(Operand.text!) \(Addend_2.text!) = \(SumValue.text!)"
                
                //SumValue.text = "\(diff)"
                //print("verifyAnswer property observer called: Correct")
                
                //prompt for new question
                //Submit.text = "New Question?"
                
                //replace submit button with Next Question button???
                Submit.setTitle("New Question?", for: .normal)
                
                // answer was correct so format the submit button to "green"
                Submit.backgroundColor = UIColor(hex: "259C19")
                Submit.setTitleColor(UIColor.white, for: .normal)
                Submit.layer.cornerRadius = 15
            }
            else{
                Verify.text = "Try Again"
                newQuestion = false
                
                //blank out the answer text to allow new try
                Answer.text = nil
                Sum.text = nil
                
                //format the submit button to identify something wasn't right
                Submit.setTitle("Submit", for: .normal)
                Submit.backgroundColor = UIColor(hex: "E6E6E6")
                Submit.setTitleColor(UIColor.blue, for: .normal)
                //print("verifyAnswer property observer called: InCorrect")
                Submit.layer.cornerRadius = 0
                
                //perform a "not right" type of shake on the button
                sender.shake()
        }
    }
    
    @IBAction func answerFieldEditingChanged(_ textField: UITextField){
        //print("func answerFieldEditingChanged property observer called")
        
        //prepare for when the submit button is clicked
        if let text = Answer.text, let value = Int(text){
            answerValue = value
        }
        else {
            //if something went wrong make the answer value something that will never be reached
            answerValue = 9999
        }
    }
    
//
//    @IBAction func updateAnswerLabel(){
//        //print("updateAnswerLabel property observer called")
//        //Verify.text = "Correct"
//        //
//        //Verify.text = "\(String(describing: answerValue))"
//    }
//
    
    // hide the numberpad if clicked off of it
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer){
        Answer.resignFirstResponder()
    }
    
// end of MathViewController Class
}
