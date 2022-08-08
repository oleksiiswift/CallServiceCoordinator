import Foundation

extension Notification.Name {
	
	static let didBecomeActive =                    Notification.Name.init("applicationDidBecomeActiveFromBackground")
	static let willResignActive =                   Notification.Name.init("applicationWillResignActive")
	static let willEnterForeground =                Notification.Name.init("applicationWillEnterForeground")
	static let didEnterBackground =                 Notification.Name.init("applicationDidEnterBackground")
	static let backgroundTaskDetection =            Notification.Name(rawValue: "backgroundTaskDetection")
}

