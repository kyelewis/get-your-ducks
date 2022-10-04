# Get Your Ducks

Anonymous "Don't break the chain" app.

The idea is that the browser generates a private/public keypair and keeps it locally- 
the public key identifies the user to the backend and the private key encrypts/decrypts the task data.

It should be possible to share the key with the apps, for example by scanning a QR code on the web, and/or
by using a wordlist of some sort to restore the keys.

- Web-App: Svelte/Parcel
- Backend: Vapor
- Database: Neo4j
- Android: Kotlin/Jetpack Compose
- iOS: Swift/SwiftUI
