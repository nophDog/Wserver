function ConvertTo-UpperCase {
    [alias("upper")]
    param(
        [string]
        $String
    )

    (Get-Culture).TextInfo.ToUpper($String)
}