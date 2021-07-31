import Artist from "./contract.cdc"

pub fun main(address: Address): [String]? {
    var canvases: [String] = []

    let collectionRef = getAccount(address)
            .getCapability(/public/ArtistPictureCollection)
            .borrow<&Artist.Collection>()
    
    if collectionRef == nil {
        return nil
    } else {
        for canvas in collectionRef!.getCanvases() {
            canvases.append(canvas.pixels)
        }
        return canvases
    }
}
