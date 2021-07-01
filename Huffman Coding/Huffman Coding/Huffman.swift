//
//  Huffman.swift
//  Huffman Coding
//
//  Created by Manuel Pleš on 12/05/2020.
//  Copyright © 2020 Manuel Ples. All rights reserved.
//

import Foundation
class Huffman {
    
    var tree: [Node]
    var solution: [CharacterCode]
    
    init() {
        self.tree = [Node]()
        self.solution = [CharacterCode]()
    }
    
    func createHuffmanTree() {
        tree.sort{$0.frequency > $1.frequency}
        while(tree.count > 1){
            var newNode = Node()
            let leastFrequencyIndex1 = tree.indices.filter{tree[$0].frequency == tree.min{$0.frequency < $1.frequency}?.frequency}.max()!
            var firstNode = tree[leastFrequencyIndex1]
            tree.remove(at: leastFrequencyIndex1)
            let leastFrequencyIndex2 = tree.indices.filter{tree[$0].frequency == tree.min{$0.frequency < $1.frequency}?.frequency}.max()!
            var secondNode = tree[leastFrequencyIndex2]
            tree.remove(at: leastFrequencyIndex2)
            if leastFrequencyIndex1 > leastFrequencyIndex2 {
                let tempNode = firstNode
                firstNode = secondNode
                secondNode = tempNode
            }
            newNode.frequency = firstNode.frequency + secondNode.frequency
            newNode.characters = [firstNode.characters, secondNode.characters]
            let newIndex = min(leastFrequencyIndex1, leastFrequencyIndex2)
            tree.insert(newNode, at: newIndex)
        }
    }
    
    
   lazy var characterCode = CharacterCode(currentCode: "", characters: tree[0].characters)
    
    func getEncodedData(list: CharacterCode) {
        if list.characters is Character {
            solution.append(list)
            return
        }
        let newListLeft: CharacterCode = CharacterCode(currentCode: list.currentCode + "0", characters: (list.characters as! [Any])[0])
        let newListRight: CharacterCode = CharacterCode(currentCode: list.currentCode + "1", characters: (list.characters as! [Any])[1])
        getEncodedData(list: newListLeft)
        getEncodedData(list: newListRight)
        return
    }
    
}
