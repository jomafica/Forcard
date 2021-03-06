//
//  API_CALL.swift
//  Forcard
//
//  Created by Daniel Pereira on 14/11/2020.
//

import Foundation

class NewsFeed: ObservableObject, RandomAccessCollection {
    typealias Element = NewsListItem

    @Published var refresh: Bool = false {
        didSet {
            if oldValue == false && refresh == true {
                loadStatus = LoadStatus.ready(nextPage: 1)
                newsListItems = []
                self.loadMoreArticles()
            }
        }
    }

    @Published var selectedItem = NewsListItem(title: "",description: "", url: "", img: "", date: "")
    @Published var newsListItems = [NewsListItem]()
    @Published var isLoading: Bool = false

    var startIndex: Int { newsListItems.startIndex }
    var endIndex: Int { newsListItems.endIndex }
    var loadStatus = LoadStatus.ready(nextPage: 1)
        
    var urlBase = "http://192.168.1.2:5000/api/v1/resource/"
    
    init() {
        loadMoreArticles()
    }
        
    subscript(position: Int) -> NewsListItem {
        return newsListItems[position]
    }
            
    func loadMoreArticles(currentItem: NewsListItem? = nil) {
        
        if !shouldLoadMoreData(currentItem: currentItem) {
            print("do not load more data")
            return
        }
        guard case let .ready(page) = loadStatus else {
            return
        }
        loadStatus = .loading(page: page)
        let urlString = "\(urlBase)\(page)"
        
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url, completionHandler: parseArticlesFromResponse(data:response:error:))
        task.resume()
    }
    
    func shouldLoadMoreData(currentItem: NewsListItem? = nil) -> Bool {
        guard let currentItem = currentItem else {
            return true
        }
        
        for n in (newsListItems.count - 4)...(newsListItems.count-1) {
            if n >= 0 && currentItem.id == newsListItems[n].id {
                print("it reaches the last 4")
                self.isLoading.toggle()
                return true
            }
        }
        self.isLoading.toggle()
        return false
    }
    
    func parseArticlesFromResponse(data: Data?, response: URLResponse?, error: Error?) {
        guard error == nil else {
            print("Error: \(error!)")
            loadStatus = .parseError
            return
        }
        guard let data = data else {
            print("No data found")
            loadStatus = .parseError
            return
        }
        
        let newArticles = parseArticlesFromData(data: data)
        DispatchQueue.main.async {
            print("im quering agaiin")
            self.newsListItems.append(contentsOf: newArticles)
            self.refresh = false
            if newArticles.count == 0 {
                self.loadStatus = .done
            } else {
                guard case let .loading(page) = self.loadStatus else {
                    fatalError("loadSatus is in a bad state")
                }
                self.loadStatus = .ready(nextPage: page + 1)
            }
        }
    }
    
    func parseArticlesFromData(data: Data) -> [NewsListItem] {
        var response: NewsApiResponse
        do {
            response = try JSONDecoder().decode(NewsApiResponse.self, from: data)
        } catch {
            print("Error parsing the JSON: \(error)")
            return []
        }
        if response.status != "ok" {
            print("Status is not ok: \(response.status)")
            return []
        }
        return response.articles
    }
    enum LoadStatus {
        case ready (nextPage: Int)
        case loading (page: Int)
        case parseError
        case done
    }
}

class NewsApiResponse: Codable {
    var status: String
    var articles: [NewsListItem]

}

struct NewsListItem: Identifiable, Codable, Hashable {
    var id = UUID()

    var title: String
    var description: String?
    var url: String
    var img: String
    var date: String
    
    enum CodingKeys: String, CodingKey {
        case title, description, url, img, date

        }
}
