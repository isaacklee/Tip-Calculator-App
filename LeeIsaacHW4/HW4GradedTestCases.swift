//
//  HW3GradedTestCases.swift
//  HW3
//
//  Created by Harrison Weinerman on 9/3/18.
//  Copyright © 2018 Harrison Weinerman. All rights reserved.

import XCTest

/// Test cases used for grading
class HW4GradedTestCases: XCTestCase {
    
    private let app = XCUIApplication()
    
    //sets up the UI for all tests so that depending on config its all the same
    override func setUp() {
        super.setUp()
        XCUIDevice.shared.orientation = .portrait
        continueAfterFailure = false
        XCUIApplication().launch()
        
        // default to switch off for all tests
        let switchtax = app.switches["roundUpSwitch"]
        switchtax.tap()
        let isOn = switchtax.value as! String
        if isOn == "1" {
            switchtax.tap()
        }
        let billTextField = app.textFields["billTextField"]
        //added for students who are making keyboard come up on runtime
        if app.keyboards.count != 0 {
            billTextField.typeText("\n")
        }
    }

/// This test should pass regardless of how you configured your app; should have all these components
    func testBasicUIElements() {
        // test ui components that you can interact with
        let billTextField = app.textFields[HW4AccessibilityIdentifiers.billTextField]
        let taxPercentSegmentedControl = app.segmentedControls[HW4AccessibilityIdentifiers.taxPercentSegmentedControl]
        let tipPercentSlider = app.sliders[HW4AccessibilityIdentifiers.tipPercentSlider]
        let roundUpSwitch = app.switches[HW4AccessibilityIdentifiers.roundUpSwitch]
        let splitStepper = app.steppers[HW4AccessibilityIdentifiers.splitStepper]
        let resetButton = app.buttons[HW4AccessibilityIdentifiers.resetButton]
        
        // all the dyamic labels that will change based on userinput
        let tipPercentSliderAmountLabel = app.staticTexts[HW4AccessibilityIdentifiers.tipPercentSliderAmountLabel]
        let splitStepperAmountLabel = app.staticTexts[HW4AccessibilityIdentifiers.splitStepperAmountLabel]
        let taxAmountLabel = app.staticTexts[HW4AccessibilityIdentifiers.taxAmountLabel]
        let tipAmountLabel = app.staticTexts[HW4AccessibilityIdentifiers.tipAmountLabel]
        let tipSplitAmountLabel = app.staticTexts[HW4AccessibilityIdentifiers.tipSplitAmountLabel]
        let totalAmountLabel = app.staticTexts[HW4AccessibilityIdentifiers.totalAmountLabel]
        let totalSplitAmountLabel = app.staticTexts[HW4AccessibilityIdentifiers.totalSplitAmountLabel]
        
        //static labels that dont change - title labels
        let tipCalculaterLabel = app.staticTexts[HW4AccessibilityIdentifiers.tipCalculaterLabel]
        let billLabel = app.staticTexts[HW4AccessibilityIdentifiers.billLabel]
        let taxPercentSegmentedLabel = app.staticTexts[HW4AccessibilityIdentifiers.taxPercentSegmentedLabel]
        let roundUpLabel = app.staticTexts[HW4AccessibilityIdentifiers.roundUpLabel]
        
        //connecting at least one view
        let calcView = app.otherElements[HW4AccessibilityIdentifiers.view]
        
        //verify that the components exist on the screen
        XCTAssert(billTextField.exists)
        XCTAssert(taxPercentSegmentedControl.exists)
        XCTAssert(tipPercentSlider.exists)
        XCTAssert(roundUpSwitch.exists)
        XCTAssert(splitStepper.exists)
        XCTAssert(resetButton.exists)
        XCTAssert(tipPercentSliderAmountLabel.exists)
        XCTAssert(splitStepperAmountLabel.exists)
        XCTAssert(taxAmountLabel.exists)
        XCTAssert(tipAmountLabel.exists)
        XCTAssert(tipSplitAmountLabel.exists)
        XCTAssert(totalAmountLabel.exists)
        XCTAssert(totalSplitAmountLabel.exists)
        XCTAssert(billLabel.exists)
        XCTAssert(tipCalculaterLabel.exists)
        XCTAssert(billLabel.exists)
        XCTAssert(taxPercentSegmentedLabel.exists)
        XCTAssert(roundUpLabel.exists)
        
        //seeing if the user has at least 1 view
        XCTAssert(calcView.exists)
        
        //checks to see if there is a placeholder
        XCTAssertNotEqual(billTextField.placeholderValue, "")
    }
  
