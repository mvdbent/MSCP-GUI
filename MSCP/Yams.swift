//
//  Yams.swift
//  MSCP
//
//  Created by Bob Gendler on 8/24/20.
//  Copyright © 2020 Bob Gendler. All rights reserved.
//

import Foundation
import Yams

//structure of the baseline yaml
struct baselineYaml: Decodable {
    
    let title: String
    let description: String
    
    let profile: [profile]
    struct profile: Decodable {
        let section: String
        let rules: [String]
    }
}

//structure of the rule yaml
struct ruleYaml: Decodable {
    let id: String
    let title: String
    let check: String
    let result: [String:String]
    let fix: String
    let references: [String:[String]]
    let macOS: String
    let tags: [String]
    let mobileconfig: Bool
}


//baselines - method to read the baseline Yam
class baselines {
    func readBaseline(baseline: String) -> [String] {
        let fullURLString = defaultLocalRepoPath + "/baselines/" + baseline
        let decoder = YAMLDecoder()
        var ruleList = [String]()
        if let baselineYam = try? String(contentsOfFile: fullURLString),
            let decodedYamlBaseline = try? decoder.decode(baselineYaml.self, from: baselineYam) {
            for section in decodedYamlBaseline.profile {
                for rule in section.rules {
                    ruleList.append(rule)
                }
            }
            
        } else {
            //other things
        }
        
        return ruleList
    }
}


//rules class - method to read the rules
class rules {
    func readRules(ruleURL: URL) {
        let decoder = YAMLDecoder()
        if let ruleFile = try? String(contentsOf: ruleURL),
            let decodedYamlRule = try? decoder.decode(ruleYaml.self, from: ruleFile) {
                print(decodedYamlRule.title)
        }
    }
    
}
