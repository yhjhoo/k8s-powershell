# k8s powershell


```powershell
New-ModuleManifest -Path k8s.psd1 -Author 'Huajie Yang' -CompanyName 'Prince Limited' -RootModule 'k8s.psm1' -FunctionsToExport @('') -Description 'k8s powershell'

Publish-Module -Path ./ -Repository PSGallery -NuGetApiKey "apikey"
```
