//
// Copyright (c) WhatsApp Inc. and its affiliates.
// All rights reserved.
//
// This source code is licensed under the BSD-style license found in the
// LICENSE file in the root directory of this source tree.
//

import UIKit

/**
 *  Represents the two supported extensions for sticker images: png and webp.
 */
enum ImageDataExtension: String {
	case png = "png"
	case webp = "webp"
}

/**
 *  Stores sticker image data along with its supported extension.
 */
class ImageData {
	let data: Data
	let type: ImageDataExtension
	
	var bytesSize: Int64 {
		return Int64(data.count)
	}
	
	/**
	 *  Returns the webp data representation of the current image. If the current image is already webp,
	 *  the data is simply returned. If it's png, it will returned the webp converted equivalent data.
	 */
	//Do not encode
	lazy var webpData: Data? = {
		return data
	}()
	
	/**
	 *  Returns a UIImage of the current image data. If data is corrupt, nil will be returned.
	 */
	lazy var image: UIImage? = {
		// Static image
		return UIImage(data: data)
	}()
	
	/**
	 * Returns an image with the new size.
	 */
	func image(withSize size: CGSize) -> UIImage? {
		guard let image = image else { return nil }
		
		UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
		image.draw(in: CGRect(origin: .zero, size: size))
		let resizedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()
		return resizedImage
	}
	
	init(data: Data, type: ImageDataExtension) {
		self.data = data
		self.type = type
	}
	
	static func imageDataIfCompliant(contentsOfFile filename: String, isTray: Bool) throws -> ImageData {
		let fileExtension: String = (filename as NSString).pathExtension
		
		guard let data = FileManager.default.contents(atPath: filename) else {
			throw StickerPackError.fileNotFound
		}
		
		guard let imageType = ImageDataExtension(rawValue: fileExtension) else {
			throw StickerPackError.unsupportedImageFormat(fileExtension)
		}
		
		return try ImageData.imageDataIfCompliant(rawData: data, extensionType: imageType, isTray: isTray)
	}
	
	static func imageDataIfCompliant(rawData: Data, extensionType: ImageDataExtension, isTray: Bool) throws -> ImageData {
		let imageData = ImageData(data: rawData, type: extensionType)
		
		return imageData
	}
}
