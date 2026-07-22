# GKE GitOps Platform Demo

This repository demonstrates a GitOps delivery model using Argo CD, Helm, and environment-specific promotion across dev, test, and prod.

## Structure

- `bootstrap/` contains the Argo CD root application.
- `argocd/applicationsets/` contains environment-specific ApplicationSets.
- `apps/` contains application deployment definitions for frontend, backend, and agents.
- `platform/` contains shared platform components such as MongoDB, Temporal, and Langfuse.
- `charts/` contains a shared Helm library chart and per-component charts.

## Delivery model

- Dev uses auto-sync, self-heal, and prune.
- Test is promoted by Git PR and synced after merge.
- Prod is promoted by Git PR with approval and controlled sync.

## Helm approach

- One chart per deployable unit.
- One shared library chart for common labels and standards.
- Environment differences are handled through `dev-values.yaml`, `test-values.yaml`, and `prod-values.yaml`.

## Shared services

MongoDB, Temporal, and Langfuse are managed as standalone platform components rather than being embedded inside application charts.

## Promotion flow

1. CI builds immutable images.
2. CI updates GitOps values for dev.
3. Argo CD syncs dev.
4. The same artifact is promoted to test by PR.
5. The same artifact is promoted to prod by approval-based PR.

