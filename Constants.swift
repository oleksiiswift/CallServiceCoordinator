import Foundation

struct Constants {
	
	struct callRouting {
		
		static let callRoutingKey =                     "com.callServiceCoordinator.callRouting.key"
		
		static let freeForCallsStateValue =             "com.callServiceCoordinator.callRouting.freeForAllCalls.value"
		static let serviceCallWllDialing =              "com.callServiceCoordinator.callRouting.serviceWillDialing.value"
		static let serviceCallDidConnect =              "com.callServiceCoordinator.callRouting.serviceDidDial.value"
		
		static let shouldDialOutgoingCall =             "com.callServiceCoordinator.callRouting.shouldDialOutgoing.value"
		static let outgoingCallDidConnected =           "com.callServiceCoordinator.callRouting.outgoingCallDidConnected.value"
		
		static let didActiveForHandledServiceCall =     "com.callServiceCoordinator.callRouting.didActiveForHandledServiceCall.value"
		static let handledServiceCallDidDialing =       "com.callServiceCoordinator.callRouting.handledServiceCallDidDialing.value"
		static let handledServiceCallDidConnected =     "com.callServiceCoordinator.callRouting.handledServiceCallDidConnected.value"
		
		static let serviceCallIdentifyer =              "com.callServiceCoordinator.callRouting.serviceCallIdentifier.key"
		static let recentCallIdentifyer =               "com.callServiceCoordinator.callRouting.recentCallIdentifier.key"
		static let recentNumber =                       "com.callServiceCoordinator.callRouting.recentCallNumber.key"
	}
}