    func testDefaultValues() {
        //grab UI components
        let taxPercentSegmentedControl = app.segmentedControls["taxPercentSegmentedControl"]
        let tipPercentSlider = app.sliders["tipPercentSlider"]
        let roundUpSwitch = app.switches["roundUpSwitch"]
        //grab all the necessary labels
        let taxAmountLabel = app.staticTexts["taxAmountLabel"]
        let tipAmountLabel = app.staticTexts["tipAmountLabel"]
        let tipSplitAmountLabel = app.staticTexts["tipSplitAmountLabel"]
        let totalAmountLabel = app.staticTexts["totalAmountLabel"]
        let totalSplitAmountLabel = app.staticTexts["totalSplitAmountLabel"]
        let splitStepperAmountLabel = app.staticTexts["splitStepperAmountLabel"]
        let tipPercentSliderAmountLabel = app.staticTexts["tipPercentSliderAmountLabel"]
        
        // make sure the calcuation labels have default value
        XCTAssertEqual(taxAmountLabel.label, "Tax $0.00")
        XCTAssertEqual(tipAmountLabel.label, "Tip $0.00")
        XCTAssertEqual(tipSplitAmountLabel.label, "Tip split $0.00")
        XCTAssertEqual(totalAmountLabel.label, "Total $0.00")
        XCTAssertEqual(totalSplitAmountLabel.label, "Total split $0.00")
        XCTAssertEqual(splitStepperAmountLabel.label, "Split 1")
        // make sure UI components have default values
        XCTAssertEqual(taxPercentSegmentedControl.buttons["9"].isSelected, true)
        XCTAssertEqual(roundUpSwitch.value as! String , "0")
        XCTAssertEqual(tipPercentSlider.value as! String , "15%")
        XCTAssertEqual(tipPercentSliderAmountLabel.label , "15%")
    }
  
    //test the background button since keyboard doesnt have done button
    func testBackgroundButton() {
        // grab components
        let billTextField = app.textFields["billTextField"]
        let tipCalculaterLabel = app.staticTexts["tipCalculaterLabel"]
        
        // Validate that the background button dismisses the keyboard
        XCTAssertEqual(app.keyboards.count, 0)
        billTextField.tap()
        XCTAssertEqual(app.keyboards.count, 1)
        tipCalculaterLabel.tap()
        XCTAssertEqual(app.keyboards.count, 0)
    }
  
