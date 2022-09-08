import UIKit

class CalculatorViewController: UIViewController {
    @IBOutlet var billTextField: UITextField!
    @IBOutlet var zeroPctButton: UIButton!
    @IBOutlet var tenPctButton: UIButton!
    @IBOutlet var twentyPctButton: UIButton!
    @IBOutlet var splitNumberLabel: UILabel!
    
    var selectTip: Int = 10
    var split: Float = 2
    var totalPerPerson: String?
    
    var tipBrain = TipBrain()
    
    @IBAction func tipChanged(_ sender: UIButton) {
        if sender.currentTitle == "0%"{
            zeroPctButton.isSelected = true
            tenPctButton.isSelected = false
            twentyPctButton.isSelected = false
            selectTip = 0
        }
        if sender.currentTitle == "10%"{
            zeroPctButton.isSelected = false
            tenPctButton.isSelected = true
            twentyPctButton.isSelected = false
            selectTip = 10
        }
        if sender.currentTitle == "20%"{
            zeroPctButton.isSelected = false
            tenPctButton.isSelected = false
            twentyPctButton.isSelected = true
            selectTip = 20
        }
        billTextField.endEditing(true)
        
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(format: "%.f", sender.value)
        split = Float(sender.value)
    }
    
    @IBAction func calculatepressed(_ sender: UIButton) {
        
        if let bill = Float(billTextField.text!), let split = Float(splitNumberLabel.text!) {
            totalPerPerson = tipBrain.calculateTip(bill: bill, split: split, selectTip: selectTip)
            performSegue(withIdentifier: "goToResult", sender: nil)
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc = segue.destination as! ResultsViewController
        vc.split = Int(split)
        vc.tip = selectTip
        vc.totalPerPerson = totalPerPerson
        print("ok")
        
    }
    
}

