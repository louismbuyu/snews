//
//  Values.swift
//  Snews
//
//  Created by Louis Nelson Levoride on 06.08.18.
//  Copyright © 2018 LouisNelson. All rights reserved.
//

import Foundation
import UIKit

let LOGGED_IN_KEY = "LOGGED_IN_KEY"
let USERANME_KEY = "USERANME_KEY"
let USER_OBJECT_KEY = "USER_OBJECT_KEY"
let USER_IMAGE_URL_KEY = "USER_IMAGE_URL_KEY"
let USER_IMAGE_DATA_KEY = "USER_IMAGE_DATA_KEY"
let USER_ID_KEY = "USER_ID_KEY"
let USER_DISPLAY_NAME_KEY = "USER_DISPLAY_NAME_KEY"

// Headers
let HEADER = [
    "Content-Type": "application/json",
    "Accept":"application/json"
]

// URL Constants
let BASE_URL = "https://limitless-gorge-23961.herokuapp.com/"
//let BASE_URL = "http://localhost:3000/"
let VERSION = "v0"

//loginSignup Api
let AUTH_URL = "auth/\(VERSION)"
let URL_REGISTER = "\(BASE_URL)\(AUTH_URL)/create"
let URL_LOGIN = "\(BASE_URL)\(AUTH_URL)/signin"
let URL_USER_LOGOUT = "\(BASE_URL)\(AUTH_URL)/logout"

//Users Api
let USER_URL = "user/\(VERSION)"
let URL_USER_CREATE = "\(BASE_URL)\(USER_URL)/create"
let URL_USER_SIGNIN = "\(BASE_URL)\(USER_URL)/signin"
let URL_USER_UPDATE = "\(BASE_URL)\(USER_URL)/update"
let URL_USERS_SEARCH = "\(BASE_URL)\(USER_URL)/search"
let URL_POST_RATING = "\(BASE_URL)\(USER_URL)/rating"
let URL_GET_MY_RIDES = "\(BASE_URL)\(USER_URL)/myRides"

//Article Api
let ARTICLE_URL = "article/\(VERSION)"
let URL_GET_ARTICLES = "\(BASE_URL)\(ARTICLE_URL)/articles"
let URL_ACTION_ARTICLE = "\(BASE_URL)\(ARTICLE_URL)/action"
let URL_SHARE_ARTICLE = "\(BASE_URL)\(ARTICLE_URL)/share"

//Message Api
let MESSAGE_URL = "message/\(VERSION)"
let URL_MESSAGE_CREATE = "\(BASE_URL)\(MESSAGE_URL)/create"
let URL_MESSAGE_RECENT_CHATS = "\(BASE_URL)\(MESSAGE_URL)/retrieve/recent"
let URL_MESSAGE_CHATROOM = "\(BASE_URL)\(MESSAGE_URL)/retrieve/chatroom"
let URL_MESSAGE_READ = "\(BASE_URL)\(MESSAGE_URL)/read"
