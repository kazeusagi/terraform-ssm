# 複数環境対応 Terraform Makefile

# 環境のリスト
ENVIRONMENTS = usecase-1

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

# fmt
$(1)-fmt:
	@echo "=== $(1) 環境のフォーマット ==="
	terraform -chdir=terraform/environments/$(1) fmt -recursive

# validate
$(1)-validate:
	@echo "=== $(1) 環境の検証 ==="
	terraform -chdir=terraform/environments/$(1) validate

# clean
$(1)-clean:
	@echo "=== $(1) 環境のクリーンアップ ==="
	rm -rf terraform/environments/$(1)/.terraform
	rm -f terraform/environments/$(1)/terraform.tfstate.backup
	rm -f terraform/environments/$(1)/.terraform.lock.hcl

.PHONY: $(1)-init $(1)-plan $(1)-apply $(1)-destroy $(1)-fmt $(1)-validate $(1)-clean
endef

# 各環境に対してターゲットを生成
$(foreach env,$(ENVIRONMENTS),$(eval $(call make-env-targets,$(env))))
