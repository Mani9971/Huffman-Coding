//
//  ViewController.swift
//  Huffman Coding
//
//  Created by Manuel Pleš on 17/04/2020.
//  Copyright © 2020 Manuel Ples. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        Encode(nil)
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func Encode(_ sender: UIButton?) {
        clearData()
        dataTable.reloadData()
        updateResult()
            if textField.text != "" && textField.text != nil {
                userEnteredString = textField.text!
                characterFrequency = getCharacterFrequency(from: userEnteredString)
                fillTree()
                huffman.createHuffmanTree()
                huffman.getEncodedData(list: huffman.characterCode)
                sortSolution()
                dataTable.reloadData()
                updateResult()
        } else {
                textField.placeholder = "Please enter the text!"
        }
    }
    
    @IBOutlet weak var dataTable: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    var huffman = Huffman()
    var userEnteredString = ""
    var resultString = ""
    var characterFrequency: [Character : Int] = [:]
    
    func getCharacterFrequency(from text: String) -> [Character : Int]{
        let characterFrequency = text.reduce([:]) { (d, c) -> Dictionary<Character,Int> in
            var d = d
            let i = d[c] ?? 0
            d[c] = i+1
            return d
        }
        return characterFrequency

    }
    
    func fillTree() {
        for character in characterFrequency {
            huffman.tree.append(Node(frequency: character.value, characters: character.key))
        }
    }
    
    func sortSolution(){
        huffman.solution.sort{$1.characters as! Character > $0.characters as! Character}
        if characterFrequency.count == 1{
            huffman.solution[0].currentCode = "1"
        }
    }
    
    func updateResult(){
        createDictionaryFromResult()
        for character in textField.text! {
                resultString.append(nodeDictionary[character] ?? "")
            }
        resultLabel.text = resultString
        }
        
    
    func clearData() {
        huffman = Huffman()
        userEnteredString = ""
        resultString = ""
        nodeDictionary = [:]
        resultLabel.text = ""
        characterFrequency = [:]
    }
    
    var nodeDictionary: [Character : String] = [:]
    
    func createDictionaryFromResult() {
        for code in huffman.solution {
            nodeDictionary[code.characters as! Character] = code.currentCode
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textField.delegate = self
        dataTable.delegate = self
        dataTable.dataSource = self
        dataTable.register(UINib(nibName: "CharacterTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
    }
}

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return huffman.solution.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CharacterTableViewCell
        let character = huffman.solution[indexPath.row].characters as! Character
        if character != " " {
        cell.characterLabel.text = "\(character)"
        }else {
            cell.characterLabel.text = "(space)"
        }
        cell.characterFrequencyLabel.text = "\(characterFrequency[character]!)"
        cell.characterCodeLabel.text = "\(huffman.solution[indexPath.row].currentCode)"
        cell.selectionStyle = .none

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}




