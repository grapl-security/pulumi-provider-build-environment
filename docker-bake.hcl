variable "PULUMI_VERSION" {
  default = "3.40.1"
}

variable "PULUMICTL_VERSION" {
  default = "0.0.32"
}

variable "GOLANGCI_LINT_VERSION" {
  # Note: No leading "v"
  default = "1.49.0"
}

variable "GORELEASER_VERSION" {
  # Note: No leading "v"
  default = "1.11.4"
}

group "default" {
  targets = [
    "pulumi-provider-build-environment"
  ]
}

target "pulumi-provider-build-environment" {
  context = "."
  dockerfile = "Dockerfile"
  args = {
    PULUMI_VERSION = "${PULUMI_VERSION}",
    PULUMICTL_VERSION = "${PULUMICTL_VERSION}"
    GOLANGCI_LINT_VERSION = "${GOLANGCI_LINT_VERSION}"
    GORELEASER_VERSION = "${GORELEASER_VERSION}"
  }
  labels = {
    "org.opencontainers.image.authors" = "https://graplsecurity.com"
    "org.opencontainers.image.source"  = "https://github.com/grapl-security/pulumi-provider-build-environment",
    "org.opencontainers.image.vendor"  = "Grapl, Inc."
  }
  tags = [
    "docker.cloudsmith.io/grapl/raw/pulumi-provider-build-environment:${PULUMI_VERSION}"
  ]
}
