//
//  CoreData + Extensions.swift
//  DevelopWayApp
//
//  Created by Diana Sargsyan on 16.10.21.
//

import Foundation
import CoreData

extension CoreDataManager {
    
    func saveCurrentUser(_ model: RegisteredInfo) {

        let id = Int16(model.id)
        let name = model.name
        let surname = model.surname
        let birthday = model.birthday
        let email = model.email
        let createdDate = model.createdDate
        let password = model.password
        let imageURL = model.imageUrl
        
        let managedContext = getManagedObjectContext()

        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserEntity")
        let predicate = NSPredicate(format: "email = %@", email)

        request.predicate = predicate
        do{
            let users = try managedContext.fetch(request) as! [UserEntity]

            if users.count == 0 {
                let entity = NSEntityDescription.entity(forEntityName: "UserEntity", in: managedContext)!
                let user = NSManagedObject(entity: entity, insertInto: managedContext) as! UserEntity
                
                user.id = id
                user.name = name
                user.surname = surname
                user.birthday = birthday
                user.email = email
                user.createdDate = createdDate
                user.password = password
                user.imageURL = imageURL

            }else{
                let user = users.first
                
                user?.id = id
                user?.name = name
                user?.surname = surname
                user?.birthday = birthday
                user?.email = email
                user?.createdDate = createdDate
                user?.password = password
                user?.imageURL = imageURL
                
            }
        }
        catch let error as NSError {
            print ("CoreData / Save UserEntity Error / \(error)")
        }
        save()
    }


    
    func deleteCurrentUser() {
        let managedContext = getManagedObjectContext()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserEntity")
        fetchRequest.returnsObjectsAsFaults = false
        
//        if let userId = getCurrentUser()?.id {
//            let predicate = NSPredicate(format: "id = %d", userId)
//            fetchRequest.predicate = predicate
//        }
        
        do
            {
                let results = try managedContext.fetch(fetchRequest)
                for managedObject in results
                {
                    let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                    managedContext.delete(managedObjectData)
                }
            } catch let error as NSError {
                print("Detele all data in SpecialistEntity error : \(error) \(error.userInfo)")
            }
        save()
    }
    
    func fetchUserByEmail(_ email: String) -> UserEntity? {
        
        let managedContext = getManagedObjectContext()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserEntity")
        let predicate = NSPredicate(format: "email = %@", email)
        
        request.predicate = predicate
        do{
            let users = try managedContext.fetch(request) as! [UserEntity]
            return users.first
        }
        catch let error as NSError {
            print("UserEntity fetch by email, error: \(error)")
            return nil
        }
    }
    
    func getCurrentUsers() -> [UserEntity]?  {
        let managedContext = getManagedObjectContext()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserEntity")
        
        do{
            let users = try managedContext.fetch(request) as? [UserEntity]
            return users
        }
        
        catch let error as NSError {
            print("Not found user for given id \(error), \(error.userInfo)")
            return nil
        }
    }
}