    // tax 8.5% - rounded up on - bill amount 100 - split 3
    func testCase1() {
        //type 100$ into the textfield
        let billAmount = 100
        let taxPercent = 8.5
        let billTextField = app.textFields["billTextField"]
        billTextField.tap()
        billTextField.typeText("\(billAmount)")
        let tipCalculaterLabel = app.staticTexts["tipCalculaterLabel"]
        tipCalculaterLabel.tap()

        // Validate starting state
        XCTAssertEqual(billTextField.label, "")
        XCTAssertEqual(app.keyboards.count, 0)

        //grab all the necessary labels
        let taxAmountLabel = app.staticTexts["taxAmountLabel"]
        let tipAmountLabel = app.staticTexts["tipAmountLabel"]
        let tipSplitAmountLabel = app.staticTexts["tipSplitAmountLabel"]
        let totalAmountLabel = app.staticTexts["totalAmountLabel"]
        let totalSplitAmountLabel = app.staticTexts["totalSplitAmountLabel"]
        let splitStepperAmountLabel = app.staticTexts["splitStepperAmountLabel"]
        //set taxes
        app.segmentedControls["taxPercentSegmentedControl"].buttons["\(taxPercent)"].tap()
        //get the switch to toggle it on
        let roundUpSwitch = app.switches["roundUpSwitch"]
        roundUpSwitch.tap()
        let isOn = roundUpSwitch.value as! String
        if isOn == "0" {
            // want to make sure this is enable, so tap again
            roundUpSwitch.tap()
        }
        
        //grab slider value
        let tipPercentSlider = app.sliders["tipPercentSlider"]
        tipPercentSlider.adjust(toNormalizedSliderPosition: 0.10)
        let sliderval = Double((tipPercentSlider.value as! String).components(separatedBy: "%").first!)

        //get segmented
        let numberOfSplits = 3
        let taxPercentSegmentedControl = app.segmentedControls["taxPercentSegmentedControl"]
        taxPercentSegmentedControl.buttons["\(taxPercent)"].tap()
        // split
        let splitStepperIncrementButton = XCUIApplication().steppers["splitStepper"].buttons["Increment"]
        splitStepperIncrementButton.tap()
        splitStepperIncrementButton.tap()
        // Verify split stepper label
        XCTAssertEqual(splitStepperAmountLabel.label, "Split \(numberOfSplits)")
        
        // calculate tip
        var tip = Double(billAmount) * ((sliderval!) / 100.00)
        // calculate tax
        let tax = Double(billAmount) * (Double(taxPercent) / 100.00)
        let taxString = String(format: "Tax $%.02f", tax)
        //verify tax label
        XCTAssertEqual(taxAmountLabel.label, taxString)
        // calculate total amount
        var totalAmount = Double(billAmount) + tax + tip
        //if rounded up is on
        if isOn == "1" {
            let roundedTotalAmount = ceil(totalAmount)
            let totalAmountDif = abs(roundedTotalAmount - totalAmount)
            totalAmount = roundedTotalAmount
            tip = tip + totalAmountDif
        }
      
        // calculate tip splits
        let tipSplit = tip / Double(numberOfSplits)
        let tipString = String(format: "Tip $%.02f", tip)
        let tipSplitString = String(format: "Tip split $%.02f", tipSplit)
        
        // calculate total split
        let splitTotalAmount = totalAmount / Double(numberOfSplits)
        let totalString = String(format: "Total $%.02f", totalAmount)
        let splitTotalString = String(format: "Total split $%.02f", splitTotalAmount)
        // verify tip label
        XCTAssertEqual(tipAmountLabel.label, tipString)
        XCTAssertEqual(tipSplitAmountLabel.label, tipSplitString)
        //verify total labels
        XCTAssertEqual(totalAmountLabel.label, totalString)
        XCTAssertEqual(totalSplitAmountLabel.label, splitTotalString)
    }
  
