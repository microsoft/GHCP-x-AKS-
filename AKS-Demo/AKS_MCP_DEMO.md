# AKS MCP Server Demo with GitHub Copilot

This demo highlights the capabilities of the Azure Kubernetes Service (AKS) MCP server. It demonstrates how GitHub Copilot can assist with "Day 2" operations such as discovery, optimization, deep-dive analysis, observability, and resource management.

## Prerequisites
- An active Azure Subscription.
- An existing AKS Cluster.
- GitHub Copilot Chat with the AKS MCP server enabled.

## Demo Scenario
You are a DevOps engineer responsible for maintaining the health and performance of an AKS cluster. You will use GitHub Copilot to perform various tasks without leaving your IDE.

### Phase 0: Orchestrating the "Break" (Setup)
**Goal:** Intentionally break the cluster to demonstrate troubleshooting capabilities.

1.  **Create an Image Pull Error:**
    *   **Action:** Run this in your terminal:
        ```bash
        kubectl set image deployment/nginx-sample nginx=nginx:invalid-tag-for-demo --namespace default
        ```
2.  **Create a Resource Scheduling Issue:**
    *   **Action:** Run this in your terminal:
        ```bash
        kubectl create deployment resource-hog --image=nginx --namespace default
        kubectl set resources deployment resource-hog --requests=cpu=100,memory=100Gi --namespace default
        ```

### Phase 1: Discovery & Inventory
**Goal:** Understand the current state of your AKS resources.

1.  **List AKS Clusters:**
    *   **Prompt:** "List all my AKS clusters in the current subscription."
    *   **Tool Used:** `mcp_com_microsoft_aks` (list)
    *   **Outcome:** Copilot retrieves a list of clusters with their resource IDs and locations.

2.  **Get Cluster Details:**
    *   **Prompt:** "Show me the details for the AKS cluster named 'testcluster' in resource group 'AKS_training'."
    *   **Tool Used:** `mcp_com_microsoft_aks` (get)
    *   **Outcome:** Detailed JSON metadata about the cluster (provisioning state, version, etc.).

### Phase 2: Optimization & Best Practices
**Goal:** Identify cost-saving opportunities and security improvements.

3.  **Check Advisor Recommendations:**
    *   **Prompt:** "Are there any high-severity Azure Advisor recommendations for my AKS cluster 'testcluster'?"
    *   **Tool Used:** `mcp_aks_mcp_az_advisor_recommendation`
    *   **Outcome:** A summary of recommendations (e.g., "Buy Reserved Instances", "Upgrade Kubernetes version").

### Phase 3: Deep Dive Infrastructure Analysis
**Goal:** Inspect the underlying infrastructure (VM Scale Sets) managed by AKS.

4.  **Get Node Pool VMSS Details:**
    *   **Prompt:** "Get the VMSS configuration for the 'agentpool' node pool in cluster 'testcluster'."
    *   **Tool Used:** `mcp_aks_mcp_get_aks_vmss_info`
    *   **Outcome:** Low-level details about the VM Scale Set backing the node pool (SKU, capacity, upgrade policy) which are often hard to find in the standard AKS view.

### Phase 4: Real-time Observability (Inspektor Gadget)
**Goal:** Debug a potential network issue or monitor activity.

5.  **Deploy Inspektor Gadget (if not installed):**
    *   **Prompt:** "Check if Inspektor Gadget is deployed on my cluster. If not, deploy it."
    *   **Tool Used:** `mcp_aks_mcp_inspektor_gadget_observability` (is_deployed, deploy)

6.  **Monitor DNS Traffic:**
    *   **Prompt:** "Run the 'observe_dns' gadget on the 'default' namespace for 30 seconds to check for failed DNS queries."
    *   **Tool Used:** `mcp_aks_mcp_inspektor_gadget_observability` (run)
    *   **Outcome:** A stream or summary of DNS queries occurring in the cluster, helping identify resolution issues.

### Phase 5: Resource Management
**Goal:** Modify Kubernetes resources directly.

7.  **Label a Pod:**
    *   **Prompt:** "Add the label 'environment=demo' to the pod 'nginx-deployment-xyz' in the default namespace."
    *   **Tool Used:** `mcp_aks_mcp_kubectl_metadata` (label)
    *   **Outcome:** The pod is updated with the new label.

### Phase 6: Troubleshooting & Break-Fix Scenarios
**Goal:** Diagnose and resolve the issues created in Phase 0.

8.  **Diagnose Pending Pods (Resource Hog):**
    *   **Scenario:** The `resource-hog` pods are stuck in `Pending`.
    *   **Prompt:** "Why is the 'resource-hog' pod in the default namespace stuck in Pending? Check the cluster capacity."
    *   **Fix Prompt:** "Update the 'resource-hog' deployment to use reasonable resources (e.g., 100m CPU and 128Mi Memory)."

9.  **Debug Image Pull Errors (Nginx Sample):**
    *   **Scenario:** `nginx-sample` has an `ImagePullBackOff` error.
    *   **Prompt:** "Check the status of pods in the default namespace. Why is 'nginx-sample' failing?"
    *   **Fix Prompt:** "The image tag 'invalid-tag-for-demo' is wrong. Update the 'nginx-sample' deployment to use the 'latest' tag."

10. **Analyze Control Plane Logs:**
    *   **Scenario:** You suspect an issue with the Kubernetes API server or authentication.
    *   **Prompt:** "Check the 'kube-apiserver' logs for the last 10 minutes for any 401 or 403 errors."
    *   **Tool Used:** `mcp_aks_mcp_az_monitoring` (control_plane_logs)
    *   **Outcome:** Copilot retrieves and summarizes relevant log entries, highlighting potential RBAC or identity issues.

### Phase 7: Cleanup
**Goal:** Restore the cluster to its original state.

11. **Remove Demo Resources:**
    *   **Prompt:** "Delete the 'resource-hog' deployment in the default namespace."
    *   *Action:* Copilot deletes the deployment.

12. **Undeploy Inspektor Gadget:**
    *   **Prompt:** "Undeploy Inspektor Gadget from my cluster."
    *   *Action:* Copilot removes the Inspektor Gadget components.

13. **Remove Labels:**
    *   **Prompt:** "Remove the 'environment' label from the nginx pod we modified earlier."
    *   *Action:* Copilot removes the label.

## Conclusion
This demo showcases how the AKS MCP server bridges the gap between high-level Azure management and low-level Kubernetes operations, all within the natural language interface of GitHub Copilot.
