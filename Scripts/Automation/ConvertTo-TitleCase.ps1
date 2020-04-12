function ConvertTo-TitleCase {
    [alias("title")]
    param(
        [string]
        $String
    )

    (Get-Culture).TextInfo.ToTitleCase($String)
}