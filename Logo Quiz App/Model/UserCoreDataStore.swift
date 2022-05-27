//
//  UserCoreDataStore.swift
//  Logo Quiz App
//
//  Created by Mohammad Alfarisi on 05/05/22.
//

import Foundation
import CoreData

class UserCoreDataStore
{
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext)
    {
        self.context = context
    }

    func fetchUser() -> ManagedUser?
    {
        do
        {
            let user = try context.fetch(ManagedUser.fetchRequest())
            
            
            
            if let savedUser = user.first
            {
                // previous version doesn't have this data
                if (savedUser.hint == nil)
                    { savedUser.hint = Dictionary() }
                return savedUser
            }
            
            let newUser = ManagedUser(context: context)
            
            newUser.score = Int32(0)
            newUser.answeredQuestions = Set()
            newUser.hint = Dictionary()
            
            return newUser
        }
        catch
        {
            print(error)
        }
        
        return nil
    }
    
    func addUserScore(amount: Int)
    {
        guard let user = fetchUser() else { return }
        user.score = user.score + Int32(amount)
        saveContext()
    }
    
    func addAnsweredQuestion(_ question: String)
    {
        guard let user = fetchUser() else { return }
        user.answeredQuestions?.insert(question)
        saveContext()
    }
    
    func addHint(_ value: StringHint)
    {
        guard let user = fetchUser() else { return }
        user.hint?.updateValue(String(value.hint), forKey: String(value.secretString))
        saveContext()
    }
    
    // MARK: - Core Data Saving support

    func saveContext ()
    {
        if context.hasChanges
        {
            do {  try context.save() }
            catch
            {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
