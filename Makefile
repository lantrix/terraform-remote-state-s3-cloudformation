stack_name                := terraform-state
stack_managed_policy_name := terraform-state-managed-policy
stack_region              := ap-southeast-2
no_color                  := \033[0m
ok_color                  := \033[32;01m

.PHONY: deploy-policy
deploy-policy: $(workspace)
	@echo "\n$(ok_color)====> Deploying Terraform state managed policy stack$(no_color)"
	aws cloudformation deploy \
		--stack-name $(stack_managed_policy_name) \
		--template-file stack-managed-policy.template \
		--capabilities CAPABILITY_NAMED_IAM \
		--region $(stack_region) \
		--no-fail-on-empty-changeset

.PHONY: deploy
deploy: $(workspace)
	@echo "\n$(ok_color)====> Deploying Terraform remote state stack$(no_color)"
	aws cloudformation deploy \
		--stack-name $(stack_name) \
		--template-file stack.template \
		--region $(stack_region) \
		--no-fail-on-empty-changeset
