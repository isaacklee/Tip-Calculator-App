//
//  ViewController.swift
//  LeeIsaacHW4
//
//  Created by isaac k lee on 2021/03/01.
//

import UIKit

class ViewController: UIViewController {
    
    var index:Int = 0
    var taxTitle:String?
    var taxPercent:Double = 0.0
    var tipPercent:Double = 0.0
    var numSplit:Double = 0.0
    var bill:Double = 0.0
    var tax:Double = 0.0
    var tip:Double = 0.0
    var total:Double = 0.0
    var tipSplit:Double = 0.0
    var totalSplit:Double = 0.0
    
    // UI components that you can interact
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var taxPercentSegmentedControl: UISegmentedControl!
    @IBOutlet weak var tipPercentSlider: UISlider!
    @IBOutlet weak var roundUpSwitch: UISwitch!
    @IBOutlet weak var splitStepper: UIStepper!
    @IBOutlet weak var resetButton: UIButton!
    
    
    // all the dyamic labels that will change based on userinput
    @IBOutlet weak var tipPercentSliderAmountLabel: UILabel!
    @IBOutlet weak var splitStepperAmountLabel: UILabel!
    @IBOutlet weak var taxAmountLabel: UILabel!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var tipSplitAmountLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var totalSplitAmountLabel: UILabel!
    //static labels that dont change - title labels
    @IBOutlet weak var tipCalculatorLabel: UILabel!
    @IBOutlet weak var billLabel: UILabel!
    @IBOutlet weak var taxPercentSegmentedLabel: UILabel!
    @IBOutlet weak var roundUpLabel: UILabel!
    
    @IBOutlet weak var oneView: UIView!

    @IBAction func billinput(_ sender: Any) {
        updateUI()
    }
    
    
    @IBAction func tapBackGround(_ sender: UITapGestureRecognizer) {
        billTextField.resignFirstResponder()
        updateUI()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        taxPercentSegmentedControl.selectedSegmentIndex = 2
        roundUpSwitch.isOn = false
        tipPercentSlider.value=15
        tipPercentSliderAmountLabel.text = "\(Int(tipPercentSlider.value))%"
        billTextField.accessibilityIdentifier = HW4AccessibilityIdentifiers.billTextField
        taxPercentSegmentedControl.accessibilityIdentifier = HW4AccessibilityIdentifiers.taxPercentSegmentedControl
        tipPercentSlider.accessibilityIdentifier = HW4AccessibilityIdentifiers.tipPercentSlider
        roundUpSwitch.accessibilityIdentifier = HW4AccessibilityIdentifiers.roundUpSwitch
        splitStepper.accessibilityIdentifier = HW4AccessibilityIdentifiers.splitStepper
        resetButton.accessibilityIdentifier = HW4AccessibilityIdentifiers.resetButton
        tipPercentSliderAmountLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.tipPercentSliderAmountLabel
        splitStepperAmountLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.splitStepperAmountLabel
        taxAmountLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.taxAmountLabel
        tipAmountLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.tipAmountLabel
        tipSplitAmountLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.tipSplitAmountLabel
        totalAmountLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.totalAmountLabel
        totalSplitAmountLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.totalSplitAmountLabel
        tipCalculatorLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.tipCalculaterLabel
        billLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.billLabel
        taxPercentSegmentedLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.taxPercentSegmentedLabel
        roundUpLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.roundUpLabel
        oneView.accessibilityIdentifier = HW4AccessibilityIdentifiers.view
        
        
    }
    @IBAction func taxPercentDidTapped(_ sender: UISegmentedControl) {
        updateUI()
    }
    @IBAction func tipPercentDidChange(_ sender: UISlider) {
        // Double(Int(sender.value.rounded()))
        tipPercentSliderAmountLabel.text = "\(Int(sender.value.rounded()))%"
        updateUI()
    }
    @IBAction func roundUpDidChange(_ sender: UISwitch) {
        updateUI()
    }
    @IBAction func splitDidChange(_ sender: UIStepper) {
        splitStepperAmountLabel.text = "Split \(Int(sender.value))"
        updateUI()
    }
    @IBAction func clearAllTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Clear All Values", message: "Are you sure you want to clear all values?", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let clearAllAction = UIAlertAction(title: "Clear All", style: .destructive, handler: setDefaultValues)
        alert.addAction(cancelAction)
        alert.addAction(clearAllAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func round2(_ value: Double) -> Double {
        return (value * 100).rounded() / 100
    }
    func setDefaultValues(action:UIAlertAction){
        billTextField.text = nil
        taxPercentSegmentedControl.selectedSegmentIndex = 2
        roundUpSwitch.isOn = false
        tipPercentSlider.value=15
        tipPercentSliderAmountLabel.text = "\(Int(tipPercentSlider.value))%"
        splitStepper.value = 1
        splitStepperAmountLabel.text = "Split \(Int(splitStepper.value))"
        updateUI()

    }

        
    func updateUI(){
        index = taxPercentSegmentedControl.selectedSegmentIndex
        taxTitle = taxPercentSegmentedControl.titleForSegment(at: index)
        taxPercent = Double(taxTitle!)!*0.01
        tipPercent = Double(Int(tipPercentSlider.value.rounded()))*0.01
        
        numSplit = splitStepper.value
        
        if billTextField.text == nil{
            bill = 0.00
        }else{
            bill = Double(billTextField.text!) ?? 0
        }
        
        tax = round2(bill * taxPercent)
        tip = round2(bill * tipPercent)
        total = bill + tax + tip
        
        
        if roundUpSwitch.isOn{
            let diff = abs(ceil(total)-total)
            tip = round2(tip + diff)
            total = round2(bill + tax + tip)
        }
        tipSplit = round2(tip/numSplit)
        totalSplit = round2(total/numSplit)
        taxAmountLabel.text = "Tax $\(String(format: "%.2f", tax))"
        tipAmountLabel.text = "Tip $\(String(format: "%.2f", tip))"
        totalAmountLabel.text = "Total $\(String(format: "%.2f", total))"
        tipSplitAmountLabel.text = "Tip split $\(String(format: "%.2f", tipSplit))"
        totalSplitAmountLabel.text = "Total split $\(String(format: "%.2f", totalSplit))"
    }
    
}

