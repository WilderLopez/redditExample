//
//  CoreDataManager.swift
//  TestingReddit
//
//  Created by Wilder López on 5/16/23.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TestingReddit")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Failed to load persistent stores: \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    private var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    // MARK: - Core Data Operations

    func savePost(with data: Post, completion: @escaping ((Bool) -> Void)) {
        let context = mainContext
        context.perform {
            
            let id = data.id
            let fetchRequest: NSFetchRequest<PostEntity> = PostEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", id)
            
            do {
                let results = try context.fetch(fetchRequest)
                if let _ = results.first {
                    //Update existing post
                    
                }else { // post not found, add new post
                    
                    let post = PostEntity(context: context)
                    post.id = data.id
                    post.title = data.title
                    post.author = data.author
                    post.url = data.url
                    post.thumbnailUrl = data.thumbnailUrl?.absoluteString
                    post.fullImageUrl = data.fullImageUrl?.absoluteString
                    post.subredditNamePrefixed = data.subredditNamePrefixed
                    post.created = Int64(data.created)
                    post.numComments = Int32(data.numComments)
                    post.name = data.name
                    
                    try context.save()
                }
                completion(true)
            } catch {
                print("Failed to save post: \(error)")
                completion(false)
            }
        }
    }
    
    func saveAllPosts(_ posts: [Post], completion: @escaping ((Bool) -> Void)) {
            let context = mainContext
            context.perform { [weak self] in
                
                    for post in posts {
                        self?.savePost(with: post) { isSuccess in
                            completion(isSuccess)
                        }
                    }
                    
                    
            }
        }

    func fetchAllPosts() -> [PostEntity] {
        let fetchRequest: NSFetchRequest<PostEntity> = PostEntity.fetchRequest()
        do {
            let posts = try mainContext.fetch(fetchRequest)
            return posts
        } catch {
            print("Failed to fetch posts: \(error)")
            return []
        }
    }
    
    func fetchAllPosts() -> [Post] {
        let fetchRequest: NSFetchRequest<PostEntity> = PostEntity.fetchRequest()
        do {
            let postsEntities = try mainContext.fetch(fetchRequest)
            let posts = postsEntities.map { $0.toPost() }
            return posts
        } catch {
            print("Failed to fetch posts: \(error)")
            return []
        }
    }

}

extension PostEntity {
    func toPost() -> Post {
        return Post(id: id ?? "",
                    title: title ?? "",
                    author: author ?? "",
                    url: url ?? "",
                    thumbnailUrl: thumbnailUrl.flatMap { URL(string: $0) },
                    fullImageUrl: fullImageUrl.flatMap { URL(string: $0) },
                    subredditNamePrefixed: subredditNamePrefixed ?? "",
                    created: TimeInterval(created),
                    numComments: Int(numComments),
                    name: name)
    }
}

