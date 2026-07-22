# GKE GitOps Platform Demo

This repository demonstrates a multi-environment GitOps deployment model for GKE using Argo CD and Helm, with a structure designed for reusable application charts, shared platform standards, and environment-specific configuration for dev, test, and prod. It shows how Argo CD ApplicationSets, AppProjects, and a shared Helm library chart can be organized to support scalable, production-style Kubernetes delivery for frontend, backend, and agent-based services.

## Repository Structure

- `argocd/` contains the Argo CD bootstrap application, ApplicationSets, and AppProjects.
- `charts/amex-library/` contains shared Helm templates for labels, probes, security context, and resource defaults.
- `apps/frontend/`, `apps/backend/`, and `apps/agents/` contain the service-specific Helm charts and environment values for dev, test, and prod.
- `platform/` is reserved for shared platform services such as MongoDB, Temporal, and Langfuse.

## How Deployments Work

Each service is deployed through Argo CD ApplicationSets that point to a shared Helm chart base and environment-specific values files. CI builds immutable container images, updates the GitOps repository with the new image digest, and Argo CD reconciles the desired state into the target GKE environment. Dev and test are configured for automated sync, while prod is kept approval-driven for controlled releases.

## Key Components

- **Argo CD** manages GitOps-based deployment and environment promotion.
- **Helm** provides reusable chart templates and environment-specific configuration.
- **GKE** is the runtime platform for all workloads.
- **Cloud Build** handles CI, image build, validation, and security checks.
- **Shared platform services** such as MongoDB, Temporal, and Langfuse are managed separately from application charts.

## Environments

- **Dev** uses automated sync with self-heal and prune for fast feedback.
- **Test** uses promotion-based deployment with automated reconciliation after merge.
- **Prod** uses controlled promotion and manual or gated sync for release safety.

## Notes

This repository is a design and implementation demo intended to show GitOps repository organization, Helm chart structure, and Argo CD deployment patterns. Placeholder values such as Git repository URLs, hostnames, image digests, and secret names should be replaced before using this in a real environment.

## Goal

This repository is intended as a practical reference for building secure, repeatable, multi-environment Kubernetes delivery pipelines using GitOps principles.
