//
//  Animal.swift
//  SlideOutNavigation
//
//  Created by Brent Simmons on 8/4/15.
//  Copyright (c) 2015 Brent Simmons. All rights reserved.
//

import UIKit

@objc
class MainMenu {
  
  let title: String
  let image: UIImage?
  
  init(title: String, image: UIImage?) {
    self.title = title
    self.image = image
  }
  
  class func menuOptions() -> Array<MainMenu > {
    return [ MainMenu (title: "Profile", image: UIImage(named: "accountoutline.png")),
      MainMenu (title: "Claims History", image: UIImage(named: "wordpress.png")),
      MainMenu (title: "Benefit Coverage", image: UIImage(named: "xbox.png")),
      MainMenu (title: "Documents", image: UIImage(named: "library.png"))
    ]
  }
 
}