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
        
        guard let url = URL(string: urlAddress) else { return }
        
        loadHTML(url: url) { result in
            switch result {
            case .success(let html):
                do {
                    let parsedData = try parsingHTML(html: html)
                    completion(.success(parsedData))
                } catch {
                    completion(.failure(.networkError))
                }
            case .failure:
                completion(.failure(.networkError))
            }
        }
    }
    
    private static func loadHTML(url: URL, completion: @escaping (Result<String, NetworkError>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.networkError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.networkError))
                return
            }
            
            guard let text = String(data: data, encoding: .utf8) else {
                completion(.failure(.networkError))
                return
            }
            
            completion(.success(text))
        }
        task.resume()
    }
    
    private static func parsingHTML(html: String) throws -> [ScoreData] {
        var scoreDatas = [ScoreData]()

        let doc: Document = try SwiftSoup.parse(html)
        let firstLinkTitles: Elements = try doc.select(".table-responsive").select("#medal-standing")
        let rows = try firstLinkTitles.select("tr")
        
        for row in rows {
            let cells = try row.select("td")
            var subArray = [String]()
            
            for cell in cells { // [순위, 국가, 금, 은, 동, 전체, 합계순위, 국가]
                subArray.append(try cell.text())
            }
            
            if subArray.count > 0 {
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
        
        return scoreDatas
    }
}
