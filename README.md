# AKS MCP: Azure Kubernetes Service Management with GitHub Copilot

Welcome to the **AKS MCP Demo** repository. This project is designed to showcase the power of the **Model Context Protocol (MCP)** when integrated with GitHub Copilot to manage Azure Kubernetes Service (AKS) clusters directly from VS Code.

## 🚀 Overview

Traditional Kubernetes management often requires switching between the Azure Portal, CLI, and `kubectl`. This demo illustrates a "Single Pane of Glass" approach, where GitHub Copilot acts as an intelligent assistant for:

- **Discovery & Inventory:** Quickly listing and inspecting Azure resources.
- **Observability:** Deploying and using eBPF tools like **Inspektor Gadget** for runtime analysis.
- **Maintenance:** Auditing cluster health via **Azure Advisor**.
- **Troubleshooting:** Identifying and fixing common errors like `ImagePullBackOff` and `Pending` pods.
- **Infrastructure Deep-Dives:** Accessing low-level VMSS details that standard tools often abstract away.

## 📁 Repository Structure

- `AKS-Demo/`: Contains the core demo collateral.
  - `EXERCISES.md`: A structured, hands-on workshop guide.
  - `AKS_MCP_DEMO.md`: The original demo script and scenario summary.
  - `SETUP_GUIDE.md`: Instructions for configuring the AKS MCP server in VS Code.
- `scripts/`: Automation scripts to prepare the cluster for the demo.
- `nginx-deployment.yaml`: Sample deployment used for testing.

## 🛠️ Prerequisites

1. **VS Code** with the following extensions:
   - [GitHub Copilot](https://marketplace.visualstudio.com/items?itemName=GitHub.copilot)
   - [GitHub Copilot Chat](https://marketplace.visualstudio.com/items?itemName=GitHub.copilot-chat)
   - [Azure Accounts](https://marketplace.visualstudio.com/items?itemName=ms-vscode.azure-account)
2. **Active Azure Subscription** with an existing AKS cluster.
3. **AKS MCP Server** enabled in your GitHub Copilot configuration.

## 🚥 Getting Started

1. **Provision the Demo:** Navigate to the [Detailed Exercises](AKS-Demo/EXERCISES.md) to begin the setup phase where you'll intentionally "break" a cluster to simulate real-world troubleshooting.
2. **Configure Copilot:** Follow the [Setup Guide](AKS-Demo/SETUP_GUIDE.md) and watch the [Official Setup Video](https://youtu.be/ZFKgFmkg8jQ?si=82n6SDCVePHd__tZ) to ensure your VS Code environment is MCP-ready.
3. **Run the Demo:** Walk through the phases described in `AKS_MCP_DEMO.md`.

## 🛡️ License
This project is for educational and demonstration purposes. See [LICENSE](LICENSE) for details.
