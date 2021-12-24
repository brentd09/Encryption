function ConvertTo-CaesarCipher {
  <#
  .SYNOPSIS
    Converts alphabet characters to a shifted cipher
  .DESCRIPTION
    Converts alphabet characters in a string to a Caesar Cipher 
    which simply shifts the characters forward up the alphabet.
    If its runs out of alphabet z wraps arond to a and it starts 
    from there
  .EXAMPLE
    ConvertTo-CaesarCipher -Text 'The quick brown fox jumps over the lazy dog' -Shift 3
    This will encrypt the string so that it is no longer human readable 
  .PARAMETER Text
    The text that will be obscured via the Caesar Cipher 
  .PARAMETER Shift
    How many characters to shift the text to produce the cipher 
  .INPUTS  
    String
  .OUTPUTS
    String
  .NOTES
    General notes
      Created by: Brent Denny
      Created on: 25 Dec 2021
      Versions: 
        0.1 Could only shift by one character
        0.2 Can shift by any number of characters
  #>
  [CmdletBinding()]
  Param (
    [Parameter(Mandatory=$true)]
    [string]$Text,
    [int]$Shift = 1
  )
  $CipherResult = ''
  $Chars = $Text.ToCharArray()
  foreach ($Char in $Chars) {
    $Ascii = [byte][char]$Char
    if ($Char -match '[a-z]') {
      if (($Ascii -ge (123-$Shift) -and ($Ascii -le 122)) -or ($Ascii -ge (91-$Shift) -and ($Ascii -le 90))) {$Ascii = $Ascii - (26-$Shift)} # Wrapping 
      else {$Ascii = $Ascii + $Shift} # Normal shifting, wrapping only happens if we run off the end of the alphabet
    }
    $CipherResult += [char]$Ascii
  }
  return $CipherResult
}

function ConvertFrom-CaesarCipher {
    <#
  .SYNOPSIS
    Converts a shifted cipher back into readable text
  .DESCRIPTION
    Converts a Caesar Cipher back into readable text which shifts the characters 
    back a chosen number of characters in the alphabet.
  .EXAMPLE
    ConvertFrom-CaesarCipher -Cipher 'Wkh txlfn eurzq ira mxpsv ryhu wkh odcb grj' -Shift 3
    This will decrypt the cipher so that it is now human readable given the correct shift value
  .PARAMETER Cipher
    The Cipher that will be unobscured, reversing the Caesar Cipher 
  .PARAMETER Shift
    How many characters to shift alphabet of the cipher  
  .INPUTS  
    String
  .OUTPUTS
    String
  .NOTES
    General notes
      Created by: Brent Denny
      Created on: 25 Dec 2021
      Versions: 
        0.1 Could only shift by one character
        0.2 Can shift by any number of characters
  #>
  [CmdletBinding()]
  Param (
    [Parameter(Mandatory=$true)]
    [string]$Cipher,
    [int]$Shift = 1
  )
  $TextResult = ''
  $Chars = $Cipher.ToCharArray()
  foreach ($Char in $Chars) {
    $Ascii = [byte][char]$Char
    if ($Char -match '[a-z]') {
      if (($Ascii -le (96+$Shift) -and ($Ascii -ge 97)) -or ($Ascii -le (24+$Shift) -and ($Ascii -le 25))) {$Ascii = $Ascii + (26-$Shift)} # Wrapping
      else {$Ascii = $Ascii - $Shift} # Normal shifting, wrapping only happens if we run off the start of the alphabet
    }
    $TextResult += [char]$Ascii
  }
  return $TextResult
}