param(
  [Parameter(ValueFromRemainingArguments = $true)]
  [string[]]$TerraformArgs
)

if (-not $TerraformArgs -or $TerraformArgs.Count -eq 0) {
  Write-Host "Usage: .\run-terraform.ps1 <terraform-command>"
  Write-Host "Example: .\run-terraform.ps1 init"
  exit 1
}

docker run --rm `
  -v "${PWD}:/workspace" `
  -w /workspace `
  -e TF_CLI_CONFIG_FILE=/workspace/yc.tfrc `
  hashicorp/terraform:1.6.6 @TerraformArgs
