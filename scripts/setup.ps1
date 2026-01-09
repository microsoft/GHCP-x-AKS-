# AKS MCP Demo: Setup & Cleanup Script

param (
    [Parameter(Mandatory=$false)]
    [switch]$Clean
)

$namespace = "default"

if ($Clean) {
    Write-Host "Cleaning up Demo resources..." -ForegroundColor Cyan
    
    # Reset nginx-sample to healthy state
    Write-Host "Restoring nginx-sample..."
    kubectl set image deployment/nginx-sample nginx=nginx:latest --namespace $namespace
    
    # Delete resource-hog
    Write-Host "Deleting resource-hog..."
    kubectl delete deployment resource-hog --namespace $namespace --ignore-not-found
    
    Write-Host "Cleanup complete!" -ForegroundColor Green
    exit
}

Write-Host "Initializing 'Chaos' state for AKS MCP Demo..." -ForegroundColor Yellow

# 1. Break nginx-sample with invalid tag
Write-Host "Phase 0.1: Breaking nginx-sample image tag..."
kubectl set image deployment/nginx-sample nginx=nginx:invalid-tag-for-demo --namespace $namespace

# 2. Create Resource Hog Pod (stuck in Pending)
Write-Host "Phase 0.2: Creating resource-hog deployment with impossible requirements..."
kubectl create deployment resource-hog --image=nginx --namespace $namespace 2>$null
kubectl set resources deployment resource-hog --requests=cpu=100,memory=100Gi --namespace $namespace

Write-Host "`nSetup Complete! Your cluster is now in a 'bad' state." -ForegroundColor Green
Write-Host "Use GitHub Copilot to diagnose and fix the issues."
Write-Host "Refer to AKS-Demo/EXERCISES.md for the lab guide."
