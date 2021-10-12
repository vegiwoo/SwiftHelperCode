// See Apple LICENSE folder for this sample’s licensing information in project:
// https://developer.apple.com/documentation/arkit/creating_a_collaborative_session?language=occ

import Combine
import MultipeerConnectivity

/// A simple abstraction of the MultipeerConnectivity API as used in this app.
public class MultipeerSession: NSObject {
    private let serviceType: String
    private let myPeerID = MCPeerID(displayName: UIDevice.current.name)
    private var session: MCSession!
    private var serviceAdvertiser: MCNearbyServiceAdvertiser!
    private var serviceBrowser: MCNearbyServiceBrowser!
    
    /// Data received handler.
    private let receivedDataHandler: (Data, MCPeerID) -> Void
    /// Peer joined multiuser session handler.
    private let peerJoinedHandler: (MCPeerID) -> Void
    /// Peer join multiuser session handler.
    private let peerJoinHandler: (MCPeerID) -> Void
    /// Peer disconnect handler from multiuser session.
    private let peerLeftHandler: (MCPeerID) -> Void
    /// New peer discovery handler in multiuser session.
    private let peerDiscoveredHandler: (MCPeerID) -> Bool
    
    /// Publisher that publishes possible errors when working with a multi-user session.
    public let errorPublisher: PassthroughSubject<Bool, Error> = .init()
    
    public init(serviceType: String,
                receivedDataHandler: @escaping (Data, MCPeerID) -> Void,
                peerJoinedHandler: @escaping (MCPeerID) -> Void,
                peerJoinHandler: @escaping (MCPeerID) -> Void,
                peerLeftHandler: @escaping (MCPeerID) -> Void,
                peerDiscoveredHandler: @escaping (MCPeerID) -> Bool) {
        
        self.serviceType = serviceType
        self.receivedDataHandler = receivedDataHandler
        self.peerJoinedHandler = peerJoinedHandler
        self.peerJoinHandler = peerJoinHandler
        self.peerLeftHandler = peerLeftHandler
        self.peerDiscoveredHandler = peerDiscoveredHandler
        
        super.init()
    }
    
    /// Sends data to all peers in a multiuser session.
    /// - Parameters:
    ///   - data: Data to send.
    ///   - reliably: Reliability flag.
    /// - Returns: Operation progress flag or error (as publisher).
    public func sendToAllPeers(_ data: Data, reliably: Bool) -> AnyPublisher<Bool, Error> {
        sendToPeers(data, reliably: reliably, peers: connectedPeers)
    }
    
    /// Sends data to peers in a multiuser session.
    /// - Parameters:
    ///   - data: Data to send.
    ///   - reliably: Reliability flag.
    ///   - peers: An array of peers to send.
    /// - Returns: Operation progress flag or error (as publisher).
    public func sendToPeers(_ data: Data, reliably: Bool, peers: [MCPeerID]) -> AnyPublisher<Bool, Error> {
        guard !peers.isEmpty else {
            let error = MultipeerSessionError.noPeersToSendData
            return Result<Bool, Error>.failure(error).publisher.eraseToAnyPublisher()
        }
        do {
            try session.send(data, toPeers: peers, with: reliably ? .reliable : .unreliable)
            return Result<Bool, Error>.success(true).publisher.eraseToAnyPublisher()
        } catch {
            let mcError = MultipeerSessionError.errorSendingDataToPeers(error.localizedDescription)
            return Result<Bool, Error>.failure(mcError).publisher.eraseToAnyPublisher()
        }
    }
    
    /// List of connected peers to multiuser session.
    public var connectedPeers: [MCPeerID] {
        return session.connectedPeers
    }
    
    /// Creates a multiuser session.
    public func createSession() -> AnyPublisher<Bool, Never> {
        session = MCSession(peer: myPeerID, securityIdentity: nil, encryptionPreference: .required)
        session.delegate = self
        
        serviceAdvertiser = MCNearbyServiceAdvertiser(peer: myPeerID, discoveryInfo: nil, serviceType: serviceType)
        serviceAdvertiser.delegate = self
        serviceAdvertiser.startAdvertisingPeer()
        
        serviceBrowser = MCNearbyServiceBrowser(peer: myPeerID, serviceType: serviceType)
        serviceBrowser.delegate = self
        serviceBrowser.startBrowsingForPeers()
        
        return Just(session != nil).eraseToAnyPublisher()
    }
    
    /// Stopping and deleting a multiuser session.
    public func stopSession() -> AnyPublisher <Bool, Never>{
        // Remove MCNearbyServiceBrowser.
        if serviceBrowser != nil {
            serviceBrowser.stopBrowsingForPeers()
            serviceBrowser.delegate = nil
            serviceBrowser = nil
        }
        // Remove MCNearbyServiceAdvertiser
        if serviceAdvertiser != nil {
            serviceAdvertiser.stopAdvertisingPeer()
            serviceAdvertiser.delegate = nil
            serviceAdvertiser = nil
        }
        // Remove MCSession.
        if session != nil {
            session.delegate = nil
            session = nil
        }
        // Result.
        return Just(serviceBrowser == nil && serviceAdvertiser == nil && session == nil)
            .eraseToAnyPublisher()
    }
}

extension MultipeerSession: MCSessionDelegate {
    
    public func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case .notConnected:
            peerLeftHandler(peerID)
        case .connecting:
            peerJoinHandler(peerID)
        case .connected:
            peerJoinedHandler(peerID)
        @unknown default:
            break
        }
    }
    
    public func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        receivedDataHandler(data, peerID)
    }
    
    public func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String,
                 fromPeer peerID: MCPeerID) {
        
        errorPublisher.send(completion: .failure(MultipeerSessionError.errorSendingOrreceiveStream))
    }
    
    public func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String,
                 fromPeer peerID: MCPeerID, with progress: Progress) {
        errorPublisher.send(completion: .failure(MultipeerSessionError.errorSendingOrreceiveResources))
    }
    
    public func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String,
                 fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        errorPublisher.send(completion: .failure(MultipeerSessionError.errorSendingOrreceiveResources))
    }
    
}

extension MultipeerSession: MCNearbyServiceBrowserDelegate {
    
    public func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String: String]?) {
        // Ask the handler whether we should invite this peer or not
        let accepted = peerDiscoveredHandler(peerID)
        if accepted {
            browser.invitePeer(peerID, to: session, withContext: nil, timeout: 10)
        }
    }

    public func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        // This app doesn't do anything with non-invited peers, so there's nothing to do here.
    }
    
}

extension MultipeerSession: MCNearbyServiceAdvertiserDelegate {
    
    public func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID,
                    withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        invitationHandler(true, self.session)
    }
}
