//  ARProviderImpliment + Files.swift
//  Created by Dmitry Samartcev on 22.10.2021.

#if canImport(Combine) && canImport(ARKit) && canImport(RealityKit)
import Foundation
import Combine
import RealityKit

/// - Work with files.
@available (iOS 14.0, *)
extension ARProviderImpliment {
    
    public func findURLForRelalityFile(filename: String, fileExtension: String, sceneName:String) -> AnyPublisher <URL?, Error>{
        
        typealias URLResult = Result<URL?, Error>
        
        guard let realityFileURL = Bundle.main.url(forResource: filename, withExtension: fileExtension) else {
            return URLResult.failure(ARProviderError.errorFindingURLforFile(fileName: filename, fileExtension: fileExtension)).publisher.eraseToAnyPublisher()
        }
        // Append the scene name to the URL to point to a single scene within file.
        let realityFileSceneURL = realityFileURL.appendingPathComponent(sceneName, isDirectory: false)
        return URLResult.success(realityFileSceneURL).publisher.eraseToAnyPublisher()
    }
    
    public func createUrlForUSDZFile(filename: String, fileExtension: String) -> AnyPublisher<(filename: String, url: URL?), Error> {
        
        typealias URLResult = Result<(filename: String, url: URL?), Error>
        
        guard let fileUrl = Bundle.main.url(forResource: filename, withExtension: fileExtension)
        else {
            return URLResult.failure(ARProviderError.errorFindingURLforFile(fileName: filename, fileExtension: fileExtension)).publisher.eraseToAnyPublisher()
        }
        return URLResult.success((filename, fileUrl)).publisher.eraseToAnyPublisher()
    }
    
    /// Asynchronously loads AnchorEntity (Entity & HasAnchoring) at specified url.
    ///
    /// Method is used in particular for loading '*.reality*' files.
    /// - Parameters:
    ///   - url: URL to place file (specified as optional, but if it is absent, a url error will be returned).
    ///   - name: Unique name of entity for unique identification in a multiuser session (optional).
    /// - Returns: AnchorEntity (optional) or error.
    private func loadAnchorEntity(from url: URL?, with name: String?) -> AnyPublisher<AnchorEntity?, Error>{
        let future: Deferred<Future<AnchorEntity?, Error>> = Deferred{Future<AnchorEntity?, Error>{ [weak self] promise in
            
            guard let url = url else {promise(.failure(ARProviderError.noValidURLToLoadEntity)); return}
            
            var loadRequest: LoadRequest<AnchorEntity>
            if let name = name {
                loadRequest = Entity.loadAnchorAsync(contentsOf: url, withName: name)
            } else {
                loadRequest = Entity.loadAnchorAsync(contentsOf: url)
            }
            
            var cancellable: AnyCancellable?
            cancellable = loadRequest.sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case let .failure(error):
                    promise(.failure(error))
                }
            }, receiveValue: { entity in
                promise(.success(entity))
            })
            
            // Store cancellable.
            if self?.loadingStreams != nil {
                cancellable?.store(in: &self!.loadingStreams)
            }
        }}
        return future.eraseToAnyPublisher()
    }
    
    public func loadRealityFileAsync (filename: String, fileExtension: String, sceneName: String) -> AnyPublisher<(Entity & HasAnchoring)?, Error> {
        
        typealias LoadResult = Result<(Entity & HasAnchoring)?, Error>
        
        let findURLForRelalityFileFuture: AnyPublisher<URL?, Error> = Deferred{Future<URL?,Error>{[weak self] promise in
            var cancellable: AnyCancellable?
            cancellable = self?.findURLForRelalityFile(filename: filename, fileExtension: fileExtension, sceneName: sceneName)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        break
                    case let .failure(error):
                        promise(.failure(error))
                    }
                }, receiveValue: { optionalUrl in
                    promise(.success(optionalUrl))
                })
            // Store cancellable.
            if self?.loadingStreams != nil {
                cancellable?.store(in: &self!.loadingStreams)
            }
        }}.eraseToAnyPublisher()
        
        return findURLForRelalityFileFuture
            .flatMap { url in
                return self.loadAnchorEntity(from: url, with: "\(filename)_\(UUID())")
            }
            .map{$0}
            .eraseToAnyPublisher()
    }
    
    public func loadModelEntityAsync(filename: String, fileURL: URL?) -> AnyPublisher<ModelEntity?, Error> {
        
        let future: Deferred<Future<ModelEntity?, Error>> = Deferred{Future<ModelEntity?, Error>{[weak self] promise in
            guard let fileURL = fileURL else {
                promise(.failure(ARProviderError.noValidURLToLoadEntity)); return
            }
            
            var loadRequest: LoadRequest<ModelEntity>
            loadRequest = Entity.loadModelAsync(contentsOf: fileURL, withName: filename)
            
            var cancellable: AnyCancellable?
            cancellable = loadRequest.sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case let .failure(error):
                    promise(.failure(error))
                }
            }, receiveValue: { modelEnity in
                promise(.success(modelEnity))
            })
            
            // Store cancellable.
            if self?.loadingStreams != nil {
                cancellable?.store(in: &self!.loadingStreams)
            }
        }}
        return future.eraseToAnyPublisher()
    }
}
#endif
