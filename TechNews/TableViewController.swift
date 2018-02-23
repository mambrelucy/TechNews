//
//  TableViewController.swift
//  TechNews
//
//  Created by Lucy Mambre on 21/01/2018.
//  Copyright © 2018 Lucy Mambre. All rights reserved.
//

import UIKit
import WebKit

class TableViewController: UITableViewController {

    var articles: [Article]? = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchArticlesData()
    }
    
    func fetchArticlesData() {
        let urlRequest = URLRequest(url: URL(string: "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=d647012a9673443c8cc54f067a234cc6")!)
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in

            if (error != nil) {
                return
            }
            self.articles = [Article]()
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                if let articlesFromJson = json["articles"] as? [[String : AnyObject]] {
                    for articleFromJson in articlesFromJson {
                        if let title = articleFromJson["title"] as? String, let author = articleFromJson["author"] as? String, let desc = articleFromJson["description"] as? String, let url = articleFromJson["url"] as? String, let urlToImage = articleFromJson["urlToImage"] as? String {
                            
                            let article = Article(title: title, desc: desc, author: author, url: url, imageUrl: urlToImage)
                            self.articles?.append(article!)
                        }
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            } catch let error {
                print(error)
            }
        }
        task.resume()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ArticleCell

        cell.myTitle.text = self.articles?[indexPath.item].title
        cell.myDesc.text = self.articles?[indexPath.item].desc
        cell.myAuthor.text = self.articles?[indexPath.item].author
        cell.myImage.downloadImage(from: (self.articles?[indexPath.item].imageUrl!)!)
        
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 163
    }
    
    /*
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let webVC =  UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "details") as! WebviewViewController
        let webVC = UIStoryboardSegue.init(identifier: String?, source: <#T##UIViewController#>, destination: <#T##UIViewController#>)
        webVC.url = self.articles?[indexPath.item].url
        self.present(webVC, animated: true, completion: nil)
    } */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "details_cell") {
            let detailsView = segue.destination as! WebviewViewController
            
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let selected_article_url = self.articles?[indexPath.item].url
                detailsView.url = selected_article_url
            }

        }
    }
    
}

extension UIImageView {
    func downloadImage(from url: String) {
        let urlRequest = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if (error != nil) {
                return
            }
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }
        task.resume()
    }
}
