//
//  HttpClient.swift
//  Wallet
//
//  Created by Fedorova Maria on 21.05.2025.
//

import Foundation

protocol HttpClient {
    func send<T: Request>(_ request: T, completionHandler: @escaping (Result<T.ResponseType, Error>) -> Void)
}

final class HttpClientImpl: HttpClient {
    func send<T: Request>(_ request: T, completionHandler: @escaping (Result<T.ResponseType, Error>) -> Void) {
        guard let url = request.url else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                completionHandler(.failure(error))
                return
            }

            guard let data else {
                completionHandler(.failure(NSError(domain: "NoData", code: -1, userInfo: nil)))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decodedResponse = try decoder.decode(T.ResponseType.self, from: data)

                completionHandler(.success(decodedResponse))
            } catch {
                completionHandler(.failure(error))
            }
        }.resume()
    }
}
