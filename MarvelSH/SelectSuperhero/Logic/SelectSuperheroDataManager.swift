//
//  SelectSuperheroDataManager.swift
//  MarvelSH
//
//  Created by Pablo Ramirez on 10/29/19.
//  Copyright © 2019 Pablo Ramirez. All rights reserved.
//

import Foundation
import RxSwift

public enum RequestType: String {
    case GET, POST
}

struct SuperheroModel: Codable {
    let superheroes: [DetailsSuperheroModel]
    
    private enum CodingKeys: String, CodingKey {
        case superheroes
    }
}

struct DetailsSuperheroModel: Codable {
    let name: String
    let photo: String
    let realName: String
    let height: String
    let power: String
    let abilities: String
    let groups: String
    
    private enum CodingKeys: String, CodingKey {
        case name
        case photo
        case realName
        case height
        case power
        case abilities
        case groups
    }
}

protocol APIRequest {
    var method: RequestType { get }
    var path: String { get }
    var parameters: [String : String] { get }
}

extension APIRequest {
    func request(with baseURL: URL) -> URLRequest {
        guard let components = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false) else {
            fatalError("Error al crear los componentes en la URL")
        }
    
        guard let url = components.url else {
            fatalError("No se pudo crear la URL")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
}

class SuperheroesRequest: APIRequest {
    var method = RequestType.GET
    var path = ""
    var parameters = [String: String]()
    
    init() { }
}

class APIClient {
    private let baseURL = URL(string: "https://api.myjson.com/bins/bvyob")!
    
    func send<T: Codable>(apiRequest: APIRequest) -> Observable<T> {
        return Observable<T>.create { observer in
            let request = apiRequest.request(with: self.baseURL)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                do {
                    let model: T = try JSONDecoder().decode(T.self, from: data ?? Data())
                    observer.onNext(model)
                } catch let error {
                    observer.onError(error)
                }
                observer.onCompleted()
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
