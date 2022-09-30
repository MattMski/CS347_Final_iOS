//
//  PlanetViewController.swift
//  H2O
//
//  Created by Scott Simon on 4/17/18.
//  Copyright © 2018 Scott Simon. All rights reserved.
//

import UIKit

//defining the template for the questions and answers array and which answer option is correct
struct Question {
    let question: String
    let answers: [String]
    let correctAnswer: Int
}

class PlanetViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var planetLbl: UILabel!
    @IBOutlet weak var fact1: UILabel!
    @IBOutlet weak var fact2: UILabel!
    //@IBOutlet weak var fact3: UILabel!
    
    var planet: Planet?
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    
    lazy var buttons: [UIButton] = { return [self.button1, self.button2, self.button3, self.button4] }()
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var endLabel: UILabel!
    
    var questionIndexes: [Int]!
    var currentQuestionIndex = 0
    var questionNum = 0
    var isCorrect = false
    
    // general question bank to be used as template or as default fallback
    var questions: [Question] = [
        Question(
            question: "How many planets are there in our solar system?",
            answers: ["23", "8", "12", "1"],
            correctAnswer: 1),
        Question(
            question: "How many moons does the Earth have?",
            answers: ["50", "2", "1", "6"],
            correctAnswer: 2),
        Question(
            question: "What is the largest planet?",
            answers: ["Chicago", "St. Louis", "Milwaukee", "Jupiter"],
            correctAnswer: 3)
    ]
    
    //questions will be unique for each planet clicked on inside of the SolarSystemViewController
    var questionsSun: [Question] = [
        Question(
            question: "The sun is a ________",
            answers: ["solar system", "star", "comet", "planet"],
            correctAnswer: 1),
        Question(
            question: "How many suns are there in our universe?",
            answers: ["1", "2", "3", "5"],
            correctAnswer: 0),
        Question(
            question: "A star is called a \"sun\" if it is the ____ of a planetary system.",
            answers: ["marshmallow", "beginning", "end", "center"],
            correctAnswer: 3)
    ]
    
    var questionsMercury: [Question] = [
        Question(
            question: "Mercury is the _____ planet to the sun",
            answers: ["farthest", "closest", "coldest", "warmest"],
            correctAnswer: 1),
        Question(
            question: "There is no ____ present on Mercury",
            answers: ["math", "water", "broccoli", "homework"],
            correctAnswer: 1),
        Question(
            question: "Mercury is about as wide as the _____.",
            answers: ["state of Illinois", "Atlantic Ocean", "Grand Canyon", "cafeteria"],
            correctAnswer: 1),
        Question(
            question: "Mercury is the ____ planet.",
            answers: ["largest", "fastest", "hottest", "darkest"],
            correctAnswer: 1)
    ]
    
    var questionsVenus: [Question] = [
        Question(
            question: "Venus was named after a ____",
            answers: ["mythological goddess", "rock band", "flower", "cereal brand"],
            correctAnswer: 0),
        Question(
            question: "Venus is the ____ and ____ planet.",
            answers: ["best / worst", "prettieset / funniest", "smallest / quickest", "hottest / brightest"],
            correctAnswer: 3),
        Question(
            question: "Venus hosts thousands of ____.",
            answers: ["parties", "moons", "volcanoes", "insects"],
            correctAnswer: 2)
    ]
    
    var questionsEarth: [Question] = [
        Question(
            question: "Earth is the ____ largest planet.",
            answers: ["most", "only", "fifth", "last"],
            correctAnswer: 2),
        Question(
            question: "Earth has one ____.",
            answers: ["mountain", "moon", "anniversary", "regret"],
            correctAnswer: 1),
        Question(
            question: "Earth is 70% ____.",
            answers: ["loading", "water", "degrees", "correct"],
            correctAnswer: 1)
    ]
    
    var questionsMars: [Question] = [
        Question(
            question: "Mars is known as the ____ planet.",
            answers: ["solar system", "red", "comet", "planet"],
            correctAnswer: 1),
        Question(
            question: "Mars is very ____ and ____.",
            answers: ["cold / dry", "hot / shiny", "sick / tired", "old / smelly"],
            correctAnswer: 0),
        Question(
            question: "Water exists in the form of ____ on Mars.",
            answers: ["gas", "ice", "Pikachu", "liquid"],
            correctAnswer: 1)
    ]
    
    var questionsJupiter: [Question] = [
        Question(
            question: "Jupiter is the ____ planet in the solar system",
            answers: ["coldest", "roundest", "largest", "smallest"],
            correctAnswer: 2),
        Question(
            question: "Jupiter has some of the largest ____ in the Solar System.",
            answers: ["oceans", "moons", "suns", "animals"],
            correctAnswer: 1)
    ]
    
    var questionsSaturn: [Question] = [
        Question(
            question: "Saturn has a moon called ____.",
            answers: ["Ford", "Titan", "Zeus", "Atlas"],
            correctAnswer: 1),
        Question(
            question: "Saturn is best know for its ____.",
            answers: ["memes", "rings", "stories", "rapier wit"],
            correctAnswer: 1)
    ]
    
    var questionsUranus: [Question] = [
        Question(
            question: "It takes Uranus about 84 ____ to travel around the sun.",
            answers: ["years", "days", "minutes", "dollars"],
            correctAnswer: 0),
        Question(
            question: "Uranus looks blue because of ____.",
            answers: ["the sky", "water", "algae", "gases"],
            correctAnswer: 3)
    ]
    
    var questionsNeptune: [Question] = [
        Question(
            question: "Neptune is the ____ planet from the sun.",
            answers: ["closest", "friendliest", "farthest", "hardest"],
            correctAnswer: 2),
        Question(
            question: "Neptune was named after a ____.",
            answers: ["bug", "mythological god", "game", "musical symbol"],
            correctAnswer: 1)
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Since some planets have a different number of total questions,
        // set the index count to be specific for the respective planet
        switch(planet!.name){
        case "sun":
            //print("Loaded: \(planet!.name)")
            questionIndexes = Array(0 ..< questionsSun.count)  // builds an array [0, 1, 2, ... n]
            questionNum = questionsSun.count
        case "earth":
            //print("Loaded: \(planet!.name)")
            questionIndexes = Array(0 ..< questionsEarth.count)  // builds an array [0, 1, 2, ... n]
            questionNum = questionsEarth.count
        case "mercury":
            //print("Loaded: \(planet!.name)")
            questionIndexes = Array(0 ..< questionsMercury.count)  // builds an array [0, 1, 2, ... n]
            questionNum = questionsMercury.count
        case "venus":
            //print("Loaded: \(planet!.name)")
            questionIndexes = Array(0 ..< questionsVenus.count)  // builds an array [0, 1, 2, ... n]
            questionNum = questionsVenus.count
        case "mars":
            //print("Loaded: \(planet!.name)")
            questionIndexes = Array(0 ..< questionsMars.count)  // builds an array [0, 1, 2, ... n]
            questionNum = questionsMars.count
        case "jupiter":
            //print("Loaded: \(planet!.name)")
            questionIndexes = Array(0 ..< questionsJupiter.count)  // builds an array [0, 1, 2, ... n]
            questionNum = questionsJupiter.count
        case "saturn":
            //print("Loaded: \(planet!.name)")
            questionIndexes = Array(0 ..< questionsSaturn.count)  // builds an array [0, 1, 2, ... n]
            questionNum = questionsSaturn.count
        case "uranus":
            //print("Loaded: \(planet!.name)")
            questionIndexes = Array(0 ..< questionsUranus.count)  // builds an array [0, 1, 2, ... n]
            questionNum = questionsUranus.count
        case "neptune":
            //print("Loaded: \(planet!.name)")
            questionIndexes = Array(0 ..< questionsNeptune.count)  // builds an array [0, 1, 2, ... n]
            questionNum = questionsNeptune.count
        default:
            print("Loaded: not sun")
            questionIndexes = Array(0 ..< questions.count)  // builds an array [0, 1, 2, ... n]
            questionNum = questions.count
            //            questionIndexes.shuffle()
            //            updateLabelsAndButtonsForIndex(questionIndex: 0, arrayType: "general")
        }
        
        //randomize the order in which the questions are displayed - keep it a little interesting
        questionIndexes.shuffle()
        
        // callback for updating the content on the canvas
        updateLabelsAndButtonsForIndex(questionIndex: 0, arrayType: planet!.name)
        
        // Display the content that is coming from the planet class
        fact1.text = planet?.fact1
        fact2.text = planet?.fact2
        //fact3.text = planet?.fact3
        imageView.image = planet?.image
        
        // Perform any special modifications to the name or labels
        formatLbls()
    }
    
    // this was originally programmed to take the name of the planet based on the structure of the array
    // so this will be called to reformat the names appropriately
    func formatLbls(){
        switch(planet!.name){
        case "sun":
            planetLbl.text = "The \(planet!.name.capitalized)"
            self.title = planetLbl.text
            //print("planetLbl: \(planet!.name)")
        default:
            planetLbl.text = planet!.name.capitalized
            self.title = planetLbl.text
            //print("planetLbl: \(planet!.name)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //update the labels according to which planet was selected from the previous view
    func updateLabelsAndButtonsForIndex(questionIndex: Int, arrayType: String) {
        //print("blah")
        //print("arrayType: \(arrayType)")
        //print("blah")
        // if we're done, show message in `endLabel` and hide `nextButton`
        switch(arrayType){
        case "sun":
            if questionIndex < questionsSun.count {
                //print("questionCount: \(questionsSun.count)")
                // identify which question we're presenting
                let questionObject = questionsSun[questionIndexes[questionIndex]]
                // update question label and answer buttons accordingly
                questionLabel.text = questionObject.question
                for (answerIndex, button) in buttons.enumerated() {
                    button.setTitle(questionObject.answers[answerIndex], for: [])
                }
            }
            else {
                // no more questions
                endLabel.isHidden = false
                endLabel.text = "All done!"
                nextButton.isHidden = true
                questionLabel.text = ""
                button1.isHidden = true
                button2.isHidden = true
                button3.isHidden = true
                button4.isHidden = true
                //print("questionIndex: \(questionIndex)")
                return
            }
            
        case "earth":
            //figuring out what guard is supposed to do
            guard questionIndex < questionsEarth.count else {
                endLabel.isHidden = false
                endLabel.text = "All done!"
                nextButton.isHidden = true
                questionLabel.text = ""
                button1.isHidden = true
                button2.isHidden = true
                button3.isHidden = true
                button4.isHidden = true
                return
            }
            
            // identify which question we're presenting
            let questionObject = questionsEarth[questionIndexes[questionIndex]]
            
            // update question label and answer buttons accordingly
            questionLabel.text = questionObject.question
            
            //display answer options based on which question was generated
            for (answerIndex, button) in buttons.enumerated() {
                button.setTitle(questionObject.answers[answerIndex], for: [])
            }
            
        case "mercury":
            guard questionIndex < questionsMercury.count else {
                endLabel.isHidden = false
                endLabel.text = "All done!"
                nextButton.isHidden = true
                questionLabel.text = ""
                button1.isHidden = true
                button2.isHidden = true
                button3.isHidden = true
                button4.isHidden = true
                return
            }
            
            let questionObject = questionsMercury[questionIndexes[questionIndex]]
            
            questionLabel.text = questionObject.question
            for (answerIndex, button) in buttons.enumerated() {
                button.setTitle(questionObject.answers[answerIndex], for: [])
            }
            
        case "venus":
            guard questionIndex < questionsVenus.count else {
                endLabel.isHidden = false
                endLabel.text = "All done!"
                nextButton.isHidden = true
                questionLabel.text = ""
                button1.isHidden = true
                button2.isHidden = true
                button3.isHidden = true
                button4.isHidden = true
                return
            }
            
            let questionObject = questionsVenus[questionIndexes[questionIndex]]
            
            questionLabel.text = questionObject.question
            for (answerIndex, button) in buttons.enumerated() {
                button.setTitle(questionObject.answers[answerIndex], for: [])
            }
        case "mars":
            guard questionIndex < questionsMars.count else {
                endLabel.isHidden = false
                endLabel.text = "All done!"
                nextButton.isHidden = true
                questionLabel.text = ""
                button1.isHidden = true
                button2.isHidden = true
                button3.isHidden = true
                button4.isHidden = true
                return
            }
            
            let questionObject = questionsMars[questionIndexes[questionIndex]]
            
            questionLabel.text = questionObject.question
            for (answerIndex, button) in buttons.enumerated() {
                button.setTitle(questionObject.answers[answerIndex], for: [])
            }
        case "jupiter":
            guard questionIndex < questionsJupiter.count else {
                endLabel.isHidden = false
                endLabel.text = "All done!"
                nextButton.isHidden = true
                questionLabel.text = ""
                button1.isHidden = true
                button2.isHidden = true
                button3.isHidden = true
                button4.isHidden = true
                return
            }
            
            let questionObject = questionsJupiter[questionIndexes[questionIndex]]
            
            questionLabel.text = questionObject.question
            for (answerIndex, button) in buttons.enumerated() {
                button.setTitle(questionObject.answers[answerIndex], for: [])
            }
        case "saturn":
            guard questionIndex < questionsSaturn.count else {
                endLabel.isHidden = false
                endLabel.text = "All done!"
                nextButton.isHidden = true
                questionLabel.text = ""
                button1.isHidden = true
                button2.isHidden = true
                button3.isHidden = true
                button4.isHidden = true
                return
            }
            
            let questionObject = questionsSaturn[questionIndexes[questionIndex]]
            
            questionLabel.text = questionObject.question
            for (answerIndex, button) in buttons.enumerated() {
                button.setTitle(questionObject.answers[answerIndex], for: [])
            }
        case "uranus":
            guard questionIndex < questionsUranus.count else {
                endLabel.isHidden = false
                endLabel.text = "All done!"
                nextButton.isHidden = true
                questionLabel.text = ""
                button1.isHidden = true
                button2.isHidden = true
                button3.isHidden = true
                button4.isHidden = true
                return
            }
            
            let questionObject = questionsUranus[questionIndexes[questionIndex]]
            
            questionLabel.text = questionObject.question
            for (answerIndex, button) in buttons.enumerated() {
                button.setTitle(questionObject.answers[answerIndex], for: [])
            }
            
        case "neptune":
            guard questionIndex < questionsNeptune.count else {
                endLabel.isHidden = false
                endLabel.text = "All done!"
                nextButton.isHidden = true
                questionLabel.text = ""
                button1.isHidden = true
                button2.isHidden = true
                button3.isHidden = true
                button4.isHidden = true
                return
            }
            
            let questionObject = questionsNeptune[questionIndexes[questionIndex]]
            
            questionLabel.text = questionObject.question
            for (answerIndex, button) in buttons.enumerated() {
                button.setTitle(questionObject.answers[answerIndex], for: [])
            }
            
        default:
            guard questionIndex < questions.count else {
                endLabel.isHidden = false
                endLabel.text = "All done!"
                nextButton.isHidden = true
                questionLabel.text = ""
                button1.isHidden = true
                button2.isHidden = true
                button3.isHidden = true
                button4.isHidden = true
                
                return
            }
            
            //currentQuestionIndex = questionIndex
            
            // hide end label and next button
            
            //hideEndLabelAndNextButton()
            
            // identify which question we're presenting
            
            let questionObject = questions[questionIndexes[questionIndex]]
            
            // update question label and answer buttons accordingly
            
            questionLabel.text = questionObject.question
            for (answerIndex, button) in buttons.enumerated() {
                button.setTitle(questionObject.answers[answerIndex], for: [])
            }
        }
        //end arrayType switch
        
        // since we're not at the end of the question index, we dropped down here
        // identify which question we're presenting
        currentQuestionIndex = questionIndex
        //print("questionNum \(questionNum)")
        // hide end label and next button because new question is displayed
        hideEndLabelAndNextButton()
    }
    
    // this is called if there are more questions to display
    func hideEndLabelAndNextButton() {
        endLabel.isHidden = true
        nextButton.isHidden = true
    }
    
    // this is called if all of the questions in the array/index have been exhausted
    func unhideEndLabelAndNextButton() {
        endLabel.isHidden = false
        nextButton.isHidden = false
        nextButton.isEnabled = true
    }
    
    // note, because I created that array of `buttons`, I now don't need
    // to have four `@IBAction` methods, one for each answer button, but
    // rather I can look up the index for the button in my `buttons` array
    // and see if the index for the button matches the index of the correct
    // answer.
    
    @IBAction func didTapAnswerButton(button: UIButton) {
        
        // if you click on an answer option, unhide the label and button in preparation for answer verification
        unhideEndLabelAndNextButton()
       
        let buttonIndex = buttons.index(of: button)
        //let questionObject = questions[questionIndexes[currentQuestionIndex]]
        switch(planet!.name){
        case "sun":
            //print("Tapped Answer: \(planet!.name)")
            let questionObject = questionsSun[questionIndexes[currentQuestionIndex]]
            
            if buttonIndex == questionObject.correctAnswer {
                endLabel.text = "Correct"
                isCorrect = true
                if buttonIndex == 0 {
                    button1.isEnabled = true
                    button2.isEnabled = false
                    button3.isEnabled = false
                    button4.isEnabled = false
                }
                if buttonIndex == 1 {
                    button1.isEnabled = false
                    button2.isEnabled = true
                    button3.isEnabled = false
                    button4.isEnabled = false
                }
                if buttonIndex == 2 {
                    button1.isEnabled = false
                    button2.isEnabled = false
                    button3.isEnabled = true
                    button4.isEnabled = false
                }
                if buttonIndex == 3 {
                    button1.isEnabled = false
                    button2.isEnabled = false
                    button3.isEnabled = false
                    button4.isEnabled = true
                }
            } else {
                //print("buttonIndex: \(buttonIndex!)")
                endLabel.text = "Try Again"
                nextButton.isHidden = true
                isCorrect = false
                
                if buttonIndex == 0 {
                    button1.isEnabled = false
                }
                if buttonIndex == 1 {
                    button2.isEnabled = false
                }
                if buttonIndex == 2 {
                    button3.isEnabled = false
                }
                if buttonIndex == 3 {
                    button4.isEnabled = false
                }
            }
        case "earth":
            //print("Tapped Answer: \(planet!.name)")
            let questionObject = questionsEarth[questionIndexes[currentQuestionIndex]]
            
            if buttonIndex == questionObject.correctAnswer {
                endLabel.text = "Correct"
                isCorrect = true
                if buttonIndex == 0 {
                    button1.isEnabled = true
                    button2.isEnabled = false
                    button3.isEnabled = false
                    button4.isEnabled = false
                }
                if buttonIndex == 1 {
                    button1.isEnabled = false
                    button2.isEnabled = true
                    button3.isEnabled = false
                    button4.isEnabled = false
                }
                if buttonIndex == 2 {
                    button1.isEnabled = false
                    button2.isEnabled = false
                    button3.isEnabled = true
                    button4.isEnabled = false
                }
                if buttonIndex == 3 {
                    button1.isEnabled = false
                    button2.isEnabled = false
                    button3.isEnabled = false
                    button4.isEnabled = true
                }
            } else {
                //print("buttonIndex: \(buttonIndex!)")
                endLabel.text = "Try Again"
                isCorrect = false
                nextButton.isHidden = true
                
                if buttonIndex == 0 {
                    button1.isEnabled = false
                }
                if buttonIndex == 1 {
                    button2.isEnabled = false
                }
                if buttonIndex == 2 {
                    button3.isEnabled = false
                }
                if buttonIndex == 3 {
                    button4.isEnabled = false
                }
            }
        case "mercury":
            //print("Tapped Answer: \(planet!.name)")
            let questionObject = questionsMercury[questionIndexes[currentQuestionIndex]]
            
            if buttonIndex == questionObject.correctAnswer {
                endLabel.text = "Correct"
                isCorrect = true
                if buttonIndex == 0 {
                    button1.isEnabled = true
                    button2.isEnabled = false
                    button3.isEnabled = false
                    button4.isEnabled = false
                }
                if buttonIndex == 1 {
                    button1.isEnabled = false
                    button2.isEnabled = true
                    button3.isEnabled = false
                    button4.isEnabled = false
                }
                if buttonIndex == 2 {
                    button1.isEnabled = false
                    button2.isEnabled = false
                    button3.isEnabled = true
                    button4.isEnabled = false
                }
                if buttonIndex == 3 {
                    button1.isEnabled = false
                    button2.isEnabled = false
                    button3.isEnabled = false
                    button4.isEnabled = true
                }
            } else {
                //print("buttonIndex: \(buttonIndex!)")
                endLabel.text = "Try Again"
                isCorrect = false
                nextButton.isHidden = true
                
                if buttonIndex == 0 {
                    button1.isEnabled = false
                }
                if buttonIndex == 1 {
                    button2.isEnabled = false
                }
                if buttonIndex == 2 {
                    button3.isEnabled = false
                }
                if buttonIndex == 3 {
                    button4.isEnabled = false
                }
            }
        case "venus":
            //print("Tapped Answer: \(planet!.name)")
            let questionObject = questionsVenus[questionIndexes[currentQuestionIndex]]
            
            if buttonIndex == questionObject.correctAnswer {
                endLabel.text = "Correct"
                isCorrect = true
                if buttonIndex == 0 {
                    button1.isEnabled = true
                    button2.isEnabled = false
                    button3.isEnabled = false
                    button4.isEnabled = false
                }
                if buttonIndex == 1 {
                    button1.isEnabled = false
                    button2.isEnabled = true
                    button3.isEnabled = false
                    button4.isEnabled = false
                }
                if buttonIndex == 2 {
                    button1.isEnabled = false
                    button2.isEnabled = false
                    button3.isEnabled = true
                    button4.isEnabled = false
                }
                if buttonIndex == 3 {
                    button1.isEnabled = false
                    button2.isEnabled = false
                    button3.isEnabled = false
                    button4.isEnabled = true
                }
            } else {
                //print("buttonIndex: \(buttonIndex!)")
                endLabel.text = "Try Again"
                isCorrect = false
                nextButton.isHidden = true
                
                if buttonIndex == 0 {
                    button1.isEnabled = false
                }
                if buttonIndex == 1 {
                    button2.isEnabled = false
                }
                if buttonIndex == 2 {
                    button3.isEnabled = false
                }
                if buttonIndex == 3 {
                    button4.isEnabled = false
                }
            }
        case "mars":
            //print("Tapped Answer: \(planet!.name)")
            let questionObject = questionsMars[questionIndexes[currentQuestionIndex]]
            
            if buttonIndex == questionObject.correctAnswer {
                endLabel.text = "Correct"
                isCorrect = true
                if buttonIndex == 0 {
                    button1.isEnabled = true
                    button2.isEnabled = false
                    button3.isEnabled = false
                    button4.isEnabled = false
                }
                if buttonIndex == 1 {
                    button1.isEnabled = false
                    button2.isEnabled = true
                    button3.isEnabled = false
                    button4.isEnabled = false
                }
                if buttonIndex == 2 {
                    button1.isEnabled = false
                    button2.isEnabled = false
                    button3.isEnabled = true
                    button4.isEnabled = false
                }
                if buttonIndex == 3 {
                    button1.isEnabled = false
                    button2.isEnabled = false
                    button3.isEnabled = false
                    button4.isEnabled = true
                }
            } else {
                //print("buttonIndex: \(buttonIndex!)")
                endLabel.text = "Try Again"
                isCorrect = false
                nextButton.isHidden = true
                
                if buttonIndex == 0 {
                    button1.isEnabled = false
                }
                if buttonIndex == 1 {
                    button2.isEnabled = false
                }
                if buttonIndex == 2 {
                    button3.isEnabled = false
                }
                if buttonIndex == 3 {
                    button4.isEnabled = false
                }
            }
        case "jupiter":
            //print("Tapped Answer: \(planet!.name)")
            let questionObject = questionsJupiter[questionIndexes[currentQuestionIndex]]
            
            if buttonIndex == questionObject.correctAnswer {
                endLabel.text = "Correct"
                isCorrect = true
                if buttonIndex == 0 {
                    button1.isEnabled = true
                    button2.isEnabled = false
                    button3.isEnabled = false
                    button4.isEnabled = false
                }
                if buttonIndex == 1 {
                    button1.isEnabled = false
                    button2.isEnabled = true
                    button3.isEnabled = false
                    button4.isEnabled = false
                }
                if buttonIndex == 2 {
                    button1.isEnabled = false
                    button2.isEnabled = false
                    button3.isEnabled = true
                    button4.isEnabled = false
                }
                if buttonIndex == 3 {
                    button1.isEnabled = false
                    button2.isEnabled = false
                    button3.isEnabled = false
                    button4.isEnabled = true
                }
            } else {
                //print("buttonIndex: \(buttonIndex!)")
                endLabel.text = "Try Again"
                isCorrect = false
                nextButton.isHidden = true
                
                if buttonIndex == 0 {
                    button1.isEnabled = false
                }
                if buttonIndex == 1 {
                    button2.isEnabled = false
                }
                if buttonIndex == 2 {
                    button3.isEnabled = false
                }
                if buttonIndex == 3 {
                    button4.isEnabled = false
                }
            }
        case "saturn":
            //print("Tapped Answer: \(planet!.name)")
            let questionObject = questionsSaturn[questionIndexes[currentQuestionIndex]]
            
            if buttonIndex == questionObject.correctAnswer {
                endLabel.text = "Correct"
                isCorrect = true
                if buttonIndex == 0 {
                    button1.isEnabled = true
                    button2.isEnabled = false
                    button3.isEnabled = false
                    button4.isEnabled = false
                }
                if buttonIndex == 1 {
                    button1.isEnabled = false
                    button2.isEnabled = true
                    button3.isEnabled = false
                    button4.isEnabled = false
                }
                if buttonIndex == 2 {
                    button1.isEnabled = false
                    button2.isEnabled = false
                    button3.isEnabled = true
                    button4.isEnabled = false
                }
                if buttonIndex == 3 {
                    button1.isEnabled = false
                    button2.isEnabled = false
                    button3.isEnabled = false
                    button4.isEnabled = true
                }
            } else {
                //print("buttonIndex: \(buttonIndex!)")
                endLabel.text = "Try Again"
                isCorrect = false
                nextButton.isHidden = true
                
                if buttonIndex == 0 {
                    button1.isEnabled = false
                }
                if buttonIndex == 1 {
                    button2.isEnabled = false
                }
                if buttonIndex == 2 {
                    button3.isEnabled = false
                }
                if buttonIndex == 3 {
                    button4.isEnabled = false
                }
            }
        case "uranus":
            //print("Tapped Answer: \(planet!.name)")
            let questionObject = questionsUranus[questionIndexes[currentQuestionIndex]]
            
            if buttonIndex == questionObject.correctAnswer {
                endLabel.text = "Correct"
                isCorrect = true
                if buttonIndex == 0 {
                    button1.isEnabled = true
                    button2.isEnabled = false
                    button3.isEnabled = false
                    button4.isEnabled = false
                }
                if buttonIndex == 1 {
                    button1.isEnabled = false
                    button2.isEnabled = true
                    button3.isEnabled = false
                    button4.isEnabled = false
                }
                if buttonIndex == 2 {
                    button1.isEnabled = false
                    button2.isEnabled = false
                    button3.isEnabled = true
                    button4.isEnabled = false
                }
                if buttonIndex == 3 {
                    button1.isEnabled = false
                    button2.isEnabled = false
                    button3.isEnabled = false
                    button4.isEnabled = true
                }
            } else {
                //print("buttonIndex: \(buttonIndex!)")
                endLabel.text = "Try Again"
                isCorrect = false
                nextButton.isHidden = true
                
                if buttonIndex == 0 {
                    button1.isEnabled = false
                }
                if buttonIndex == 1 {
                    button2.isEnabled = false
                }
                if buttonIndex == 2 {
                    button3.isEnabled = false
                }
                if buttonIndex == 3 {
                    button4.isEnabled = false
                }
            }
        case "neptune":
            //print("Tapped Answer: \(planet!.name)")
            let questionObject = questionsNeptune[questionIndexes[currentQuestionIndex]]
            
            if buttonIndex == questionObject.correctAnswer {
                endLabel.text = "Correct"
                isCorrect = true
                if buttonIndex == 0 {
                    button1.isEnabled = true
                    button2.isEnabled = false
                    button3.isEnabled = false
                    button4.isEnabled = false
                }
                if buttonIndex == 1 {
                    button1.isEnabled = false
                    button2.isEnabled = true
                    button3.isEnabled = false
                    button4.isEnabled = false
                }
                if buttonIndex == 2 {
                    button1.isEnabled = false
                    button2.isEnabled = false
                    button3.isEnabled = true
                    button4.isEnabled = false
                }
                if buttonIndex == 3 {
                    button1.isEnabled = false
                    button2.isEnabled = false
                    button3.isEnabled = false
                    button4.isEnabled = true
                }
            } else {
                //print("buttonIndex: \(buttonIndex!)")
                endLabel.text = "Try Again"
                isCorrect = false
                nextButton.isHidden = true
                
                if buttonIndex == 0 {
                    button1.isEnabled = false
                }
                if buttonIndex == 1 {
                    button2.isEnabled = false
                }
                if buttonIndex == 2 {
                    button3.isEnabled = false
                }
                if buttonIndex == 3 {
                    button4.isEnabled = false
                }
            }
        default:
            print("Tapped Answer no planet")
            let questionObject = questions[questionIndexes[currentQuestionIndex]]
            
            if buttonIndex == questionObject.correctAnswer {
                endLabel.text = "Correct"
                isCorrect = true
                if buttonIndex == 0 {
                    button1.isEnabled = true
                    button2.isEnabled = false
                    button3.isEnabled = false
                    button4.isEnabled = false
                }
                if buttonIndex == 1 {
                    button1.isEnabled = false
                    button2.isEnabled = true
                    button3.isEnabled = false
                    button4.isEnabled = false
                }
                if buttonIndex == 2 {
                    button1.isEnabled = false
                    button2.isEnabled = false
                    button3.isEnabled = true
                    button4.isEnabled = false
                }
                if buttonIndex == 3 {
                    button1.isEnabled = false
                    button2.isEnabled = false
                    button3.isEnabled = false
                    button4.isEnabled = true
                }
            } else {
                print("buttonIndex: \(buttonIndex!)")
                endLabel.text = "Try Again"
                isCorrect = false
                nextButton.isHidden = true
                
                if buttonIndex == 0 {
                    button1.isEnabled = false
                }
                if buttonIndex == 1 {
                    button2.isEnabled = false
                }
                if buttonIndex == 2 {
                    button3.isEnabled = false
                }
                if buttonIndex == 3 {
                    button4.isEnabled = false
                }
            }
        }
       
        //print("questionNum \(questionNum)")
        //print("currentQuestionIndex \(currentQuestionIndex)")
        //print("isCorrect \(isCorrect)")
        
        // if there are no more questions, say so instead of making the user click the Next button first
        //index starts at 0
        if currentQuestionIndex + 1 == questionNum  && isCorrect  {
            nextButton.setTitle("All done!", for: .normal)
            nextButton.isHidden = false
            nextButton.isEnabled = false
        }
    }
    
    @IBAction func didTapNextButton(sender: AnyObject) {
        // determine if there are any more questions to be displayed
        updateLabelsAndButtonsForIndex(questionIndex: currentQuestionIndex + 1, arrayType: planet!.name)
        
        //print("tappedNextbtn")
        //reset buttons since question was answered correctly
        button1.isEnabled = true
        button2.isEnabled = true
        button3.isEnabled = true
        button4.isEnabled = true
    }
    
    // will open up the website defined in the planet array
    @IBAction func tappedMe(){
        guard let url = URL(string: (planet?.url)!) else {
            return //be safe
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        //print("Tapped on Image")
    }
    
//end of PlanetViewController Class
}



