//
//  ViewController.swift
//  laborator2
//
//  Created by Adrian Popovici on 12/03/2019.
//  Copyright © 2019 laborator. All rights reserved.
//

import UIKit

class PostsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var postsTableView: UITableView!

    var models: [PostModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup the url
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!

        // Setup the URL Request as a MutableURLRequest. We can modify the parameters after the fact (e.g. httpMethod)
        let request = NSMutableURLRequest(url: url,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        // Setting up the parameters here:
        request.httpMethod = "GET"
//        request.allHTTPHeaderFields = ["headerField": "Value"]

        // getting the shared URLSession
        let session = URLSession.shared

        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            if let error = error {
                print("Error occured: \(error.localizedDescription)")
            } else {
                let httpResponse = response as! HTTPURLResponse
                switch httpResponse.statusCode {
                case 200:
                    do {
                        guard let data = data else { return }
                        guard let values = try JSONSerialization.jsonObject(with: data, options: []) as? NSArray else { return }
                        let stringValues = values.map { ($0 as! String) }
                        // NOT WORKING
                        let decodedValues = try stringValues.map { try JSONDecoder().decode(PostModel.self, from: $0.data(using: .utf8)!) }
                        self.models = decodedValues
                    } catch {
                        print("Serialization error" )
                    }
                default:
                    print("Received status code: \(httpResponse.statusCode)")
                }
            }
        }

        dataTask.resume()

    }

    func updateTableView() {
        DispatchQueue.main.async {
            self.postsTableView.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostsTableViewCell") as! PostsTableViewCell
        cell.configure(withModel: models[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

}

