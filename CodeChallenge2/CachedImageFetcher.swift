//
//  CachedImageFetcher.swift
//  CodeChallenge2
//
//  Created by SamXu on 15/8/17.
//  Copyright © 2017 AnXu. All rights reserved.
//

/*
 
 All API calls are in the background thread
 
 store the image into cache folder
 for example, if the image url is https://image.tmdb.org/t/p/w640/gfJGlDaHuWimErCr5Ql0I8x9QSy.jpg
 then the <URI> will be /t/p/w640/gfJGlDaHuWimErCr5Ql0I8x9QSy.jpg
 and the image will get stored in <cached folder>/<URI>
 */

import UIKit

let cacheImagePath = "CachedImages"

let thumbnailFolderName = "Thumbnail"

class ImageFetcher {
    
    var url: URL
    
    // create and store thumbnail version of an image locally for table or collection view layout
    var fetchThumbnailVersionImage = false
    
    var thumbnailSize = CGSize.zero
    
    // MARK: - Class functions
    static func appCachedImageFolderURL() -> URL? {
        
        let cachesDirectoryPath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
        
        let cachesDirectoryURL = (NSURL(fileURLWithPath: cachesDirectoryPath)) as URL
        
        let result = cachesDirectoryURL.appendingPathComponent(cacheImagePath)
        
        return result
    }
    
    // clean up any cachedImage downlaoded (no in use for this demo)
    static func removeAllCachedImage() {
        
        if let folder = appCachedImageFolderURL() {
            
            let fileManager = FileManager.default
            
            do {
                
                try fileManager.removeItem(at: folder)
                
            } catch {
                
                print("ImageFetcher removeAllCachedImage(): \(error)")
            }
        }
    }
    
    // get the thumnail version of a image URL
    func fetchThumbnailVerionImageWith(_ size: CGSize, completionHandler: @escaping (UIImage?, URL) -> Swift.Void) {
        
        fetchThumbnailVersionImage = true
        
        thumbnailSize = size
        
        fetchImage(completionHandler: completionHandler)
    }
    
    func fetchImage(completionHandler: @escaping (UIImage?, URL) -> Swift.Void) {
        
        // load cached image if any
        let localImageURL = fetchThumbnailVersionImage ? thumbnailURLFor(originalImageURL: url) : url
        
        if let image = cachedImage(forRemoteFileURL: localImageURL) {
            
            completionHandler(image, url)
            
        } else {
            
            // downlaod the image and store it into cache folder
            let fetcher = ObjectFetcher(url: url)
            
            fetcher.fetchWithLocalCache { (data: Data?, _: Error?) in
                
                var image: UIImage?
                
                if let data = data {
                    
                    self.storeImage(imageData: data, url: self.url)
                    
                    image = UIImage(data: data)
                    
                    if self.fetchThumbnailVersionImage {
                        
                        image = image?.resizeImageIntoSize(self.thumbnailSize)
                        
                    }
                }
                
                completionHandler(image, self.url)
            }
        }
    }
    
    // MARK: - Int
    init(imageURL url: URL) {
        
        self.url = url
    }
    
    // MARK: - Public Mehtods
    // load the image from local cache folder
    func cachedImage(forRemoteFileURL url: URL) -> UIImage? {
        
        guard let fileURL = cacheFileURL(forRemoteAPIURL: url) else {
            
            return nil
        }
        
        let image = UIImage(contentsOfFile: fileURL.path)
        
        return image
    }
    
    // MARK: - Private methods
    
    // store the image into cache folder
    private func storeImage(imageData: Data, url: URL) {
        
        if let fileURL = cacheFileURL(forRemoteAPIURL: url) {
            
            do {
                
                try imageData.write(to: fileURL, options: .atomicWrite)
                
                // Also store an thumbnail version of that image if it is required
                if fetchThumbnailVersionImage == true {
                    
                    let thumbnailURL = thumbnailURLFor(originalImageURL: url)
                    
                    let image = UIImage(data: imageData)
                    
                    if let thumbnail = image?.resizeImageIntoSize(thumbnailSize),
                        let fileURL = cacheFileURL(forRemoteAPIURL: thumbnailURL) {
                        
                        try UIImageJPEGRepresentation(thumbnail, 1.0)?.write(to: fileURL, options: .atomicWrite)
                    }
                    
                }
                
            } catch {
                
                print(error)
            }
        }
    }
    
    private func cacheFileURL(forRemoteAPIURL url: URL) -> URL? {
        
        let pathComponents = url.relativePath.components(separatedBy: "/")
        
        guard var fileURL = ImageFetcher.appCachedImageFolderURL() else {
            return nil
        }
        
        for component in pathComponents {
            
            if component.trimmingCharacters(in: .whitespaces) != "" { // ignore empty path
                
                fileURL = fileURL.appendingPathComponent(component)
            }
        }
        
        // create folders if not exists
        createFoldersFor(fileURL: fileURL)
        
        return fileURL
    }
    
    private func createFoldersFor(fileURL: URL) {
        
        let fileManager = FileManager.default
        
        let folder = fileURL.deletingLastPathComponent()
        
        if fileManager.fileExists(atPath: folder.path) == false {
            
            try? fileManager.createDirectory(at: folder, withIntermediateDirectories: true, attributes: nil)
        }
    }
    
    private func thumbnailURLFor(originalImageURL url: URL) -> URL {
        
        let filename = url.lastPathComponent
        
        var thumbnailUrl = url.deletingLastPathComponent()
        
        thumbnailUrl = thumbnailUrl.appendingPathComponent(thumbnailFolderName).appendingPathComponent(filename)
        
        return thumbnailUrl
    }
}

extension UIImage {
    
    func resizeImageIntoSize(_ newSize: CGSize) -> UIImage? {
        
        UIGraphicsBeginImageContext(newSize)
        
        draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
