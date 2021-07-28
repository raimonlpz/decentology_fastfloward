import Artist from 0x02

transaction() {
  
  let pixels: String
  let picture: @Artist.Picture
  let collectionRef: &Artist.Collection

  // let collection: @Artist.Collection?

  prepare(account: AuthAccount) {
    let printerRef = getAccount(0x02)
      .getCapability<&Artist.Printer>(/public/ArtistPicturePrinter)
      .borrow()
      ?? panic("Couldn't borrow printer reference.")
    
    // Replace with your own drawings.
    self.pixels = "*   *   *  **       *   *"
    let canvas = Artist.Canvas(
      width: printerRef.width,
      height: printerRef.height,
      pixels: self.pixels
    )
    
   self.picture <- printerRef.print(canvas: canvas) ?? panic("could not get picture...")

   self.collectionRef = getAccount(0x02)
        .getCapability<&Artist.Collection>(/public/ArtistPicturesCollection)
        .borrow()
        ?? panic("Couldn't borrow collection reference")

  }

  execute {
    self.collectionRef.deposit(picture: <- self.picture)
  }
}