import SwiftUI
import Combine

public class WKCommunicationData: ObservableObject {
	@Published var date: Date = Date()
	@Published var text: String = "I'm a SwiftUI View"
}

public class WKUICommunicationSwiftUIHostingController: WKComponentHostingController<WKUICommunicationSwiftUIView> {

	@ObservedObject public var data: WKCommunicationData

	public init(data: WKCommunicationData) {
		self.data = data
		let view = WKUICommunicationSwiftUIView(data: data)
		super.init(rootView: view)
	}

	public required init?(coder aDecoder: NSCoder) {
		fatalError()
	}


}
