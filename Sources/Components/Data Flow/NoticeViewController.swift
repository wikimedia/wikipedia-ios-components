import UIKit
import WKData

// MARK: - View Model

public final class NoticeViewModel {

	let networkService: WKNetworkService

	var title = "Earth"
	var noticeInfo: String = "Notice Info"

	public init(networkService: WKNetworkService) {
		self.networkService = networkService
	}

	public func fetch(completion: @escaping ([WKNotice]) -> Void) {
		let noticeFetcher = WKNoticeFetcher(networkService: networkService)
		noticeFetcher.fetchNotices(for: title, completion: { result in
			if case let .success(notices) = result {
				completion(notices)
			} else {
				completion([])
			}
		})
	}

}

// MARK: - View Controller

public final class NoticeViewController: WKCanvasViewController {

	let viewModel: NoticeViewModel

	let textView = UITextView()

	public init(viewModel: NoticeViewModel) {
		self.viewModel = viewModel
		super.init()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	public override func viewDidLoad() {
		super.viewDidLoad()

		textView.text = viewModel.noticeInfo
		textView.backgroundColor = .gray100
		textView.translatesAutoresizingMaskIntoConstraints = false

		let button = UIButton(type: .system)
		button.setTitle("Fetch Info", for: .normal)
		button.addTarget(self, action: #selector(fetchNotices), for: .primaryActionTriggered)
		button.translatesAutoresizingMaskIntoConstraints = false

		view.addSubview(textView)
		view.addSubview(button)

		NSLayoutConstraint.activate([
			textView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			textView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			textView.heightAnchor.constraint(equalToConstant: 100),

			button.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 25),
			button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
		])
	}

	@objc func fetchNotices() {
		viewModel.fetch(completion: { info in
			DispatchQueue.main.async {
				self.textView.text = info.description
			}
		})
	}

}