    // tax 9% - rounded up on - bill amount 100 - split 2
    func testCase2() {
        let billAmount = 100
        let taxPercent = 9
        //type 100$ into the textfield
        let billTextField = app.textFields["billTextField"]
        billTextField.tap()
        billTextField.typeText("\(billAmount)")
        let tipCalculaterLabel = app.staticTexts["tipCalculaterLabel"]
        tipCalculaterLabel.tap()

        // Validate starting state
        XCTAssertEqual(billTextField.label, "")
        XCTAssertEqual(app.keyboards.count, 0)

        //grab all the necessary labels
        let taxAmountLabel = app.staticTexts["taxAmountLabel"]
        let tipAmountLabel = app.staticTexts["tipAmountLabel"]
        let tipSplitAmountLabel = app.staticTexts["tipSplitAmountLabel"]
        let totalAmountLabel = app.staticTexts["totalAmountLabel"]
        let totalSplitAmountLabel = app.staticTexts["totalSplitAmountLabel"]
        let splitStepperAmountLabel = app.staticTexts["splitStepperAmountLabel"]
        //set taxes
        app.segmentedControls["taxPercentSegmentedControl"].buttons["\(taxPercent)"].tap()
        //get the switch to toggle it on
        let roundUpSwitch = app.switches["roundUpSwitch"]
        roundUpSwitch.tap()
        let isOn = roundUpSwitch.value as! String
        if isOn == "0" {
            // want to make sure this is enable, so tap again
            roundUpSwitch.tap()
        }
        
        //grab slider value
        let tipPercentSlider = app.sliders["tipPercentSlider"]
        tipPercentSlider.adjust(toNormalizedSliderPosition: 0.10)
        let sliderval = Double((tipPercentSlider.value as! String).components(separatedBy: "%").first!)

        //get segmented
        let taxPercentSegmentedControl = app.segmentedControls["taxPercentSegmentedControl"]
        taxPercentSegmentedControl.buttons["\(taxPercent)"].tap()
        // split
        let numberOfSplits = 2
        let splitStepperIncrementButton = XCUIApplication().steppers["splitStepper"].buttons["Increment"]
        splitStepperIncrementButton.tap()
        // Verify split stepper label
        XCTAssertEqual(splitStepperAmountLabel.label, "Split \(numberOfSplits)")
        
        // calculate tip
        var tip = Double(billAmount) * ((sliderval!) / 100.00)
        // calculate tax
        let tax = Double(billAmount) * (Double(taxPercent) / 100.00)
        let taxString = String(format: "Tax $%.02f", tax)
        //verify tax label
        XCTAssertEqual(taxAmountLabel.label, taxString)
        // calculate total amount
        var totalAmount = Double(billAmount) + tax + tip
        //if rounded up is on
        if isOn == "1" {
            let roundedTotalAmount = ceil(totalAmount)
            let totalAmountDif = abs(roundedTotalAmount - totalAmount)
            totalAmount = roundedTotalAmount
            tip = tip + totalAmountDif
        }
        // calculate tip splits
        let tipSplit = tip / Double(numberOfSplits)
        let tipString = String(format: "Tip $%.02f", tip)
        let tipSplitString = String(format: "Tip split $%.02f", tipSplit)
        
        // calculate total split
        let splitTotalAmount = totalAmount / Double(numberOfSplits)
        let totalString = String(format: "Total $%.02f", totalAmount)
        let splitTotalString = String(format: "Total split $%.02f", splitTotalAmount)
        // verify tip label
        XCTAssertEqual(tipAmountLabel.label, tipString)
        XCTAssertEqual(tipSplitAmountLabel.label, tipSplitString)
        //verify total labels
        XCTAssertEqual(totalAmountLabel.label, totalString)
        XCTAssertEqual(totalSplitAmountLabel.label, splitTotalString)
    }
  
