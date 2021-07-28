import Artist from 0x01

transaction {

    let picture: @Artist.Picture?
    let collectionRef: &Artist.Collection

    prepare(account: AuthAccount) {
        let printerRef = getAccount(0x01)
            .getCapability(/public/ArtistPicturePrinter)
            .borrow<&Artist.Printer>()
            ?? panic("Couldn't borrow reference to Printer")

        self.collectionRef = account
            .getCapability(/public/ArtistPictureCollection)
            .borrow<&Artist.Collection>()
            ?? panic("couldn't borrow collection reference...")
        
        let canvas = Artist.Canvas(
            width: 5,
            height: 5,
            pixels: "*   * * *   *   * * *   *"
        )
        self.picture <- printerRef.print(canvas: canvas)
    }

    execute {
        if self.picture != nil {
            self.collectionRef.deposit(picture: <- self.picture)
        } else {
            log("Picture couldn't be printed for a duplicate Canvas")
            destroy self.picture
        }
        // destroy self.picture
    }
}