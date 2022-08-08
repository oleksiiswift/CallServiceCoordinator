import CallKit
import UIKit

protocol CallCoordinator {}

class CallServiceCoordinator: NSObject, CallCoordinator {
	
	static let shared: CallServiceCoordinator = {
		let instance = CallServiceCoordinator()
		return instance
	}()
	
	private var serviceKey = "serviceCallIdentifyer"
	private var key = "callRoutingKey"
	private var taskID = "backgroundTaskID"
	private var recentKey = "recentKey"
	
	private var observer: CXCallObserver!
	private var backgroundTaskID: UIBackgroundTaskIdentifier?

	
	var state: CallCoordinatorState {
		get {
			self.getCallRountingState()
		} set {
			self.setCallRouting(newValue)
		}
	}
	
	
	var serviceCallIdentifier: String? {
		get {
			return UserDefaults.standard.string(forKey: self.serviceKey)
		} set {
			UserDefaults.standard.set(newValue, forKey: self.serviceKey)
		}
	}
	
	var recentRecordIdentifyer: String? {
		get {
			return UserDefaults.standard.string(forKey: self.recentKey)
		} set {
			UserDefaults.standard.set(newValue, forKey: self.recentKey)
		}
	}
	
	override init() {
		super.init()
		
		self.observer = CXCallObserver()
		self.observer.setDelegate(self, queue: .main)
		
		NotificationCenter.default.addObserver(self, selector: #selector(applicationDidOpenBackgroundTask(_:)), name: .backgroundTaskDetection, object: nil)
	}
	
	public func removeValues() {
		self.serviceCallIdentifier = nil
	}
}

extension CallServiceCoordinator {
	
	@objc func applicationDidOpenBackgroundTask(_ notification: Notification) {
		self.setOpenBackgrondTask()
	}
	
	func setOpenBackgrondTask() {
		debugPrint("did start open background tasl")
		self.backgroundTaskID = UIApplication.shared.beginBackgroundTask(withName: self.taskID) {
			
			guard let taskID = self.backgroundTaslID else { return }
			
			UIApplication.shared.endBackgroundTask(taskID)
			
			self.backgroundTaslID = nil
		}
	}
}

extension CallServiceCoordinator {
	
	private func getCallRountingState() -> CallCoordinatorState {
		
		guard let routingValue = UserDefaults.standard.string(forKey: self.key) else { return .freeForCalls }
		
		if let state = CallCoordinatorState.allCases.first(where: {routingValue == $0.key}) {
			return state
		} else {
			return .freeForCalls
		}
	}
	
	private func setCallRouting(_ state: CallCoordinatorState) {
		UserDefaults.standard.set(state.key, forKey: self.key)
	}
}

extension CallServiceCoordinator: CXCallObserverDelegate {
	
	func callObserver(_ callObserver: CXCallObserver, callChanged call: CXCall) {
		
		switch call.status {
			
		case .dialing:
			if callObserver.calls.count == 1, state == .didActiveForHandledServiceCall {
				self.activate(.serviceCallWillDialing, from: observer, call: call)
			} else if callObserver.calls.count == 2, state == .didActiveForHandledServiceCall {
				self.activate(.handledServiceCallDidDialing, from: observer, call: call)
			} else if state == .serviceCallWillDialing {
				self.serviceCallIdentifier = call.uuid.uuidString
			}
		case .connected:
			
			if callObserver.calls.count == 1, call.uuid.uuidString == self.serviceCallIdentifier {
				debugPrint("serviceCallDidConnect")
				self.activate(.serviceCallDidConnect, from: observer, call: call)
			} else if callObserver.calls.count > 2, (observer.calls.first(where: {$0.uuid.uuidString == self.serviceCallIdentifier}) != nil) {
				debugPrint("didConnectOutgoingCall")
				self.activate(.didConnectOutgoingCall, from: observer, call: call)
			} else if callObserver.calls.count == 2, state == .handledServiceCallDidDialing {
				debugPrint("handledServiceCallDidConnected")
				self.activate(.handledServiceCallDidConnected, from: observer, call: call)
			} else {
				debugPrint("shit shit")
			}
		case .incoming:
			if self.serviceCallIdentifier == nil {
				debugPrint("show incoming cal window")
			}
		case .disconnected:
			guard self.observer.calls.isEmpty else { return }
			debugPrint("activate free for calls")
			self.activate(.freeForCalls, from: observer, call: call)
		case .unknown:
			return
		}
	}
	
	public func activate(_ state: CallCoordinatorState, from observer: CXCallObserver, call: CXCall?) {
		
		self.state = state
		
		switch state {
		case .freeForCalls:
			debugPrint("free for calls")
			self.removeValues()
			
		case .serviceCallWillDialing:
			
			debugPrint("call service call will dialing")
			
			guard let call = call else { return }
			self.serviceCallIdentifier = call.uuid.uuidString
			
			let userInfo = ["updatedID": "BackTaskvalue"]
			
			NotificationCenter.default.post(name: .backgroundTaskDetection, object: self, userInfo: userInfo)
			
			debugPrint("service call dialing, call id", call.uuid.uuidString)

		case .serviceCallDidConnect:
			
			guard let call = call else { return }
			
			debugPrint("service call did connect, call id", call.uuid.uuidString)
			debugPrint("need to dial outgoning call")
	
			let operativeID = call.uuid.uuidString
			let registeredTime = Date().timeIntervalSince1970
		
			guard call.uuid.uuidString == self.serviceCallIdentifier, let _ = self.recentRecordIdentifyer else { return }
			
			debugPrint("should")
			
			self.activate(.shouldDialOutgoingCall, from: observer, call: call)
			
			debugPrint("service call create entry")
			
		case .shouldDialOutgoingCall:
			
			
			debugPrint(state.descirption)
			
		case .didConnectOutgoingCall:
			
			debugPrint(state.descirption)
			
		case .didActiveForHandledServiceCall:
			
			debugPrint(state.descirption)
			
		case .handledServiceCallDidDialing:
			
			debugPrint("handledServiceCallDidDialing")
				
		case .handledServiceCallDidConnected:
			debugPrint("handledServiceCallDidConnected")
		}
	}
}

