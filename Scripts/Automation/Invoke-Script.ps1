function Invoke-Script{

    $script = (Get-ChildItem -Path "$env:USERPROFILE\Documents\Scripts\Libs" -File).FullName | peco
    & "$script"
}