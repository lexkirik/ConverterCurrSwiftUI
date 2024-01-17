//
//  ContentView.swift
//  ConverterCurrSwiftUI
//
//  Created by Test on 10.11.23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var cad: Double = 0.0
    @State private var chf: Double = 0.0
    @State private var gbp: Double = 0.0
    @State private var jpy: Double = 0.0
    @State private var usd: Double = 0.0
    @State private var byn: Double = 0.0
    
    var body: some View {
        VStack {
            Text("Currency Converter")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            Spacer()
            Text("1 EUR = ")
                .font(.title2)
                .fontWeight(.bold)
            Spacer()
            Text("CAD = \(cad)")
            Spacer()
            Text("CHF = \(chf)")
            Spacer()
            Text("GBP = \(gbp)")
            Spacer()
            Text("JPY = \(jpy)")
            Spacer()
            Text("USD = \(usd)")
            Spacer()
            Text("BYN = \(byn)")
            Spacer()
            Button(action: {
                let url = URL(string: "http://data.fixer.io/api/latest?access_key=23d4c40b8b69de1ad68a9333cee9ac50")
                let session = URLSession.shared
                
                let task = session.dataTask(with: url!) { data, response, error in
                    if error != nil {
                        let alert = UIAlertController(title: "Error!", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                        alert.addAction(okButton)
                    } else {
                        if data != nil {
                            do {
                                let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                                DispatchQueue.main.async {
                                    if let rates = jsonResponse["rates"] as? [String : Any] {
                                        if let cadc = rates["CAD"] as? Double {
                                            cad = cadc
                                        }
                                        if let chfc = rates["CHF"] as? Double {
                                            chf = chfc
                                        }
                                        if let gbpc = rates["GBP"] as? Double {
                                            gbp = gbpc
                                        }
                                        if let jpyc = rates["JPY"] as? Double {
                                            jpy = jpyc
                                        }
                                        if let usdc = rates["USD"] as? Double {
                                            usd = usdc
                                        }
                                        if let bync = rates["BYN"] as? Double {
                                            byn = bync
                                        }
                                    }
                                }
                            } catch {
                                print("error")
                            }
                        }
                    }
                    
                }
                task.resume()
                
            }, label: {
                Text("Get Results")
            })
            .padding()
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
