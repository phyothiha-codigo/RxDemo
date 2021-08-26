//
//  ApiService.swift
//  RxSwiftDemo
//
//  Created by Sheilar on 09/08/2021.
//

import RxSwift

protocol ApiServiceProtocol {
    func executeDataTask<T: Codable>(params: [String: String]?, endpoint: Endpoint) -> Observable<T>
}

class ApiService: ApiServiceProtocol {
    
    private var session: URLSession!
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func executeDataTask<T: Codable>(params: [String: String]?, endpoint: Endpoint) -> Observable<T> {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = Configuration.env.host
        urlComponents.path = endpoint.path
        
        // add query parameters
        if let params = params {
            urlComponents.queryItems = params.map({ URLQueryItem(name: $0.key, value: $0.value) })
            print("PARAMS => \(params)")
        }
        
        guard let url = urlComponents.url else {
            return .error(APIError.invalidURL(endpoint.path))
        }
        
        print("REQ => \(url)")
  
    
        return Observable.create { observer in
            
            self.session.dataTask(with: url) { data, response, error in
                
                if let error = error {
                    observer.onError(APIError.forwarded(error))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    observer.onError(APIError.serverError(url))
                    return
                }
                if let data = data {
                    do {
                        let result = try JSONDecoder().decode(T.self, from: data)
                        observer.onNext(result)
                        observer.onCompleted()
                    } catch (let error) {
                        observer.onError(APIError.forwarded(error))
                    }
                } else {
                    observer.onError(APIError.invalidPayload(url))
                }
            }.resume()
            
            return Disposables.create()
        }
        
    }
}
