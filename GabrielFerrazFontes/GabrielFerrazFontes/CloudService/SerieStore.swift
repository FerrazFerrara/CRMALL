//
//  SerieStore.swift
//  GabrielFerrazFontes
//
//  Created by Ferraz on 21/12/20.
//

import Foundation

class SerieStore: SerieService {
    
    static let shared = SerieStore()
    private init() {}
    
    private let apiKey = "dcfff46ec71f6d454bd67bcbce547131"
    private let baseAPIURL = "https://api.themoviedb.org/3"
    private let urlSession = URLSession.shared
    private let jsonDecoder = Utils.jsonDecoder
    
    
    func fetchSeries(from endpoint: SerieListEndpoint, page: Int, completion: @escaping (Result<SerieResponse, SerieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/tv/\(endpoint.rawValue)") else {
            completion(.failure(.invalidEndPoint))
            return
        }
        self.loadURLandDecoder(url: url, params: ["language": "pt-BR", "page": "\(page)"], completion: completion)
    }
    
    private func loadURLandDecoder<D: Decodable>(url: URL, params: [String: String]? = nil, completion: @escaping (Result<D, SerieError>) -> ()){
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            completion(.failure(.invalidEndPoint))
            return
        }
        
        var queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        
        if let params = params {
            queryItems.append(contentsOf: params.map { URLQueryItem(name: $0.key, value: $0.value) })
        }
        
        urlComponents.queryItems = queryItems
        
        guard let finalURL = urlComponents.url else {
            completion(.failure(.invalidEndPoint))
            return
        }
        
        urlSession.dataTask(with: finalURL) { [weak self] (data, response, error) in
            guard let self = self else { return }
            
            if error != nil {
                self.executeCompletionHandlerMainThread(with: .failure(.apiError), completion: completion)
                completion(.failure(.apiError))
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                self.executeCompletionHandlerMainThread(with: .failure(.invalidResponse), completion: completion)
                return
            }
            
            guard let data = data else {
                self.executeCompletionHandlerMainThread(with: .failure(.noData), completion: completion)
                return
            }
            
            do {
                let decodedResponse = try self.jsonDecoder.decode(D.self, from: data)
                self.executeCompletionHandlerMainThread(with: .success(decodedResponse), completion: completion)
            } catch {
                self.executeCompletionHandlerMainThread(with: .failure(.serializationError), completion: completion)
            }
        }.resume()
    }
    
    private func executeCompletionHandlerMainThread<D: Decodable>(with result: Result<D, SerieError>, completion: @escaping (Result<D, SerieError>) -> ()){
        DispatchQueue.main.async {
            completion(result)
        }
    }
    
}
