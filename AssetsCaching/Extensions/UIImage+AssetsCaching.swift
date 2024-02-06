import UIKit

extension UIImageView {
    public func setASImage(_ url: String?,
                           cacheType: ASCacheType = .ramAndDisk) {
        guard
            let path = url,
            !path.isEmpty,
            let _url = URL(string: path)
        else { return }
        
        func setImage(from data: Data) {
            DispatchQueue.global(qos: .background).async {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }

        ASCache.shared
            .getImage(url, cacheType: cacheType) { [weak self] data in
                guard let self = self else { return }
                setImage(from: data)
            }
    }
}
