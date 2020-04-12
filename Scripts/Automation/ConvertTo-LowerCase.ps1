function ConvertTo-LowerCase {
    [alias("lower")]
    param(
        [string]
        $String
    )

    (Get-Culture).TextInfo.ToLower($String)
}