function ConvertTo-CaesarCipher {
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
      if ($Ascii -eq 122 -or $Ascii -eq 90) {$Ascii = $Ascii -25}
      else {$Ascii++}
    }
    $CipherResult += [char]$Ascii
  }
  return $CipherResult
}

function ConvertFrom-CaesarCipher {
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
      if ($Ascii -eq 97 -or $Ascii -eq 65) {$Ascii = $Ascii +25}
      else {$Ascii--}
    }
    $TextResult += [char]$Ascii
  }
  return $TextResult
}