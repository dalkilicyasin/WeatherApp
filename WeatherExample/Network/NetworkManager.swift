//
//
//
import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import UIKit


public class NetworkManager {
    
    public static var networkConnectionEnabled = true
    private static let TIMEOUT_INTERVAL: TimeInterval = 300
    public static var BASEURL = "http://dataservice.accuweather.com"
    
    public static func sendRequest<T: Mappable>(url: String,endPoint: ServiceEndPoint, method: HTTPMethod = .post, requestModel: Mappable, indicatorEnabled: Bool = true,
                                         completion: @escaping(T) -> ()) {
        
        if !networkConnectionEnabled {
            return
        }
        
        guard let request = prepareRequest(url : url,endPoint: endPoint, method: method, requestModel: requestModel),
            let viewController = UIApplication.getTopViewController()
            else { return }
        
        
        if indicatorEnabled {
            viewController.showIndicator(tag: String(describing: request.self))
        }
        
        Alamofire.request(request).responseObject { (response: DataResponse<T>) in
            if indicatorEnabled {
                viewController.hideIndicator(tag: String(describing: request.self))
            }
            
            switch response.result {
            case .success(let responseModel):
                completion(responseModel)
                
            case .failure(let error as NSError):
                viewController.errorPopup(title: "Warning", message: "An error occurred when requesting", cancelButtonTitle: "OK")
                debugPrint(error.description)
            }
        }
    }
    
    public static func sendRequestInt(endPoint: ServiceEndPoint, method: HTTPMethod = .get, requestModel: Mappable, indicatorEnabled: Bool = true,
                                            completion: @escaping(Int) -> ()) {
           
           if !networkConnectionEnabled {
               return
           }
           
        guard let request = prepareRequest(url : NetworkManager.BASEURL ,endPoint: endPoint, method: method, requestModel: requestModel),
               let viewController = UIApplication.getTopViewController()
               else { return }
           
           if indicatorEnabled {
            viewController.showIndicator(tag: String(describing: request.self))
           }
           
           Alamofire.request(request).responseJSON {(response) in
               if response.response?.statusCode == 200 {
                   print ("pass")
               }else{
                   print ("fail")
               }
            completion((response.response?.statusCode)!)

           }
       }
      
    public static func sendGetRequestInt(url:String, endPoint: ServiceEndPoint, method: HTTPMethod, parameters: String, indicatorEnabled: Bool = true,
                                                completion: @escaping(Int) -> ()) {
            
            if !networkConnectionEnabled {
                return
            }
            
            var urlPath = url + endPoint.rawValue
            if !parameters.elementsEqual("") {
                urlPath.append(parameters)
            }
            urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            
            var requestModel = URLRequest(url: URL(string: urlPath)!)
            requestModel.timeoutInterval = TIMEOUT_INTERVAL
            requestModel.setValue("application/json", forHTTPHeaderField: "Content-Type")
            requestModel.setValue("bearer \(baseData.getTokenResponse?.access_token ?? "")", forHTTPHeaderField: "Authorization")
            requestModel.httpMethod = method.rawValue

            
            let request = requestModel
            let viewController = UIApplication.getTopViewController()
            
            
            if indicatorEnabled {
                viewController!.showIndicator(tag: String(describing: request.self))
            }
        
              Alamofire.request(request).responseJSON {(response) in
                
                if indicatorEnabled {
                    viewController?.hideIndicator(tag: String(describing: request.self))
                }
                    if response.response?.statusCode == 200 {
                        print ("pass")
                    }else{
                        print ("fail")
                    }
                completion((response.value ?? 0) as! Int)

                }
        }
    
    public static func sendRequestArray<T: Mappable>(url: String,endPoint: ServiceEndPoint, method: HTTPMethod = .post, requestModel: Mappable, indicatorEnabled: Bool = true,
                                         completion: @escaping([T]) -> ()) {
        
        if !networkConnectionEnabled {
            return
        }
        
        guard let request = prepareRequest(url : url,endPoint: endPoint, method: method, requestModel: requestModel),
            let viewController = UIApplication.getTopViewController()
            else { return }
        
        
        if indicatorEnabled {
            viewController.showIndicator(tag: String(describing: request.self))
        }
        
        Alamofire.request(request).responseArray { (response: DataResponse<[T]>) in
            if indicatorEnabled {
                viewController.hideIndicator(tag: String(describing: request.self))
            }
            
            switch response.result {
            case .success(let responseModel):
                completion(responseModel)
                
            case .failure(let error as NSError):
                viewController.errorPopup(title: "Warning", message: "An error occurred when requesting", cancelButtonTitle: "OK")
                debugPrint(error.description)
            }
        }
    }
    
    public static func sendRequest<T: Mappable>(url : String,endPoint: ServiceEndPoint, method: HTTPMethod = .post, parameters: Parameters? = nil, indicatorEnabled: Bool = true,
                                         completion: @escaping(T) -> ()) {
        
        if !networkConnectionEnabled {
            return
        }
        
        guard let request = prepareRequest(url : url,endPoint: endPoint, method: method, parameters: parameters),
            let viewController = UIApplication.getTopViewController()
            else { return }
        
        if indicatorEnabled {
            viewController.showIndicator(tag: String(describing: request.self))
        }
        
        Alamofire.request(request).responseObject { (response: DataResponse<T>) in
            if indicatorEnabled {
                viewController.hideIndicator(tag: String(describing: request.self))
            }
            
            switch response.result {
            case .success(let responseModel):
                completion(responseModel)
                
            case .failure(let error as NSError):
                viewController.errorPopup(title: "Warning", message: "An error occurred when requesting", cancelButtonTitle: "OK")
                debugPrint(error.description)
            }
        }
    }
    
