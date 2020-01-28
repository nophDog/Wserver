Function New-Line{
    Param (
    [parameter(ValueFromPipeline)]$StringIn
  )

    $StringIn
    "-" * $stringIn.Length
}