    // tax 9.5% - rounded up off - bill amount 100 - split 1
    func testCase3() {
        //type 100$ into the textfield
        let billAmount = 100
        let taxPercent = 9.5
        let billTextField = app.textFields["billTextField"]
        billTextField.tap()
        billTextField.typeText("\(billAmount)")
        let tipCalculaterLabel = app.staticTexts["tipCalculaterLabel"]
        tipCalculaterLabel.tap()

        // Validate starting state
        XCTAssertEqual(billTextField.label, "")
        XCTAssertEqual(app.keyboards.count, 0)

        //grab all the necessary labels
        let taxAmountLabel = app.staticTexts["taxAmountLabel"]
        let tipAmountLabel = app.staticTexts["tipAmountLabel"]
        let tipSplitAmountLabel = app.staticTexts["tipSplitAmountLabel"]
        let totalAmountLabel = app.staticTexts["totalAmountLabel"]
        let totalSplitAmountLabel = app.staticTexts["totalSplitAmountLabel"]
        let splitStepperAmountLabel = app.staticTexts["splitStepperAmountLabel"]
        //set taxes
        app.segmentedControls["taxPercentSegmentedControl"].buttons["\(taxPercent)"].tap()
        
        //grab slider value
        let tipPercentSlider = app.sliders["tipPercentSlider"]
        tipPercentSlider.adjust(toNormalizedSliderPosition: 0.10)
        let sliderval = Double((tipPercentSlider.value as! String).components(separatedBy: "%").first!)

        //get segmented
        let taxPercentSegmentedControl = app.segmentedControls["taxPercentSegmentedControl"]
        taxPercentSegmentedControl.buttons["\(taxPercent)"].tap()
        // split
        let numberOfSplits = 1
        // Verify split stepper label
        XCTAssertEqual(splitStepperAmountLabel.label, "Split \(numberOfSplits)")
        
        // calculate tip
        let tip = Double(billAmount) * ((sliderval!) / 100.00)
        // calculate tax
        let tax = Double(billAmount) * (Double(taxPercent) / 100.00)
        let taxString = String(format: "Tax $%.02f", tax)
        //verify tax label
        XCTAssertEqual(taxAmountLabel.label, taxString)
        // calculate total amount
        let totalAmount = Double(billAmount) + tax + tip
        
        // calculate tip splits
        let tipSplit = tip / Double(numberOfSplits)
        let tipString = String(format: "Tip $%.02f", tip)
        let tipSplitString = String(format: "Tip split $%.02f", tipSplit)
        
        // calculate total split
        let splitTotalAmount = totalAmount / Double(numberOfSplits)
        let totalString = String(format: "Total $%.02f", totalAmount)
        let splitTotalString = String(format: "Total split $%.02f", splitTotalAmount)
        // verify tip label
        XCTAssertEqual(tipAmountLabel.label, tipString)
        XCTAssertEqual(tipSplitAmountLabel.label, tipSplitString)
        //verify total labels
        XCTAssertEqual(totalAmountLabel.label, totalString)
        XCTAssertEqual(totalSplitAmountLabel.label, splitTotalString)
    }