    private static func prepareRequest(url : String,endPoint: ServiceEndPoint, method: HTTPMethod, requestModel: Mappable) -> URLRequest? {
        let urlPath = url + endPoint.rawValue
        
        var request = URLRequest(url: URL(string: urlPath)!)
        request.timeoutInterval = TIMEOUT_INTERVAL
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("bearer \(baseData.getTokenResponse?.access_token ?? "")", forHTTPHeaderField: "Authorization")
        request.httpMethod = method.rawValue
        request.httpBody = try? JSONSerialization.data(withJSONObject: requestModel.toJSON())
        request.setValue(String(userDefaultsData.getLanguageId()), forHTTPHeaderField: "Language")
        
        return request
    }
    
    private static func prepareRequest(url: String,endPoint: ServiceEndPoint, method: HTTPMethod, parameters: Parameters? = nil) -> URLRequest? {
        let urlPath = url + endPoint.rawValue
        
        var request = URLRequest(url: URL(string: urlPath)!)
        request.timeoutInterval = TIMEOUT_INTERVAL
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = method.rawValue
        
        if parameters != nil {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters!)
        }
        
        return request
    }
    
    public static func sendGetRequest<T: Mappable>(url:String,endPoint: ServiceEndPoint, method: HTTPMethod, parameters: String, indicatorEnabled: Bool = true,
                                                completion: @escaping(T) -> ()) {
            
            if !networkConnectionEnabled {
                return
            }
            
            var urlPath = url + endPoint.rawValue
            if !parameters.elementsEqual("") {
                urlPath.append(parameters)
            }
            urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            
            var requestModel = URLRequest(url: URL(string: urlPath)!)
            requestModel.timeoutInterval = TIMEOUT_INTERVAL
            requestModel.setValue("application/json", forHTTPHeaderField: "Content-Type")
            requestModel.setValue("bearer \(baseData.getTokenResponse?.access_token ?? "")", forHTTPHeaderField: "Authorization")
            requestModel.httpMethod = method.rawValue

            
            let request = requestModel
            let viewController = UIApplication.getTopViewController()
            
            
            if indicatorEnabled {
                viewController!.showIndicator(tag: String(describing: request.self))
            }
        
            Alamofire.request(request).responseObject { (response: DataResponse<T>) in
                if indicatorEnabled {
                    viewController!.hideIndicator(tag: String(describing: request.self))
                }

                switch response.result {
                case .success(let responseModel):
                    completion(responseModel)

                case .failure(let error as NSError):
                    viewController!.errorPopup(title: "Warning", message: "An error occurred when requesting", cancelButtonTitle: "OK")
                    debugPrint(error.description)
                }
            }
        
        }
    
    public static func sendGetRequestTextResponse(url:String, endPoint: ServiceEndPoint, method: HTTPMethod, parameters: String, indicatorEnabled: Bool = true,
                                                completion: @escaping(String) -> ()) {
            
            if !networkConnectionEnabled {
                return
            }
            
            var urlPath = url + endPoint.rawValue
            if !parameters.elementsEqual("") {
                urlPath.append(parameters)
            }
            urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            
            var requestModel = URLRequest(url: URL(string: urlPath)!)
            requestModel.timeoutInterval = TIMEOUT_INTERVAL
            requestModel.setValue("application/json", forHTTPHeaderField: "Content-Type")
            requestModel.setValue("bearer \(baseData.getTokenResponse?.access_token ?? "")", forHTTPHeaderField: "Authorization")
            requestModel.httpMethod = method.rawValue

            
            let request = requestModel
            let viewController = UIApplication.getTopViewController()
            
            
            if indicatorEnabled {
                viewController!.showIndicator(tag: String(describing: request.self))
            }
        
              Alamofire.request(request).responseJSON {(response) in
                
                if indicatorEnabled {
                    viewController?.hideIndicator(tag: String(describing: request.self))
                }
                  
                let str = String(decoding: response.data!, as: UTF8.self)
                  
                  completion((str) )

                }
        }
    
    public static func sendGetRequestArray<T: Mappable>(url:String,endPoint: ServiceEndPoint, method: HTTPMethod, parameters: String, indicatorEnabled: Bool = true,
                                                completion: @escaping([T]) -> ()) {
            
            if !networkConnectionEnabled {
                return
            }
            
            var urlPath = url + endPoint.rawValue
            if !parameters.elementsEqual("") {
                urlPath.append(parameters)
            }
            urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            var requestModel = URLRequest(url: URL(string: urlPath)!)
            requestModel.timeoutInterval = TIMEOUT_INTERVAL
            requestModel.setValue("application/json", forHTTPHeaderField: "Content-Type")
           // requestModel.setValue("bearer \(baseData.getTokenResponse?.access_token ?? "")", forHTTPHeaderField: "Authorization")
            requestModel.httpMethod = method.rawValue
        requestModel.setValue("*/*", forHTTPHeaderField: "Accept")
        requestModel.setValue("gzip", forHTTPHeaderField: "Accept-Encoding")
        requestModel.setValue("en-US", forHTTPHeaderField: "Accept-Language")
            
            let request = requestModel
            let viewController = UIApplication.getTopViewController()
            
            
            if indicatorEnabled {
                viewController!.showIndicator(tag: String(describing: request.self))
            }
        
        Alamofire.request(request).responseArray { (response: DataResponse<[T]>) in
            if indicatorEnabled {
                viewController!.hideIndicator(tag: String(describing: request.self))
            }
            
            switch response.result {
            case .success(let responseModel):
                completion(responseModel)
                
            case .failure(let error as NSError):
                viewController!.errorPopup(title: "Warning", message: "An error occurred when requesting", cancelButtonTitle: "OK")
                debugPrint(error.description)
            }
        }
    }
}
