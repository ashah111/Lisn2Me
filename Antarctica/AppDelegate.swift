//
//  AppDelegate.swift
//  Antarctica
//
//  Created by Ayushi shah on 2019-04-18.
//  Copyright © 2019 Ayushi Shah. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, SPTSessionManagerDelegate, SPTAppRemoteDelegate, SPTAppRemotePlayerStateDelegate {

    var window: UIWindow?
    
    let kCLientID = "9bea4b1630b9479289defe956e021b16"
    let kCallbackURL = URL(string: "spotify-ios-quick-start://spotify-login-callback")!
    let kTokenSwapURL = "https://lisn2me-app.herokuapp.com/api/token"
    let kTokenRefreshServiceURL = "https://lisn2me-app.herokuapp.com/api/refresh_token"
    static private let kAccessTokenKey = "access-token-key"
    
    
    var accessToken = UserDefaults.standard.string(forKey: kAccessTokenKey) {
        didSet {
            let defaults = UserDefaults.standard
            defaults.set(accessToken, forKey: AppDelegate.kAccessTokenKey)
            defaults.synchronize()
        }
    }

    
    //holding the credentials provided for your app
    lazy var configuration = SPTConfiguration(
        clientID: kCLientID,
        redirectURL: kCallbackURL
    )

    //manages a Spotify user session, in the form of SPTSession.
    //SPTSession
    lazy var sessionManager: SPTSessionManager = {
        
        if let tokenSwapURL = URL(string: kTokenSwapURL),
            let tokenRefreshURL = URL(string: kTokenRefreshServiceURL) {
            self.configuration.tokenSwapURL = tokenSwapURL
            self.configuration.tokenRefreshURL = tokenRefreshURL
            self.configuration.playURI = ""
        }
        let manager = SPTSessionManager(configuration: self.configuration, delegate: self)
        return manager
    }()
    
    lazy var appRemote: SPTAppRemote = {
        let appRemote = SPTAppRemote(configuration: self.configuration, logLevel: .debug)
        appRemote.delegate = self
        //appRemote.connectionParameters.accessToken = self.accessToken
        return appRemote
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //SPTScope represents the OAuth scopes that declare how your app wants to access a user’s account
        let requestedScopes: SPTScope = [.appRemoteControl]
        self.sessionManager.initiateSession(with: requestedScopes, options: .default)
        print("Session Manager Initiate Session")
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        print("self.sessionManager.application()")
        self.sessionManager.application(app, open: url, options: options)
        
        let userDefaults = UserDefaults.standard
        
        do {
            let sessionData = try NSKeyedArchiver.archivedData(withRootObject: self.sessionManager, requiringSecureCoding: false)
            userDefaults.set(sessionData, forKey: "sessionData")
            userDefaults.synchronize()
            print("User Defaults synchronized")
        }catch{
            print("error")
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        if self.appRemote.isConnected {
            print("App Remote Disconnected")
            self.appRemote.disconnect()
            
        }
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        if let _ = self.appRemote.connectionParameters.accessToken {
            self.appRemote.connect()
        }
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
    }
    
    func sessionManager(manager: SPTSessionManager, didInitiate session: SPTSession) {
        print("Session Manager Success")
        self.appRemote.connectionParameters.accessToken = session.accessToken
        self.appRemote.connect()
    }
    func sessionManager(manager: SPTSessionManager, didFailWith error: Error) {
        print("Session Manager Failure", error)
    }
    func sessionManager(manager: SPTSessionManager, didRenew session: SPTSession) {
        print("Session Manager Renewed", session)
    }
    
    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
         print("App Remote Establish Connection")
        self.appRemote.playerAPI?.delegate = self
        self.appRemote.playerAPI?.subscribe(toPlayerState: { (result, error) in
           print("Error in App Remote Establish Connection")
        })
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
        print("App Remote Disconnected")
    }
    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
        print("App Remote Failed")
    }
    func playerStateDidChange(_ playerState: SPTAppRemotePlayerState) {
        debugPrint("Track name: %@", playerState.track.name)
        print("player state changed")
    }
}

