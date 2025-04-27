# Variables permettant de récupérer automatiquement les valeurs des variables GitLab CI/CD
variable "ARM_SUBSCRIPTION_ID" {
  description = "Nom de la variable GitLab pour le Subscription ID Azure"
  type        = string
}

variable "ARM_CLIENT_ID" {
  description = "Nom de la variable GitLab pour le Client ID (Service Principal) Azure "
  type        = string
}

variable "ARM_CLIENT_SECRET" {
  description = "Nom de la variable GitLab pour le Client Secret du Client ID Azure"
  type        = string
}

variable "ARM_TENANT_ID" {
  description = "Nom de la variable GitLab pour le tenant Azure"
  type        = string
}

# Variables pour le resource group et la région
variable "resource_group_name" {
  description = "Nom du groupe de ressources Azure"
  type        = string
}

variable "location" {
  description = "Emplacement de la ressource Azure"
  type        = string
  default     = "canadaeast"
}

# Variables pour les onfigurations réseau
variable "public_ip_address_space" {
  description = "Plage d'adresses IP du réseau virtuel"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "private_ip_configuration_name" {
  description = "Nom de la configuration du réseau privé"
  type        = string
  default     = "Internal"
}

variable "public_ip_address_prefix" {
  description = "Préfixe d'adresse IP pour le sous-réseau"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}


# Variables pour les configruations de la VM
variable "vm_name" {
  description = "Nom de la machine virtuelle"
  type        = string
}

variable "vm_size" {
  description = "Taille de la machine virtuelle"
  type        = string
}

variable "os_disk_size_gb" {
  description = "Taille du disque OS en Go"
  type        = number
  default     = 30
}

variable "image_publisher" {
  description = "Éditeur de l'image de la VM"
  type        = string
}

variable "image_offer" {
  description = "Offre de l'image de la VM"
  type        = string
}

variable "image_sku" {
  description = "SKU de l'image de la VM"
  type        = string
}

variable "image_version" {
  description = "Version de l'image de la VM"
  type        = string
}

# Variables pour les informations d'accès à la VM
variable "admin_username" {
  description = "Nom de l'utilisateur administrateur de la VM"
  type        = string
  default     = "adminuser"
}

variable "ssh_public_key" {
  description = "Clé publique SSH pour la connexion à la VM"
  type        = string
  sensitive   = true
}

variable "ssh_private_key" {
  description = "Clé privée SSH pour la connexion à la VM"
  type        = string
  sensitive   = true
}

# Variables pour les tags et environnements
variable "environment_tag" {
  description = "Environnement de déploiement (dev, qa, prod)"
  type        = string
  default     = "dev"
}

# Variables pour GitLab
variable "gitlab_url" {
  description = "URL du serveur GitLab"
  type        = string
  default     = "https://gitlab.com"
}

variable "gitlab_runner_token" {
  description = "Token d'enregistrement du GitLab Runner"
  type        = string
  sensitive   = true
}