function Read-Archive {

    param (
        $Path
    )

    7z l $Path

}