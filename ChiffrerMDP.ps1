function XOR-EncryptDecrypt {
    param (
        [string]$Text,
        [string]$Key
    )
    $KeyLength = $Key.Length
    $EncryptedChars = for ($i = 0; $i -lt $Text.Length; $i++) {
        [char]([byte]$Text[$i] -bxor [byte]$Key[$i % $KeyLength])
    }
    return -join $EncryptedChars
}

function XOR-EncryptDecrypt {
    param (
        [string]$Text,
        [string]$Key
    )
    $KeyLength = $Key.Length
    $EncryptedChars = for ($i = 0; $i -lt $Text.Length; $i++) {
        [char]([byte]$Text[$i] -bxor [byte]$Key[$i % $KeyLength])
    }
    return -join $EncryptedChars
}

function Encode-Password {
    param (
        [string]$Password,
        [string]$Key
    )
    $Encrypted = XOR-EncryptDecrypt -Text $Password -Key $Key
    return [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($Encrypted))
}

function Decode-Password {
    param (
        [string]$EncodedPassword,
        [string]$Key
    )
    $Encrypted = [System.Text.Encoding]::UTF8.GetString([Convert]::FromBase64String($EncodedPassword))
    return XOR-EncryptDecrypt -Text $Encrypted -Key $Key
}

function Show-Menu {
    Write-Host "======= MENU ======="
    Write-Host "1 - Chiffrer un mot de passe"
    Write-Host "2 - Dechiffrer un mot de passe"
    Write-Host "3 - Quitter"
}

# Boucle pour garder le menu actif
while ($true) {
    Show-Menu
    $Choix = Read-Host "Choisissez une option (1, 2 ou 3)"

    if ($Choix -eq "1") {
         $MotDePasse = Read-Host "Entrez le mot de passe a chiffrer"
        $Cle = Read-Host "Entrez la cle secrete"
        $MotDePasseChiffre = Encode-Password -Password $MotDePasse -Key $Cle
        Write-Host "Mot de passe chiffre : $MotDePasseChiffre"
    }
    elseif ($Choix -eq "2") {
        $MotDePasseChiffre = Read-Host "Entrez le mot de passe chiffre"
        $Cle = Read-Host "Entrez la cle secrete"
        $MotDePasseDechiffre = Decode-Password -EncodedPassword $MotDePasseChiffre -Key $Cle
        Write-Host "Mot de passe dechiffre : $MotDePasseDechiffre"
    }
    elseif ($Choix -eq "3") {
        Write-Host "Au Revoir"
        break
    }
    else {
        Write-Host "Choix invalide, reessayez."
    }
}