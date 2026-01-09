# AKS MCP Setup Guide for VS Code

To fully utilize the features demonstrated in this repo, you must configure the **Azure Kubernetes Service (AKS) MCP Server** within your GitHub Copilot environment.

## 1. Install the Azure GitHub Copilot Extension
1. Open **VS Code**.
2. Go to the **Extensions** view (`Ctrl+Shift+X`).
3. Search for and install: **[Azure GitHub Copilot](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azure-github-copilot)**.
   - *Note: This extension provides the underlying rules and tools for Azure-specific MCP operations.*

## 2. Configure MCP Tools
GitHub Copilot uses the Model Context Protocol to call Azure/AKS APIs. Ensure your Copilot configuration includes the AKS MCP server endpoints.

### Automatic Tool Detection
The Azure GitHub Copilot extension automatically registers the following tool categories:
- `mcp_com_microsoft_aks`: Subscription-level management.
- `mcp_aks_mcp_kubectl`: In-cluster operations (resources, diagnostics, workload).
- `mcp_aks_mcp_inspektor_gadget`: eBPF observability components.

## 3. Azure Authentication
Copilot requires a valid Azure context to execute commands.
1. Run `az login` in your terminal.
2. Ensure you have the `aks-preview` CLI extension installed:
   ```bash
   az extension add --name aks-preview
   ```
3. Set your active subscription:
   ```bash
   az account set --subscription <Your-Subscription-ID>
   ```

## 4. Troubleshooting the Setup
If Copilot says it "doesn't have access" to your cluster:
- **Context:** Ensure your `kubeconfig` is updated (`az aks get-credentials`).
- **Permissions:** Your user account needs at least **Azure Kubernetes Service Cluster User Role** or higher.
- **Enabled Labs:** In VS Code Settings, search for `github.copilot.chat.mcp` and ensure the setting is enabled if your version of Copilot requires it.

## 5. Sample Configuration (`settings.json`)
If you are manually adding MCP servers, your configuration might look like this:

```json
{
    "github.copilot.chat.mcp.servers": [
        {
            "id": "aks-mcp",
            "name": "AKS Management",
            "description": "Tools for managing Azure Kubernetes Service and in-cluster resources.",
            "type": "command",
            "command": "node",
            "args": ["path/to/aks-mcp-server/index.js"]
        }
    ]
}
```
*Note: Most users will get these tools automatically by installing the [Azure GitHub Copilot](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azure-github-copilot) extension.*
