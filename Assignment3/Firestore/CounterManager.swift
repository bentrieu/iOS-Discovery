//
//  CounterManager.swift
//  Assignment3
//
//  Created by An Vu Gia on 18/09/2023.
//
import Foundation
import Firebase
import FirebaseFirestore

class CounterManager {
    static let instance = CounterManager() // Singleton instance
    
    private let db = Firestore.firestore()
    private let countersCollectionRef = Firestore.firestore().collection("counters")
    
    private init() {} // Private initializer for the singleton
    
    func getAndIncrementCounter(counterName: String, completion: @escaping (Result<Int, Error>) -> Void) {
        let counterRef: DocumentReference?
        
        switch counterName {
        case "album":
            counterRef = countersCollectionRef.document("album")
        default:
            counterRef = nil
        }
        
        if let counterRef = counterRef {
            // Use a Firestore transaction to atomically increment the counter
            db.runTransaction { (transaction, errorPointer) -> Any? in
                do {
                    let counterDoc = try transaction.getDocument(counterRef)
                    guard var currentValue = counterDoc.data()?["value"] as? Int else {
                        let error = NSError(domain: "Firestore", code: 1, userInfo: [NSLocalizedDescriptionKey: "Counter document has no 'value' field"])
                        errorPointer?.pointee = error
                        return nil
                    }
                    
                    // Increment the counter and set it back in Firestore
                    currentValue += 1
                    transaction.updateData(["value": currentValue], forDocument: counterRef)
                    
                    return currentValue
                } catch let error as NSError {
                    errorPointer?.pointee = error
                    return nil
                }
            } completion: { (result, error) in
                if let error = error {
                    completion(.failure(error))
                } else if let value = result as? Int {
                    completion(.success(value))
                }
            }
        } else {
            let error = NSError(domain: "Firestore", code: 1, userInfo: [NSLocalizedDescriptionKey: "Invalid counter name"])
            completion(.failure(error))
        }
    }
}
