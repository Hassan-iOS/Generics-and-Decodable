//
//  FirstViewController.swift
//  Generics-Decodable-Demo
//
//  Created by Hassan Mostafa on 7/27/19.
//  Copyright © 2019 Minds. All rights reserved.
//

import UIKit

class PostsViewController: UIViewController {

    @IBOutlet weak var postsTableView: UITableView!
    let postsUrl = "https://jsonplaceholder.typicode.com/comments"
    var posts = [CommentsModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postsTableView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.global(qos: .background).async {
//            PostsAPIService.instance.getPosts(url: self.postsUrl) { (posts, error) in
//                if let myError = error {
//                    // alert in main queue
//                    print(myError)
//                } else {
//                    guard let posts = posts else { return }
//                    self.posts = posts
//                    DispatchQueue.main.async {
//                          self.postsTableView.reloadData()
//                    }
//                }
//            }
            PostsAPIService.instance.getData(url: self.postsUrl, completion: { (comments: [CommentsModel]?, error) in
                if let error = error{
                    print(error)
                } else {
                    guard let comments = comments else { return }
                                        self.posts = comments
                                        DispatchQueue.main.async {
                                              self.postsTableView.reloadData()
                                        }
                }
            })
        }
    }
}

extension PostsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostsTableViewCell", for: indexPath) as? PostsTableViewCell else {
            return UITableViewCell()
        }
        cell.postLabel?.text = posts[indexPath.row].body
        return cell
    }
    
    
}
