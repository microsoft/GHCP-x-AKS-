# AKS MCP Hands-on Lab: Day 2 Operations

This lab guide provides a series of structured exercises to master AKS management using GitHub Copilot and the Model Context Protocol (MCP).

## Lab Objectives
- Understand how Copilot interacts with Azure and Kubernetes APIs.
- Master infrastructure-level diagnostics.
- Implement eBPF-based observability.
- Resolve common orchestration failures using AI-assisted analysis.

---

## 🏁 Exercise 0: The "Chaos" Initialization
**Time:** 5 minutes  
Before we can fix things, we need to create a realistic "bad" state.

1. **Simulate an Image Repository Error:**
   Break the standard Nginx deployment by forcing it to use a non-existent tag.
   ```bash
   kubectl set image deployment/nginx-sample nginx=nginx:invalid-tag-for-demo --namespace default
   ```

2. **Simulate a Resource Constraint Failure:**
   Create a "Resource Hog" that requests more memory than any node can provide.
   ```bash
   kubectl create deployment resource-hog --image=nginx --namespace default
   kubectl set resources deployment resource-hog --requests=cpu=100,memory=100Gi --namespace default
   ```

---

## 🔍 Exercise 1: Intelligent Inventory & Audit
**Objective:** Use natural language to get a health check of the cloud environment.

1. **Cluster Discovery:**
   Ask Copilot: *"List all my AKS clusters and highlight the one in the 'AKS_training' resource group."*
2. **Infrastructure Audit:**
   Ask Copilot: *"Are there any cost-optimization or security recommendations for my cluster? Check Azure Advisor."*
3. **Deep-Dive:**
   Ask Copilot: *"What is the specific VM Scale Set SKU and OS version used for the 'agentpool' node pool?"*

---

## 📡 Exercise 2: eBPF Observability with Inspektor Gadget
**Objective:** Deploy and utilize advanced kernel-level monitoring.

1. **Verify Tooling:**
   Ask Copilot: *"Is Inspektor Gadget deployed? If not, deploy it to the 'gadget' namespace."*
2. **Networking Trace:**
   Let's check if our failed pods are causing DNS noise.
   Ask Copilot: *"Run the 'observe_dns' gadget in the 'default' namespace for 60 seconds. Tell me if you see any failed queries."*

---

## 🛠️ Exercise 3: AI-Assisted Resolution
**Objective:** Diagnose and fix the issues from Exercise 0 using Copilot's contextual knowledge.

1. **Diagnose the Pending Pod:**
   Ask Copilot: *"Why is the 'resource-hog' pod stuck in Pending? Show me the cluster memory capacity vs. the pod request."*
2. **The "Right-Size" Fix:**
   Ask Copilot: *"Update the 'resource-hog' deployment to use 50m CPU and 64Mi Memory so it can fit on our existing nodes."*
3. **Fix the Image Failure:**
   Ask Copilot: *"The nginx-sample pod has an ImagePullBackOff. Check the events and update the deployment to the correct latest tag."*

---

## 📊 Exercise 4: Final Validation
**Objective:** Verify the cluster is restored to a healthy state.

1. **Health Check:**
   Ask Copilot: *"List all pods in the default namespace. Are they all Running and Ready?"*
2. **Cleanup:**
   Ask Copilot: *"Delete the 'resource-hog' deployment and undeploy Inspektor Gadget to clean up the environment."*

---

## 💡 Key Tips for MCP Success
- **Be Specific:** Mention resource groups and namespaces to narrow the scope.
- **Ask for "Why":** Don't just ask to fix a pod; ask Copilot to explain the root cause first.
- **Chain Commands:** You can ask Copilot to "Find failed pods and then describe the last three events for them."
