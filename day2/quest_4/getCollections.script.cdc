import Artist from 0x01

pub fun main() {
    let accounts = [
        getAccount(0x01),
        getAccount(0x02),
        getAccount(0x03),
        getAccount(0x04),
        getAccount(0x05)
    ]

    for account in accounts {
        let collectionRef = account
            .getCapability(/public/ArtistPictureCollection)
            .borrow<&Artist.Collection>()

        if collectionRef == nil {
            log("account ".concat(account.address.toString().concat(" doesn't have a Picture Collection.")))
        } else {
            // log(collectionRef!.getCanvases())
            log("Account: ".concat(account.address.toString()))
            for canvas in collectionRef!.getCanvases() {
                // log(canvas.pixels)
                display(canvas)
            }
        }
    }
}

pub fun display(_ canvas: Artist.Canvas) {
    var w = canvas.width
    var h = canvas.height
    var canvasPixels = w * h
    var i: UInt8 = 0
    var limitLines = "+"

    while w > 0 {
        limitLines = limitLines.concat("-")
        w = w - 1
    }
    limitLines = limitLines.concat("+")
    log(limitLines)
    while i < canvasPixels {
        var pixelRow = "|".concat(canvas.pixels.slice(from: Int(i), upTo: Int(i + canvas.width))).concat("|")
        log(pixelRow)
        i = i + canvas.width
    }
    log(limitLines)
}