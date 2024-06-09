# Salve este script em um arquivo com extensão .ps1, por exemplo: CheckDisk.ps1
# Para executar, abra o PowerShell como Administrador e execute: .\CheckDisk.ps1

# Função para verificar permissões de administrador
function Check-Admin {
    $currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
    $currentPrincipal = New-Object Security.Principal.WindowsPrincipal($currentUser)
    if (-not $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)) {
        Write-Error "Este script deve ser executado com permissões de administrador."
        exit
    }
}

# Função para registrar atividades
function Log-Activity {
    param (
        [string]$message
    )
    $logFile = "CheckDiskLog.txt"
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$timestamp - $message" | Out-File -Append -FilePath $logFile
    Write-Output $message
}

# Função para verificar espaço em disco
function Check-DiskSpace {
    param (
        [string]$driveLetter
    )
    $freeSpace = (Get-PSDrive -Name $driveLetter.Substring(0,1)).Free
    $minFreeSpace = 1GB
    if ($freeSpace -lt $minFreeSpace) {
        Log-Activity "A unidade $driveLetter tem menos de 1GB de espaço livre. Por favor, libere espaço antes de executar CHKDSK."
        exit
    }
}

# Função para executar CHKDSK
function Run-CHKDSK {
    param (
        [string]$driveLetter = "C:"
    )

    Log-Activity "Iniciando verificação de disco na unidade $driveLetter..."

    # Comando CHKDSK com opções para verificar e corrigir erros
    $chkdskCommand = "chkdsk $driveLetter /F /R /X"
    
    # Executa o CHKDSK e captura a saída
    try {
        $chkdskOutput = cmd /c $chkdskCommand
        Log-Activity $chkdskOutput
        Log-Activity "Verificação de disco completa. Verifique a saída acima para detalhes."
    }
    catch {
        Log-Activity "Ocorreu um erro ao executar o CHKDSK: $_"
    }
}

# Função para verificar se há uma reinicialização pendente
function Check-PendingReboot {
    $rebootPending = Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\RebootPending" -ErrorAction SilentlyContinue
    if ($rebootPending) {
        Log-Activity "Há uma reinicialização pendente. Por favor, reinicie o computador antes de executar o script novamente."
        exit
    }
}

# Verifica se o usuário está executando o script como administrador
Check-Admin

# Solicita a letra da unidade para verificar
$driveLetter = Read-Host "Digite a letra da unidade que deseja verificar (por exemplo, C:)"

# Verifica se o driveLetter termina com ':'
if ($driveLetter -notmatch ':$') {
    $driveLetter += ":"
}

# Verifica se a unidade existe
if (-not (Test-Path $driveLetter)) {
    Log-Activity "A unidade $driveLetter não existe. Por favor, forneça uma letra de unidade válida."
    exit
}

# Verifica se há uma reinicialização pendente
Check-PendingReboot

# Verifica espaço em disco
Check-DiskSpace -driveLetter $driveLetter

# Executa o CHKDSK na unidade especificada
Run-CHKDSK -driveLetter $driveLetter

Log-Activity "O script terminou a execução. Por favor, revise a saída do CHKDSK acima."
