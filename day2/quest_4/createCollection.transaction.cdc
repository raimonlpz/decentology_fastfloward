import Artist from 0x01

transaction {
    prepare(account: AuthAccount) {
        let collection <- Artist.createCollection()
        account.save(<- collection, to: /storage/ArtistPictureCollection)

        account.link<&Artist.Collection>(
            /public/ArtistPictureCollection,
            target: /storage/ArtistPictureCollection
        )
    }
}