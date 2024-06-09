# CheckDiskScript
Script PowerShell para verificar e corrigir erros de disco no Windows. Automatiza a verificação de integridade usando CHKDSK, verifica permissões de administrador, reinicializações pendentes, e solicita a letra da unidade. Verifica o espaço em disco e registra atividades em log para análise.


# CheckDiskScript

## Descrição

Este repositório contém um script PowerShell para verificar e corrigir erros de disco no Windows. O script automatiza o processo de verificação de integridade dos discos, utilizando o comando CHKDSK, e inclui diversas verificações adicionais para garantir que o processo seja executado de forma segura e eficiente.

## Funcionalidades

- Verifica se o script está sendo executado com permissões de administrador.
- Verifica se há reinicializações pendentes antes de iniciar a verificação do disco.
- Solicita ao usuário a letra da unidade a ser verificada.
- Verifica se a unidade especificada existe.
- Verifica o espaço livre na unidade antes de executar o CHKDSK.
- Executa o CHKDSK com opções para verificar e corrigir erros.
- Registra todas as atividades em um arquivo de log para análise posterior.

## Pré-requisitos

- Windows PowerShell
- Permissões de administrador para executar o script

## Como Usar

Abra o PowerShell como Administrador:

Clique no menu Iniciar.
Digite PowerShell.
Clique com o botão direito do mouse em "Windows PowerShell" e selecione "Executar como administrador".

1. **Clone o repositório:**
   ```bash
   git clone https://github.com/dir9123/CheckDiskScript.git
   cd CheckDiskScript

Execute o script:
./chkdsk.ps1

Siga as instruções:


Digite a letra da unidade que deseja verificar (por exemplo, C:).


Estrutura do Script
Funções
Check-Admin: Verifica se o script está sendo executado com permissões de administrador.
Log-Activity: Registra atividades em um arquivo de log.
Check-DiskSpace: Verifica o espaço livre na unidade especificada.
Run-CHKDSK: Executa o comando CHKDSK na unidade especificada.
Check-PendingReboot: Verifica se há reinicializações pendentes no sistema.


Exemplo de Saída

Digite a letra da unidade que deseja verificar (por exemplo, C:): C
Iniciando verificação de disco na unidade C:...
CHKDSK está verificando arquivos (etapa 1 de 5)...
Verificação de disco completa. Verifique a saída acima para detalhes.
O script terminou a execução. Por favor, revise a saída do CHKDSK acima.
