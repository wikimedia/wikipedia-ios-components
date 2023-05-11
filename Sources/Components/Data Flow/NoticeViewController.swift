import UIKit

// MARK: - View Model

public final class NoticeViewModel {

	var title = "Earth"
	var noticeInfo: String = "Notice Info"

	public init() {
		
	}

	@objc public func fetch(completion: @escaping (String) -> Void) {

	}

}

// MARK: - View Controller

public final class NoticeViewController: WKCanvasViewController {

	let viewModel: NoticeViewModel

	let label = UILabel()

	public init(viewModel: NoticeViewModel) {
		self.viewModel = viewModel
		super.init()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	public override func viewDidLoad() {
		super.viewDidLoad()

		label.text = viewModel.noticeInfo
		label.translatesAutoresizingMaskIntoConstraints = false

		let button = UIButton(type: .system)
		button.setTitle("Fetch Info", for: .normal)
		button.addTarget(self, action: #selector(fetchNotices), for: .primaryActionTriggered)
		button.translatesAutoresizingMaskIntoConstraints = false

		view.addSubview(label)
		view.addSubview(button)

		NSLayoutConstraint.activate([
			label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			label.centerYAnchor.constraint(equalTo: view.centerYAnchor),

			button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 25),
			button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
		])
	}

	@objc func fetchNotices() {
		viewModel.fetch(completion: { info in
			DispatchQueue.main.async {
				self.label.text = info
			}
		})
	}

}
