//
//  ContentView.swift

//

//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numbersOfPeople = 2
    @State private var tipPercentage = 20
    
    // FocusState = Handles focus input
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10,15,20,25,0]
    var wideRangeOfTips: [Int]{
        var listOfTips = [Int]()
        for i in 0..<101{
            listOfTips.append(i)
        }
        return listOfTips
        
    }
       
    var totalPlusTip: Double{
        let totalAmount = Double(checkAmount)
        let tipPercentage = Double(tipPercentage)
        
        let tipAmount = checkAmount / 100 * tipPercentage
        let fullTotal = totalAmount + tipAmount
        
        return fullTotal
    }
    
    var totalPerPerson: Double{
        let peopleCount = Double(numbersOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationStack{

            Form{
                Section{
                    // text field with the title of "Amount" and having a value of " var checkAmount" with the format of currency. Instead of a default code currency, check the "Locale current currency indetifier" if it does not have one, set it to "USD"
                    TextField("Amount" , value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD")) // instead of getting the keyboard with all letters, nums and emojis. Just open a keyboard of decimals to enter amount.
                        .keyboardType(.decimalPad)
                    // check if textfield is receiving focus
                        .focused($amountIsFocused)
                    
                    // picker/selection, called "Number of people", selecting :var numbersOfPeople
                    Picker ("Number of people", selection : $numbersOfPeople){
                        // pick the amount of people between  (2 to 100)
                        ForEach(2..<100) {
                            Text("\($0) people") // show amount of people options
                            
                        }
                    } // You can have the Picker in the main page or add pickerStyle(.navigationLink) to take you to a different page to select your option
                    .pickerStyle(.navigationLink)
                }
                // adding a title to the section without adding another text tag inside the form
                Section("How much you want to tip?"){
                    // A picker to select the percentage
                    Picker("Tip percentage", selection : $tipPercentage){
                        // for each Int in the tipPercentages array. (id: of each Int itself)
                        /*ForEach(tipPercentages, id: \.self)*/
                        ForEach(wideRangeOfTips, id: \.self){
                            //show text of Int in percentage format
                            Text($0, format: .percent)
                        }
                        // Selecting a different Picker Style
                    } .pickerStyle(.navigationLink)
                    /*.pickerStyle(.segmented)*/
                }
                
                Section("Breakdown"){
                    HStack{
                        Text("Total amount")
                        Spacer()
                        Text(checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    }
                    HStack{
                        Text("Tip")
                        Spacer()
                        Text(tipPercentage, format: .percent)
                    }
                    HStack{
                        Text("Total + Tip")
                        Spacer()
                        Text(totalPlusTip, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        
                    }

                    
                }
                
                
                Section("Amount per person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit").navigationBarTitleDisplayMode(.large)
            //add toolbar to dismiss keyboard but only when this textfield is currently active
            
            .toolbar { // toolbar items for reviews
                if amountIsFocused{ //if item is focused
                    Button("Done"){// show button option to press Done
                        amountIsFocused = false // and keyboard gets dismissed
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

