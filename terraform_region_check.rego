package terraform_region_check

default allow = true

# Niega si el provider no es us-east-1
deny[msg] {
    provider := input.provider_configurations[_]
    provider.type == "aws"
    provider.configuration.region != "us-east-1"
    msg := sprintf("El provider AWS debe usar la región us-east-1 (Virginia), se encontró %v", [provider.configuration.region])
}

# Si hay algún mensaje en deny, allow pasa a ser falso
allow = false {
    count(deny) > 0
}