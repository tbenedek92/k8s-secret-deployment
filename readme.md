# Description

The content of this repository can be split into 2 major parts:
- Infrastructure provisioning
- Application deployment


## Infrastructure provisioning

The repo contains definition for a single node kubernetes cluster on Linode. The infrastructure is automatically provisioned with Terraform and GH actions.
With the infrastructure a kubernetes SA is provisioned with the necessary roles.

Also a kubernetes secret object is created when the cluster is deployed, so it could be used in the later deployments. No manual steps are required for the cluster deployment, everything is codified under `infra` folder and in the `.github/workflows/infra.yml` file.
The infrastructure deployment pipeline also deploys the `metrics-server` to the kubernetes cluster as it is required for the horizontal pod autoscaling.

## Application deployment
The deployment is based on `nginxinc/nginx-unprivileged`. The major difference compared to the base nginx image is that by default this image exposes port `8080` instead of `80` therefore it can be run as non-root user. The deployment mounts `API-KEY` as environment variable.
The deployment's pods are exposed with a `NodePort` on port `30218`. Pod Distruption Budget ensures that there will be at least 2 replicas of the pod will always be available on the cluster. 
The HPA object takes care about the scaling. From the [docs](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/#algorithm-details):
```
desiredReplicas = ceil[currentReplicas * ( currentMetricValue / desiredMetricValue )]

```

