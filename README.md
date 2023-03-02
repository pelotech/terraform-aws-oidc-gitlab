# aws-oidc-gitlab
Terraform module to configure GitLab runner pipelines with AWS Identity Provider OIDC
This allows GitLab Runners to authenticate against AWS without using any long-lived keys.
This module provisions the necessary role and permissions as defined in the
[official GitLab docs](https://docs.gitlab.com/ee/ci/cloud_services/aws/).

## Multiple repo configuration
This module allows you to create roles for lists of repos(subjects) and policies in the AWS account.
Currently, it only supports policies in the same account as the role being created.
This is helpful for non-mono repo style groups as well as for large organizations where teams have separate repo ownership for the same AWS account.

## Debugging features
The `assume_role_names` input allows you to assume the OIDC role and act as if you were the GitLab runner pipeline. This is very useful for debugging while you're getting things setup. Note: we recommend removing this once you are production ready so that all further changes are only applied via the pipeline.

## Example .gitlab-ci.yml
```yaml
image:
  name: amazon/aws-cli:latest
  entrypoint:
    - '/usr/bin/env'

assume role:
  script:
    - >
      STS=($(aws sts assume-role-with-web-identity
      --role-arn ${ROLE_ARN}
      --role-session-name "GitLabRunner-${CI_PROJECT_ID}-${CI_PIPELINE_ID}"
      --web-identity-token $CI_JOB_JWT_V2
      --duration-seconds 3600
      --query 'Credentials.[AccessKeyId,SecretAccessKey,SessionToken]'
      --output text))
    - export AWS_ACCESS_KEY_ID="${STS[0]}"
    - export AWS_SECRET_ACCESS_KEY="${STS[1]}"
    - export AWS_SESSION_TOKEN="${STS[2]}"
    - aws sts get-caller-identity
```
Note: ROLE_ARN needs to be configured as a CICD environment variable in GitLab.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | ~> 4.0.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | ~> 4.0.3 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aws_oidc_gitlab"></a> [aws\_oidc\_gitlab](#module\_aws\_oidc\_gitlab) | ./modules/aws-roles-oidc-gitlab | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_openid_connect_provider.gitlab](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider) | resource |
| [tls_certificate.gitlab](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/data-sources/certificate) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aud_value"></a> [aud\_value](#input\_aud\_value) | GitLab Aud | `string` | `"https://gitlab.com"` | no |
| <a name="input_gitlab_tls_url"></a> [gitlab\_tls\_url](#input\_gitlab\_tls\_url) | GitLab URL to perform TLS verification against. | `string` | `"tls://gitlab.com:443"` | no |
| <a name="input_gitlab_url"></a> [gitlab\_url](#input\_gitlab\_url) | GitLab URL. | `string` | `"https://gitlab.com"` | no |
| <a name="input_max_session_duration"></a> [max\_session\_duration](#input\_max\_session\_duration) | Maximum session duration in seconds. - by default assume role will be 15 minutes - when calling from actions you'll need to increase up to the maximum allowed hwere | `number` | `3600` | no |
| <a name="input_role_subject-repos_policies"></a> [role\_subject-repos\_policies](#input\_role\_subject-repos\_policies) | role name to repos and policies mapping. role name as the key and object value for repo subjects ie "project\_path:mygroup/myproject:ref\_type:branch:ref:main" as well as a list of policy arns ie ["arn:aws:iam::aws:policy/AdministratorAccess"] and list of roles that can assume the new role for debugging | <pre>map(object({<br>    role_path         = optional(string)<br>    subject_repos     = list(string)<br>    policy_arns       = list(string)<br>    assume_role_names = optional(list(string))<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_gitlab_oidc_provider_arn"></a> [gitlab\_oidc\_provider\_arn](#output\_gitlab\_oidc\_provider\_arn) | oidc provider arn to use for roles/policies |
| <a name="output_gitlab_oidc_provider_url"></a> [gitlab\_oidc\_provider\_url](#output\_gitlab\_oidc\_provider\_url) | oidc provider url to use for roles/policies |
| <a name="output_iam_role_arns"></a> [iam\_role\_arns](#output\_iam\_role\_arns) | Roles that will be assumed by GitLab runner pipelines |
<!-- END_TF_DOCS -->