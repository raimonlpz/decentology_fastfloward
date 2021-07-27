
pub struct Canvas {
    pub let width: UInt8
    pub let height: UInt8
    pub let pixels: String

    init(width: UInt8, height: UInt8, pixels: String) {
        self.width = width
        self.height = height
        self.pixels = pixels
    }
}

pub resource Picture {
    pub let canvas: Canvas
    init(canvas: Canvas) {
        self.canvas = canvas
    }
    pub fun display() {
        display(self.canvas)
    }
}

pub fun serializeStringArray(_ lines: [String]): String {
    var buffer = ""
    for l in lines {
        buffer = buffer.concat(l)
    }
    return buffer
}

pub fun main() {
    let pixelsX = [
        "*   *",
        " * * ",
        "  *  ",
        " * * ",
        "*   *"
    ]

    let canvasX = Canvas(width: 5, height: 5, pixels: serializeStringArray(pixelsX))
    let printerX <- create Printer()
    let pictureX <- printerX.print(canvas: canvasX) ?? panic("Err.: Could not get any picture from the printer...")
    pictureX.display()
    destroy printerX
    destroy pictureX
}


/**
1. Write a function that displays a canvas in a frame
*/
pub fun display(_ canvas: Canvas) {
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

/**
2. Create a resource that prints Pictures but only once for each unique 5x5 Canvas
*/
pub resource Printer {
    pub fun print(canvas: Canvas): @Picture? {
        return <- create Picture(canvas: canvas)
    }
}