    //test the reset button and making sure the calculations are reset
    func testResetCalcs() {
        
        let billTextField = app.textFields["billTextField"]
        billTextField.tap()
        // in order to visible clear button
        let tipCalculaterLabel = app.staticTexts["tipCalculaterLabel"]
        tipCalculaterLabel.tap()
        // Validate starting state
        XCTAssertEqual(billTextField.label, "")
        XCTAssertEqual(app.keyboards.count, 0)
        // write in textfield
        billTextField.tap()
        billTextField.typeText("100")
        // in order to visible clear button
        tipCalculaterLabel.tap()
        // increase slider position
        let tipPercentSlider = app.sliders["tipPercentSlider"]
        tipPercentSlider.adjust(toNormalizedSliderPosition: 0.10)
        // change tax percentage
        let taxPercentSegmentedControl = app.segmentedControls["taxPercentSegmentedControl"]
        taxPercentSegmentedControl.buttons["9.5"].tap()
        // reset button tapped
        app/*@START_MENU_TOKEN@*/.buttons["resetButton"]/*[[".buttons[\"Clear All\"]",".buttons[\"resetButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.sheets.element.tap()
        //should have cleared
        XCTAssertEqual(billTextField.label, "")

        //grab all the necessary labels
        let taxAmountLabel = app.staticTexts["taxAmountLabel"]
        let tipAmountLabel = app.staticTexts["tipAmountLabel"]
        let tipSplitAmountLabel = app.staticTexts["tipSplitAmountLabel"]
        let totalAmountLabel = app.staticTexts["totalAmountLabel"]
        let totalSplitAmountLabel = app.staticTexts["totalSplitAmountLabel"]
        let splitStepperAmountLabel = app.staticTexts["splitStepperAmountLabel"]
        let tipPercentSliderAmountLabel = app.staticTexts["tipPercentSliderAmountLabel"]
        
        // grab switch button
        let roundUpSwitch = app.switches["roundUpSwitch"]
        
        // make sure the calcuation labels are reset
        XCTAssertEqual(taxAmountLabel.label, "Tax $0.00")
        XCTAssertEqual(tipAmountLabel.label, "Tip $0.00")
        XCTAssertEqual(tipSplitAmountLabel.label, "Tip split $0.00")
        XCTAssertEqual(totalAmountLabel.label, "Total $0.00")
        XCTAssertEqual(totalSplitAmountLabel.label, "Total split $0.00")
        XCTAssertEqual(splitStepperAmountLabel.label, "Split 1")
        // make sure the switch button and slider are reset
        XCTAssertEqual(taxPercentSegmentedControl.buttons["9"].isSelected, true)
        XCTAssertEqual(roundUpSwitch.value as! String , "0")
        XCTAssertEqual(tipPercentSlider.value as! String , "15%")
        XCTAssertEqual(tipPercentSliderAmountLabel.label , "15%")
    }

    // having a 0 bill should not cause program to crash
    func testZeroCase() {
        // should not display inf or anything like that
        //type 0$ into the textfield
        let billTextField = app.textFields["billTextField"]
        billTextField.tap()
        billTextField.typeText("0")
        let tipCalculaterLabel = app.staticTexts["tipCalculaterLabel"]
        tipCalculaterLabel.tap()

        // Validate starting state
        XCTAssertEqual(billTextField.label, "")
        XCTAssertEqual(app.keyboards.count, 0)

        //grab all the necessary labels
        let taxAmountLabel = app.staticTexts["taxAmountLabel"]
        let tipAmountLabel = app.staticTexts["tipAmountLabel"]
        let tipSplitAmountLabel = app.staticTexts["tipSplitAmountLabel"]
        let totalAmountLabel = app.staticTexts["totalAmountLabel"]
        let totalSplitAmountLabel = app.staticTexts["totalSplitAmountLabel"]

        // make sure everything is reset
        XCTAssertEqual(taxAmountLabel.label, "Tax $0.00")
        XCTAssertEqual(tipAmountLabel.label, "Tip $0.00")
        XCTAssertEqual(tipSplitAmountLabel.label, "Tip split $0.00")
        XCTAssertEqual(totalAmountLabel.label, "Total $0.00")
        XCTAssertEqual(totalSplitAmountLabel.label, "Total split $0.00")
    }

    // when you type, update labels, then maunally clear the TF
    // labels should be set to 0.00 calc
    func testTypingThenDeletingfromTF() {
        // should not display info or anything like that
        //type 0$ into the textfield
        let billTextField = app.textFields["billTextField"]
        billTextField.tap()
        billTextField.typeText("100")
        let tipCalculaterLabel = app.staticTexts["tipCalculaterLabel"]
        tipCalculaterLabel.tap()

        // Validate starting state
        XCTAssertEqual(billTextField.label, "")
        XCTAssertEqual(app.keyboards.count, 0)

        //undo the text
        billTextField.tap()
        for _ in 0..<3 {
            billTextField.typeText(XCUIKeyboardKey.delete.rawValue)
        }
        tipCalculaterLabel.tap()
        
        //grab all the necessary labels
        let taxAmountLabel = app.staticTexts["taxAmountLabel"]
        let tipAmountLabel = app.staticTexts["tipAmountLabel"]
        let tipSplitAmountLabel = app.staticTexts["tipSplitAmountLabel"]
        let totalAmountLabel = app.staticTexts["totalAmountLabel"]
        let totalSplitAmountLabel = app.staticTexts["totalSplitAmountLabel"]

        // make sure everything is reset to 0.00 for the calcuation labels
        XCTAssertEqual(taxAmountLabel.label, "Tax $0.00")
        XCTAssertEqual(tipAmountLabel.label, "Tip $0.00")
        XCTAssertEqual(tipSplitAmountLabel.label, "Tip split $0.00")
        XCTAssertEqual(totalAmountLabel.label, "Total $0.00")
        XCTAssertEqual(totalSplitAmountLabel.label, "Total split $0.00")
    }
}
