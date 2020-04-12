# jq required

function Format-Json {
    param (
        $Json
    )

    $Json | jq
}