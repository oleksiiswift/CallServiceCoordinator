import Foundation

enum CallCoordinatorState: CaseIterable {
	case freeForCalls
	case serviceCallWillDialing
	case serviceCallDidConnect
	case shouldDialOutgoingCall
	case didConnectOutgoingCall
	case didActiveForHandledServiceCall
	case handledServiceCallDidDialing
	case handledServiceCallDidConnected
	
	var key: String {
		switch self {
			case .freeForCalls:
				return Constants.key.callRouting.freeForCallsStateValue
			case .serviceCallWillDialing:
				return Constants.key.callRouting.serviceCallWllDialing
			case .serviceCallDidConnect:
				return Constants.key.callRouting.serviceCallDidConnect
			case .shouldDialOutgoingCall:
				return Constants.key.callRouting.shouldDialOutgoingCall
			case .didConnectOutgoingCall:
				return Constants.key.callRouting.outgoingCallDidConnected
			case .didActiveForHandledServiceCall:
				return Constants.key.callRouting.didActiveForHandledServiceCall
			case .handledServiceCallDidDialing:
				return Constants.key.callRouting.handledServiceCallDidDialing
			case .handledServiceCallDidConnected:
				return Constants.key.callRouting.handledServiceCallDidConnected
		}
	}
	
	var descirption: String {
		switch self {
			case .freeForCalls:
				return "freeForCalls"
			case .serviceCallWillDialing:
				return "serviceCallWillDialing"
			case .serviceCallDidConnect:
				return "serviceCallDidConnect"
			case .shouldDialOutgoingCall:
				return "shouldDialOutgoingCall"
			case .didConnectOutgoingCall:
				return "didConnectOutgoingCall"
			case .didActiveForHandledServiceCall:
				return "didActiveForHandledServiceCall"
			case .handledServiceCallDidDialing:
				return "handledServiceCallDidDialing"
			case .handledServiceCallDidConnected:
				return "handledServiceCallDidConnected"
		}
	}
}
