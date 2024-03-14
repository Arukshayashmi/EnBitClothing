//
//  Persistence.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-13.
//


import CoreData

class PersistenceController {
    static let shared = PersistenceController()
    
    private init() {}
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TxtaPrez")
        container.loadPersistentStores(completionHandler: { _, error in
            _ = error.map { fatalError("Unresolved error \($0)") }
        })
        return container
    }()
    
    var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func backgroundContext() -> NSManagedObjectContext {
        return persistentContainer.newBackgroundContext()
    }
}

extension PersistenceController {
    @discardableResult
    func saveUserData(with user: User) -> LocalUserData? {
        let context = PersistenceController.shared.mainContext
        
        let entity = LocalUserData.entity()
        let userData = LocalUserData(entity: entity, insertInto: context)
        
        userData.uuid = user.uuid
        userData.firstName = user.firstName
        userData.lastName = user.lastName
        //userData.bio = user.bio
        userData.email = user.email
        userData.avatarUrl = user.avatarUrl
        userData.accessToken = user.accessToken
        userData.emailVerifiedAt = user.emailVerifiedAt
        userData.phone = user.phone
        userData.isProfileCompleted = user.isProfileCompleted ?? false

        
        do {
            try context.save()
            return userData
        } catch let error {
            print("Error: \(error)")
        }
        
        return nil
    }
    
    func loadUserData() -> LocalUserData? {
        let context = PersistenceController.shared.mainContext
        let fetchRequest: NSFetchRequest<LocalUserData> = LocalUserData.fetchRequest()
        
        do {
            let result = try context.fetch(fetchRequest).first
            return result
        }
        catch {
            debugPrint(error)
        }
        
        return nil
    }
    
    func updateUserData(with user: User) {
        let context = PersistenceController.shared.mainContext
        let fetchRequest: NSFetchRequest<LocalUserData> = LocalUserData.fetchRequest()
        
        do {
            guard let userData = try context.fetch(fetchRequest).first else { return }
            
            userData.uuid = user.uuid
            userData.firstName = user.firstName
            userData.lastName = user.lastName
            userData.avatarUrl = user.avatarUrl
            userData.phone = user.phone
            userData.emailVerifiedAt = user.emailVerifiedAt
            userData.isProfileCompleted = user.isProfileCompleted ?? false

           // userData.email = user.email
           // userData.accessToken = user.accessToken
            
            do {
                try context.save()
            } catch let error {
                print("Error: \(error)")
            }
        } catch let error {
            print("Error: \(error)")
        }
    }
    
    func updateAccessToken(with token: String) {
        let context = PersistenceController.shared.mainContext
        let fetchRequest: NSFetchRequest<LocalUserData> = LocalUserData.fetchRequest()
        
        do {
            guard let userData = try context.fetch(fetchRequest).first else { return }
            
            userData.accessToken = token
            
            do {
                try context.save()
            } catch let error {
                print("Error: \(error)")
            }
        } catch let error {
            print("Error: \(error)")
        }
    }
    
    func deleteUserData() {
        let context = PersistenceController.shared.mainContext
        let fetchRequest: NSFetchRequest<LocalUserData> = LocalUserData.fetchRequest()
        
        do {
            let userData = try context.fetch(fetchRequest)
            userData.forEach{ context.delete($0) }
            
            do {
                try context.save()
            } catch let error {
                print("Error: \(error)")
            }
        } catch let error {
            print("Error: \(error)")
        }
    }
    
    var accessToken: String? {
        return loadUserData()?.accessToken
    }
}
