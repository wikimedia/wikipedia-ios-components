import UIKit

public class WKRandomPhotoViewController: WKComponentViewController {

	// MARK: - Properties

	let viewModel: WKRandomPhotoViewModel

	var customView: WKRandomPhotoView {
		return view as! WKRandomPhotoView
	}

	// MARK: - Lifecycle

	public init(viewModel: WKRandomPhotoViewModel) {
		self.viewModel = viewModel
		super.init()
	}

	public required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	public override func loadView() {
		self.view = WKRandomPhotoView(configuration: viewModel.configuration)

		customView.addTarget(self, action: #selector(userTappedCats), for: .primaryActionTriggered, configuration: .cats)
		customView.addTarget(self, action: #selector(userTappedDogs), for: .primaryActionTriggered, configuration: .dogs)
	}

	public override func viewDidLoad() {
		super.viewDidLoad()
		loadImage()
	}

	private func loadImage() {
		customView.activityIndicator.startAnimating()
		viewModel.loadImage(completion: { image in
			DispatchQueue.main.async {
				self.customView.activityIndicator.stopAnimating()
				self.customView.update(configuration: self.viewModel.configuration, image: image)
			}
		})
	}

	@objc private func userTappedCats() {
		update(configuration: .cats)
	}

	@objc private func userTappedDogs() {
		update(configuration: .dogs)
	}

	private func update(configuration: WKRandomPhotoViewModel.Configuration) {
		viewModel.configuration = configuration
		customView.update(configuration: viewModel.configuration, image: nil)
		loadImage()
	}

}
