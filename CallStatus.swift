import CallKit

enum CXCallStatus {
	case dialing
	case connected
	case incoming
	case disconnected
	case unknown
}

extension CXCall {
	
	var status: CXCallStatus {

		if self.hasEnded {
			debugPrint("Disconnected")
			return .disconnected
		}
		
		if self.isOutgoing && !self.hasConnected {
			debugPrint("Dialing")
			return .dialing
		}
		
		if !self.isOutgoing && !self.hasConnected && !self.hasEnded {
			debugPrint("Incoming")
			return .incoming
		}
		
		if self.hasConnected && !self.hasEnded {
			debugPrint("Connceted")
			return .connected
		}
		
		return .unknown
	}
}
