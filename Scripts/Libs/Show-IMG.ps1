function Show-IMG {
    param(
        [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
        [ValidatePattern("\.(jpg|png)$")]
        [ValidateScript({
            if (-not (Test-Path -Path $_ -PathType Leaf)) {
                throw "$_ not found, sorry :("
            } else {
                "$_"
            }
        })]
        $FilePath
    )
    
    # Loosely based on http://www.vistax64.com/powershell/202216-display-image-powershell.html

    [void][reflection.assembly]::LoadWithPartialName("System.Windows.Forms")

    $fileObj = Get-Item $FilePath

    $img = [System.Drawing.Image]::Fromfile($fileObj);

    # This tip from http://stackoverflow.com/questions/3358372/windows-forms-look-different-in-powershell-and-powershell-ise-why/3359274#3359274
    [System.Windows.Forms.Application]::EnableVisualStyles();
    $form = new-object Windows.Forms.Form
    $form.Text = "Image Viewer"
    $form.Width = $img.Size.Width + 10;
    $form.Height =  $img.Size.Height + 30;
    $pictureBox = new-object Windows.Forms.PictureBox
    $pictureBox.Width =  $img.Size.Width;
    $pictureBox.Height =  $img.Size.Height;

    $pictureBox.Image = $img;
    $form.controls.add($pictureBox)
    $form.Add_Shown( { $form.Activate() } )
    $form.ShowDialog()
    #$form.Show();
}