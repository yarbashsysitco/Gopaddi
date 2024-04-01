

import Foundation

    // This file was generated from JSON Schema using quicktype, do not modify it directly.

    // To parse the JSON, add this file to your project and do:

    //

    //   let employeeProfileDetailsModel = try? JSONDecoder().decode(EmployeeProfileDetailsModel.self, from: jsonData)



import Foundation



    // MARK: - EmployeeProfileDetailsModel

class EmployeeProfile: Codable {

    var success: Bool

    var message: String

    var data: [post]

    

    init(success: Bool, message: String, data: [post]) {

        self.success = success

        self.message = message

        self.data = data

    }

}



    // MARK: - Datum

class post: Codable {

    var posts: [Postts]

    

    init(posts: [Postts]) {

        self.posts = posts

    }

}



    // MARK: - Post

class Postts: Codable {

    var id: String

    var userinfo: [Userinfoo]

    var caption: String

    var files: [Filee]

    var cover, likesCount: String

    var likedStatus: Bool

    var savesCount: String

    var savedStatus: Bool

    var sharesCount, commentsCount: String

//    var commentsLists: [String]

    var viewsCount: String

    var createdStatus: Bool

    var createdAt: String

    var promotion, diary: Bool

    

    init(id: String, userinfo: [Userinfoo], caption: String, files: [Filee], cover: String, likesCount: String, likedStatus: Bool, savesCount: String, savedStatus: Bool, sharesCount: String, commentsCount: String, viewsCount: String, createdStatus: Bool, createdAt: String, promotion: Bool, diary: Bool) {

        self.id = id

        self.userinfo = userinfo

        self.caption = caption

        self.files = files

        self.cover = cover

        self.likesCount = likesCount

        self.likedStatus = likedStatus

        self.savesCount = savesCount

        self.savedStatus = savedStatus

        self.sharesCount = sharesCount

        self.commentsCount = commentsCount

//        self.commentsLists = commentsLists

        self.viewsCount = viewsCount

        self.createdStatus = createdStatus

        self.createdAt = createdAt

        self.promotion = promotion

        self.diary = diary

    }

}



    // MARK: - File

class Filee: Codable {

    var id: String

    var url: String

    

    init(id: String, url: String) {

        self.id = id

        self.url = url

    }

}



    // MARK: - Userinfo

class Userinfoo: Codable {

    var id, firstName, lastName, username: String

    var picture: String

    

    init(id: String, firstName: String, lastName: String, username: String, picture: String) {

        self.id = id

        self.firstName = firstName

        self.lastName = lastName

        self.username = username

        self.picture = picture

    }

}
