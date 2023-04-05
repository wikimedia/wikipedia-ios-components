import UIKit
import ComponentsObjC

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
        let textStorage = WKSourceEditorTextStorage()
	}

	private func loadImage() {
		customView.activityIndicator.startAnimating()
        let configuration = viewModel.configuration
		viewModel.loadImage(completion: { [weak self] image in
			DispatchQueue.main.async {
                
                guard let self = self else {
                    return
                }
                
				self.customView.activityIndicator.stopAnimating()
				self.customView.update(configuration: configuration, image: image)
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
