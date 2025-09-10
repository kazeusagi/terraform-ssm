# 複数環境対応 Terraform Makefile

# 環境のリスト
ENVIRONMENTS = usecase-1 usecase-3

# 各環境用のターゲットを動的生成する関数
define make-env-targets
# $(1) は環境名（dev, staging, prodなど）

# init
$(1)-init:
	@echo "=== $(1) 環境の初期化 ==="
	terraform -chdir=terraform/environments/$(1) init

# plan
$(1)-plan:
	@echo "=== $(1) 環境の実行計画 ==="
	terraform -chdir=terraform/environments/$(1) plan

# apply
$(1)-apply:
	@echo "=== $(1) 環境への適用 ==="
	terraform -chdir=terraform/environments/$(1) apply

# destroy
$(1)-destroy:
	@echo "=== $(1) 環境の削除 ==="
	terraform -chdir=terraform/environments/$(1) destroy

.PHONY: $(1)-init $(1)-plan $(1)-apply $(1)-destroy
endef

# 各環境に対してターゲットを生成
$(foreach env,$(ENVIRONMENTS),$(eval $(call make-env-targets,$(env))))

ssh:
	ssh -i ~/app/.ssh/usecase-1-key.pem ec2-user@$(shell cat ~/app/.ssh/usecase-1-ip.txt)

ssm:
	aws ssm start-session --target $(shell cat ~/app/.ssm/usecase-1-instance-id.txt)

.PHONY: test ssh ssm
