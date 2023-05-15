import UIKit

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
			textView.heightAnchor.constraint(equalToConstant: 350),
			textView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
			textView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25),

			button.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 25),
			button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
		])
	}

	@objc func fetchNotices() {
		viewModel.fetch(completion: { info in
			DispatchQueue.main.async {
				switch info {
				case .success(let notices):
					self.textView.text = notices.description
				case .failure(let error):
					self.textView.text = error.localizedDescription
				}
			}
		})
	}

}
