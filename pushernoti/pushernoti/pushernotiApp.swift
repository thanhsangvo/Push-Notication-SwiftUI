//
//  pushernotiApp.swift
//  pushernoti
//
//  Created by Vo Thanh Sang on 08/10/2021.
//

import SwiftUI
import PusherSwift

@main
struct pushernotiApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}


class AppDelegate: UIResponder, UIApplicationDelegate, PusherDelegate {

    // You must retain a strong reference to the Pusher instance
    var pusher: Pusher!

    func application(
      _ application: UIApplication,
      didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

      let options = PusherClientOptions(
        host: .cluster("ap1")
      )

      pusher = Pusher(
        key: "da51b798dc018b2b45f9",
        options: options
      )

      pusher.delegate = self

      // subscribe to channel
      let channel = pusher.subscribe("my-channel")

      // bind a callback to handle an event
      let _ = channel.bind(eventName: "my-event", eventCallback: { (event: PusherEvent) in
          if let data = event.data {
            // you can parse the data as necessary
            print(data)
          }
      })

      pusher.connect()

      return true
    }

    // print Pusher debug messages
    func debugLog(message: String) {
      print(message)
    }
  }
