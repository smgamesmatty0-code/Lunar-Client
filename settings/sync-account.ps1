param($Username, $UUID)
$dir = Split-Path -Parent $PSScriptRoot
$acc = [ordered]@{
    activeAccountLocalId = "offline_$Username"
    accounts = [ordered]@{
        "offline_$Username" = [ordered]@{
            accessToken = "0"
            accessTokenExpiresAt = "2099-01-01T00:00:00Z"
            eligibleForMigration = $false
            hasMultipleProfiles = $false
            legacy = $false
            persistent = $true
            localId = "offline_$Username"
            refreshToken = "offline_token"
            minecraftProfile = [ordered]@{
                id = $UUID
                name = $Username
            }
            remoteId = "0"
            type = "Xbox"
            username = $Username
        }
    }
}
$json = $acc | ConvertTo-Json -Depth 5
if (-not (Test-Path "$dir\settings\game")) { New-Item -ItemType Directory -Path "$dir\settings\game" -Force | Out-Null }
[System.IO.File]::WriteAllText("$dir\settings\game\accounts.json", $json)
if (Test-Path "$dir\settings\game-backup") {
    [System.IO.File]::WriteAllText("$dir\settings\game-backup\accounts.json", $json)
}
