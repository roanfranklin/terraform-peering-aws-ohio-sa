# tf-peering-ohio-sa
Terraform ( VPC Peering between Ohio and SA )


### Variables
Verificar o arquivo *variables.tf* em *tf-plan*.

- Leste dos EUA - Ohio 
  - Região: us-east-2
  - CIDR: 10.0.0.0/16
    - subnet AZ1: 10.0.60.0/24
    - subnet AZ2: 10.0.70.0/24

- América do Sul - São Paulo
  - Região: sa-east-1
  - CIDR: 10.1.0.0/16 
    - subnet AZ1: 10.1.80.0/24
    - subnet AZ2: 10.1.90.0/24

### Start
Execute terraform no diretório tf-plan.
```
terraform init
terraform plan
terraform apply
```

#### Obs.
Os diretório *ohio* e *sa* são módulos usados no *tf-plan*
