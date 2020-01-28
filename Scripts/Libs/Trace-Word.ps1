Function Trace-Word
{
    [Cmdletbinding()]
    [Alias("Highlight")]
    Param(
            [Parameter(ValueFromPipeline=$true, Position=0)]
            [string[]] $Content,
            [Parameter(Position=1)] 
            [ValidateNotNull()]
            [String[]] $Words = $(throw "Provide word[s] to be highlighted!")
    )
    
    Begin
    {
        
        # Modified By re0j @ 2019-12-17 20:02:19 
        Function paletteConst{

            [System.Collections.ArrayList]$palette = @('DarkBlue','DarkGreen','DarkCyan', `
                                        'DarkRed','DarkMagenta','DarkYellow','DarkGray',  `
                                        'Blue','Green','Cyan','Red','Magenta','Yellow')
        
            $paletteDict = @{}
        
            For($i=0; $i -lt 13; $i++) {
                # index to pick
                if (($palette.Count -1) -eq 0) {
                    $init = 0
                } else {
                    $init = Get-Random -Minimum 0 -Maximum ($palette.Count - 1)
                }
        
        # tpido
                    $picked = $palette[$init]
            
                    # assign it to hashtable with ordered index
                    $paletteDict[$i] = $picked
            
                    # remove picked from original arraylist
                    $palette.Remove($picked)
                }
            
                return $paletteDict
            }

        $Color = paletteConst 
        # Modify END

        # $Color = @{       
                    # 0='Yellow'      
                    # 1='Magenta'     
                    # 2='Red'         
                    # 3='Cyan'        
                    # 4='Green'       
                    # 5 ='Blue'        
                    # 6 ='DarkGray'    
                    # 7 ='Gray'        
                    # 8 ='DarkYellow'    
                    # 9 ='DarkMagenta'    
                    # 10='DarkRed'     
                    # 11='DarkCyan'    
                    # 12='DarkGreen'    
                    # 13='DarkBlue'        
        # }

        $ColorLookup =@{}

        For($i=0; $i -lt $words.count; $i++)
        {
            if($i -eq 13)
            {
                $j = 0
            }
            else
            {
                $j = $i
            }

            $ColorLookup.Add($words[$i],$Color[$j])
            $j++
        }
        
    }
    Process
    {
    $content | ForEach-Object {
    
        $TotalLength = 0
               
        $_.split() | `
        Where-Object {-not [string]::IsNullOrWhiteSpace($_)} | ` #Filter-out whiteSpaces
        ForEach-Object{
                        if($TotalLength -lt ($Host.ui.RawUI.BufferSize.Width-10))
                        {
                            #"TotalLength : $TotalLength"
                            $Token =  $_
                            $displayed= $False
                            
                            Foreach($Word in $Words)
                            {
                                if($Token -like "*$Word*")
                                {
                                    $Before, $after = $Token -Split "$Word"
                              
                                        
                                    #"[$Before][$Word][$After]{$Token}`n"
                                    
                                    Write-Host $Before -NoNewline ; 
                                    Write-Host $Word -NoNewline -Fore Black -Back $ColorLookup[$Word];
                                    Write-Host $after -NoNewline ; 
                                    $displayed = $true                                   
                                    #Start-Sleep -Seconds 1    
                                    #break  
                                }

                            } 
                            If(-not $displayed)
                            {   
                                Write-Host "$Token " -NoNewline                                    
                            }
                            else
                            {
                                Write-Host " " -NoNewline  
                            }
                            $TotalLength = $TotalLength + $Token.Length  + 1
                        }
                        else
                        {                      
                            Write-Host '' #New Line  
                            $TotalLength = 0 

                        }

                            #Start-Sleep -Seconds 0.5
                        
        }
        Write-Host '' #New Line               
    }
    }
    end
    {    }

}


#Trace-Word -content (Get-Content iis.log) -words "IIS", 's', "exe", "10", 'system'
