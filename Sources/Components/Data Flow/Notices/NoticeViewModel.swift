import Foundation
import WKData

// MARK: - View Model

public final class NoticeViewModel {

	var title = "Earth"
	var noticeInfo: String = "Notice Info"

	public init(title: String) {
		self.title = title
	}

	public func fetch(completion: @escaping (Result<[WKNotice], WKNoticeFetcher.WKNoticeFetcherError>) -> Void) {
		let fetcher = WKNoticeFetcher()
		fetcher.fetchNotices(for: title, completion: { result in
			if case let .success(notices) = result {
				completion(.success(notices))
			} else if case let .failure(error) = result {
				completion(.failure(error))
			}
		})
	}

}
