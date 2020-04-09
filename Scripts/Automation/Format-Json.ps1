# jq required

function Format-Json {
    param (
        $Path
    )

    Get-Content -Path $Path | jq
}