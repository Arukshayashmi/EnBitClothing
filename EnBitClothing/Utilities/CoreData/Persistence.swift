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
        let container = NSPersistentContainer(name: "EnbitClothings")
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
        
        userData.firstName = user.firstName
        userData.lastName = user.lastName
        userData.email = user.email
        userData.avatarUrl = user.profilePic?.url
        userData.emailVerifyAt = user.emailVerifyAt
        userData.phone = user.phone
        
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
            
            userData.firstName = user.firstName
            userData.lastName = user.lastName
            userData.avatarUrl = user.profilePic?.url
            userData.phone = user.phone
            userData.emailVerifyAt = user.emailVerifyAt

           // userData.email = user.email
            
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
}


extension PersistenceController {
    @discardableResult
    func saveCardData(with card: Card) -> CardDetails? {
        let context = PersistenceController.shared.mainContext
        
        let entity = CardDetails.entity()
        let cardData = CardDetails(entity: entity, insertInto: context)
        
        cardData.cardNumber = card.cardNumber
        cardData.expMonth = card.expMonth
        cardData.cvv = card.cvv
        
        do {
            try context.save()
            return cardData
        } catch let error {
            print("Error: \(error)")
        }
        
        return nil
    }
    
    func loadCardData() -> [CardDetails]? {
        let context = PersistenceController.shared.mainContext
        let fetchRequest: NSFetchRequest<CardDetails> = CardDetails.fetchRequest()
        
        do {
            let results = try context.fetch(fetchRequest)
            return results
        } catch {
            debugPrint(error)
        }
        
        return nil
    }
}
