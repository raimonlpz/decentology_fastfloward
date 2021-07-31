import Artist from "./contract.cdc"

transaction(width: UInt8, height: UInt8, pixels: String) {
    let picture: @Artist.Picture?
    let collectionRef: &Artist.Collection

    prepare(account: AuthAccount) {
        let printerRef = getAccount(0x01cf0e2f2f715450)
            .getCapability(/public/ArtistPicturePrinter)
            .borrow<&Artist.Printer>()
            ?? panic("Couldn't borrow a ref. to the printer...")
    
        self.collectionRef = account
            .getCapability(/public/ArtistPictureCollection)
            .borrow<&Artist.Collection>()
            ?? panic("Couldn't borrow a collection ref.")


        let canvas = Artist.Canvas(
            width: width,
            height: width,
            pixels: pixels 
            // *   * * *   *   * * *   *
        )
        self.picture <- printerRef.print(canvas: canvas)
    }

    execute {
        if self.picture != nil {
            self.collectionRef.deposit(picture: <- self.picture!)
        } else {
            destroy self.picture
        }
    }
}