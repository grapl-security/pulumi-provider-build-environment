.DEFAULT_GOAL = all

.PHONY: all
all: lint-docker
all: image
all: # Run all tasks

.PHONY: lint-docker
lint-docker: ## Lint Dockerfiles
	./pants --filter-target-type=docker_image lint ::

.PHONY: image
image: ## Build the container image
	docker buildx bake

.PHONY: image-push
image-push: ## Build *and* push the container image to a repository
	docker buildx bake --push
