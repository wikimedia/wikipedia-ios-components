import UIKit

public class WKRandomPhotoViewModel {

	// MARK: - Nested Types

	struct Dog: Codable {
		let message: String
	}

	struct Cat: Codable {
		let file: String
	}

	public enum Configuration: String {
		case cats = "Cats"
		case dogs = "Dogs"

		var api: URL {
			switch self {
			case .cats:
				return URL(string: "https://aws.random.cat/meow")!
			case .dogs:
				return URL(string: "https://dog.ceo/api/breeds/image/random")!
			}
		}
	}

	// MARK: - Properties

	public var configuration: Configuration

	// MARK: - Public

	public init(configuration: Configuration) {
		self.configuration = configuration
	}

	public func loadImage(completion: @escaping (UIImage) -> Void) {
		switch configuration {
		case .cats:
			let task = URLSession.shared.dataTask(with: Configuration.cats.api) { data, _, _ in

				if let data = data, let cat = try? JSONDecoder().decode(Cat.self, from: data) {
					self.fetchPhoto(cat.file, completion: completion)
				}
			}
			task.resume()
		case .dogs:
			let task = URLSession.shared.dataTask(with: Configuration.dogs.api) { data, _, _ in
				if let data = data, let dog = try? JSONDecoder().decode(Dog.self, from: data) {
					self.fetchPhoto(dog.message, completion: completion)
				}
			}
			task.resume()
		}
	}

	// MARK: - Private

	private func fetchPhoto(_ string: String, completion: @escaping (UIImage) -> ()) {
		guard let url = URL(string: string) else {
			completion(UIImage())
			return
		}

		let task = URLSession.shared.dataTask(with: url) { data, _, _ in
			if let data = data, let image = UIImage(data: data) {
				completion(image)
			}
		}
		task.resume()
	}

}
