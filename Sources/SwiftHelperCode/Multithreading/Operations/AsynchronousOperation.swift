//  AsynchronousOperation.swift
//  Created by Dmitry Samartcev on 20.11.2020.

#if canImport(UIKit)
import Foundation

/// Represents entity of an asynchronous operation
///
/// Allows running long running tasks without having to block the calling thread until execution is complete
open class AsynchronousOperation : Operation {
    
    private let lockQueue  = DispatchQueue(label: "tech.vegiwoo.asyncOperationLockQueue")
    
    public override var isAsynchronous: Bool {
        return true
    }
    
    private var _isExecuting: Bool = false
    public override var isExecuting: Bool {
        get { lockQueue.sync { _isExecuting } }
        set {
            willChangeValue(forKey: "isExecuting")
            lockQueue.sync { _isExecuting = newValue }
            didChangeValue(forKey: "isExecuting")
        }
    }
    
    private var _isFinished: Bool = false
    public override var isFinished: Bool {
        get { lockQueue.sync { _isFinished } }
        set {
            willChangeValue(forKey: "isFinished")
            lockQueue.sync { _isFinished = newValue }
            didChangeValue(forKey: "isFinished")
        }
    }
    
    public override func start() {
        self.isFinished  = false
        self.isExecuting = true
        main()
    }
    
    public override func main() {
        guard !isCancelled else { return }
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(1)) {
            print("asyncOperation perform")
            self.finish()
        }
    }
     
    func finish() {
        self.isExecuting = false
        self.isFinished = true
    }
}
#endif
