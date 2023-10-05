//
//  NetworkManager.swift
//  K-AGScore
//
//  Created by Baem on 2023/10/05.
//

import Foundation
import SwiftSoup

class NetworkManager {
    
    static func parsingData(completion: @escaping (Result<[ScoreData], NetworkError>) -> Void) {
        
        let urlAddress = "https://info.hangzhou2022.cn/en/results/all-sports/medal-standings.htm"
        
        var scoreDatas = [ScoreData]()
        
        guard let url = URL(string: urlAddress) else { return }
        
        do {
            let html = try String(contentsOf: url, encoding: .utf8)
            let doc: Document = try SwiftSoup.parse(html)
            let firstLinkTitles: Elements = try doc.select(".table-responsive").select("#medal-standing")
            let rows = try firstLinkTitles.select("tr")
            
            for row in rows {
                let cells = try row.select("td")
                var subArray = [String]()
                
                for cell in cells { // [순위, 국가, 금, 은, 동, 전체, 합계순위, 국가]
                    subArray.append(try cell.text())
                }
                
                if subArray.count == 7 {
                    let scoreData = ScoreData(
                        rank: subArray[0],
                        nation: subArray[1],
                        gold: subArray[2],
                        silver: subArray[3],
                        bronze: subArray[4],
                        totalMedal: subArray[5],
                        totalMedalRank: subArray[6],
                        alpha3: subArray[7]
                    )
                    
                    scoreDatas.append(scoreData)
                }
            }
            
            completion(.success(scoreDatas))
        } catch {
            completion(.failure(.networkError))
        }
    }
}
