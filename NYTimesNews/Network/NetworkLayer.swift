//
//  NetworkLayer.swift
//  NYTimesNews
//
//  Created by Yahia Mosaad on 03/01/2021.
//

import Foundation
// MARK: - mark Network Layer
enum RestMethod {
    case get
    case post
}

enum NetworkError: Error {
    case noInternetConnection
    case unexpectedError
    case parsingError
    case invaildURL
    case badRequest
    case noDataFound
}
protocol NetworkLayer {
    func execute<T: Codable> (request: APIRequest, withModel: T.Type,
                              success: @escaping ((T) -> Void) ,
                              failure: @escaping ((NetworkError) -> Void))
}

extension NetworkLayer {
    func execute<T: Codable> (request: APIRequest, withModel: T.Type,
                              success: @escaping ((T) -> Void) ,
                              failure: @escaping ((NetworkError) -> Void)) {
        var requestURLStr = ""
        switch request.method {
        case .get:
            requestURLStr = createGetRequest(for: request)
        case .post:
            requestURLStr = createPostRequest(for: request)
        }
        guard let requestUrl = URL(string: requestURLStr) else {
            failure(NetworkError.invaildURL)
            return
        }
        excuteDataTask(requestURL: requestUrl, withModel: withModel, success: { (result) in
            success(result)
        }, failure: { (error) in
            failure(error)
        })
    }
    // Create GET Request
    private func createGetRequest(for request: APIRequest) -> String {
        var requestURLStr = ""
        requestURLStr = request.baseURL + request.endPointName
        if request.paramters != nil {
            for key in request.paramters!.keys {
                let valueForKey = request.paramters?[key] as Any
                if let value = valueForKey as? String {
                    requestURLStr += key + value
                } else if let value = valueForKey as? Double {
                    requestURLStr += key + "\(value)"
                }
            }
        }
        requestURLStr += APIParametersKey.NYTimesAPIKey.key + APIParametersValue.NYTimesAPIValue.value
        print(requestURLStr)
        return requestURLStr
    }
    // Create POST Request
    private func createPostRequest(for request: APIRequest) -> String {
        return " "
    }
    // Excute UELSessionDataTak For Request
    private func excuteDataTask<T: Codable>(requestURL: URL, withModel: T.Type,
                                            success: @escaping ((T) -> Void) ,
                                            failure: @escaping ((NetworkError) -> Void)) {
        URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
            if let error = error as NSError?, error.domain == NSURLErrorDomain &&
                error.code == NSURLErrorNotConnectedToInternet {
                DispatchQueue.main.async {// call main thread to handle response
                    failure(NetworkError.noInternetConnection)
                }
                return
            }
            guard let data = data else {
                failure(NetworkError.unexpectedError)
                return
            }
            do {// try to parse the response
                let decoder = JSONDecoder()
                let data = try decoder.decode(withModel.self, from: data)
                print("RESPONSE: \(data)")
                guard let httpURLResponse =  response as? HTTPURLResponse else {
                    failure(NetworkError.badRequest)
                    return
                }
                if httpURLResponse.statusCode == 200 {
                    DispatchQueue.main.async {// call main thread to handle response
                        success(data)
                    }
                } else {
                    DispatchQueue.main.async {// call main thread to handle response
                        failure(NetworkError.noDataFound)
                    }
                }
            } catch _ {// This is where we catch the parsing error
                DispatchQueue.main.async {
                    failure(NetworkError.parsingError)
                }
            }
        }.resume()
    }
}
