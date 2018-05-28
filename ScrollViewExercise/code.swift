
//        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me/photos", parameters: ["fields":"id,picture"] )
//        graphRequest.start(completionHandler: { (connection, result, error) -> Void in
//            if error != nil
//            {
//                // Process error
//                print("Error: \(error!.localizedDescription)")
//            } else if let fbResult = result as? [String : Any],
//                    let mainData = fbResult["data"] as? [Any] {
//                for dict in mainData {
//                    if let dict = dict as? [String:String] {
//                        guard let photoID = dict["id"] else { continue }
//
//                    }
//                }
//            }
//        })


//FBSDKGraphRequest(graphPath: "\(photoID)", parameters: ["fields" : "picture,id"]).start(completionHandler: { (connection, result, error) in
//    if error != nil
//    {
//        // Process error
//        print("Error: \(error!.localizedDescription)")
//    } else if let fbResult = result as? [String : Any],
//        let mainData = fbResult["data"] as? [String:String] {
//        guard let photoURL = mainData["url"] else { return }
//        
//        self.userPhotos.append(PhotoModel(id: photoID, url: photoURL))
//        
//        
//    }
//    
//})


