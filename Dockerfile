# syntax=docker/dockerfile:1.3-labs

ARG PULUMI_VERSION

# This gets us the Pulumi CLI, as well as current language runtimes
# for Go, Node/TypeScript, Python, and .NET.
FROM pulumi/pulumi:${PULUMI_VERSION}

ARG PULUMICTL_VERSION
ARG GOLANGCI_LINT_VERSION
ARG GORELEASER_VERSION

SHELL ["/bin/bash", "-o", "errexit", "-o", "nounset", "-o", "pipefail", "-c"]

RUN <<EOF
curl \
    --proto "=https" \
    --tlsv1.2 \
    --location \
    --fail \
    --verbose \
    --output "pulumictl.tar.gz" \
    "https://github.com/pulumi/pulumictl/releases/download/v${PULUMICTL_VERSION}/pulumictl-v${PULUMICTL_VERSION}-linux-amd64.tar.gz"
mkdir pulumictl_extraction
tar --extract --gunzip --verbose --directory pulumictl_extraction --file pulumictl.tar.gz
mv pulumictl_extraction/pulumictl /usr/local/bin/pulumictl
chmod a+x /usr/local/bin/pulumictl
rm -Rf pulumictl_extraction
rm pulumictl.tar.gz

# Install golangci-lint
curl --proto "=https" \
    --tlsv1.2 \
    --silent \
    --show-error \
    --fail \
    --location \
    https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh \
| sh -s -- -b "$(go env GOPATH)/bin" "v${GOLANGCI_LINT_VERSION}"

# Install goreleaser
go install "github.com/goreleaser/goreleaser@v${GORELEASER_VERSION}"

EOF

# The default entrypoint of our base image is `pulumi`; we don't
# want that.
ENTRYPOINT []
CMD ["bash"]
