//
//  StorageManager.swift
//  FurnitureBeta
//
//  Created by admin on 11.06.2024.
//

import UIKit
import FirebaseStorage
import SwiftUI
import PhotosUI

final class StorageManager {
    
    //MARK: Створення синглтону для зручного доступу до методів управління зберіганням
    static let shared = StorageManager()
    private init() { }
    
    //MARK: Посилання на Firebase Storage
    private let storage = Storage.storage().reference()
    
    //MARK: Посилання на папку "images" у Firebase Storage
    private var imagesReference: StorageReference {
        storage.child("images")
    }
    
    //MARK: Генерує посилання на папку користувача у Firebase Storage на основі userId
    private func userReference(userId: String) -> StorageReference {
        storage.child("users").child(userId)
    }
    
    //MARK: Отримує посилання на файл у Firebase Storage за заданим шляхом
    func getPathForImage(path: String) async throws -> StorageReference {
        Storage.storage().reference(withPath: path)
    }
    
    //MARK: Отримує URL для зображення за заданим шляхом у Firebase Storage
    func getUrlForImage(path: String) async throws -> URL {
       try await getPathForImage(path: path).downloadURL()
    }
    
    //MARK: Отримує дані для файлу у Firebase Storage за заданим userId і path
    func getData(userId: String, path: String) async throws -> Data {
      // try await userReference(userId: userId).child(path).data(maxSize: 3 * 1024 * 1024)
        try await storage.child(path).data(maxSize: 3 * 1024 * 1024)
    }
    
    //MARK: Отримує зображення за заданим userId і path
    func getImage(userId: String, path: String) async throws -> UIImage {
        let data = try await getData(userId: userId, path: path)
        
        guard let image = UIImage(data: data) else {
           throw URLError(.badServerResponse)
        }
        
        return image
    }
    
    //MARK: Зберігає дані зображення в Firebase Storage у папці користувача і повертає шлях і ім'я збереженого файлу
    func saveImage(data: Data, userId: String) async throws -> (path: String, name: String) {
        let meta = StorageMetadata()
        meta.contentType = "image/jpeg"
        
        let path = UUID().uuidString + ".jpeg"
        let returnedMetaData = try await userReference(userId: userId).child(path).putDataAsync(data, metadata: meta)
        
        guard let returnedPath = returnedMetaData.path, let returnedName = returnedMetaData.name else {
            throw URLError(.badServerResponse)
        }
        
        return (returnedPath, returnedName)
    }
    
    //MARK: Зберігає зображення в Firebase Storage у папці користувача і повертає шлях і ім'я збереженого файлу
    func saveImage(image: UIImage, userId: String) async throws -> (path: String, name: String) {
        guard let data = image.jpegData(compressionQuality: 1) else {
            throw URLError(.backgroundSessionWasDisconnected)
        }
        return try await saveImage(data: data, userId: userId)
    }
    
    //MARK: Видаляє файл з Firebase Storage за заданим шляхом
    func deleteImage(path: String) async throws {
        try await getPathForImage(path: path).delete()
    }
}
