import Foundation

public enum WKFeature: String, CaseIterable, Identifiable {

	public var id: String { rawValue } 

	case buttons = "Buttons"
	case topRead = "Top Read"
	case randomPhoto = "Random Photo"
	case sayHello = "Say Hello"
    case sourceEditor = "Source Editor"

	var framework: String {
		switch self {
		case .buttons:
			return "UIKit"
		case .topRead:
			return "SwiftUI"
		case .randomPhoto:
			return "UIKit"
		case .sayHello:
			return "UIKit and SwiftUI"
        case .sourceEditor:
            return "Source Editor"
		}
	}
	
}

