# Création du groupe de ressources
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Configuration du réseau
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.vm_name}-vnet"
  address_space       = var.public_ip_address_space
  location            = var.location
  resource_group_name = var.resource_group_name
}

# Ajout d'un sous-réseau

resource "azurerm_subnet" "subnet" {
  name                 = "${var.vm_name}-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = "${var.vm_name}-vnet"
  address_prefixes     = var.public_ip_address_prefix
}

# Ajout d'une IP publique
resource "azurerm_public_ip" "vm_ip" {
  name                = "${var.vm_name}-public-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Création du groupe de sécurité réseau (NSG)
resource "azurerm_network_security_group" "nsg" {
  name                = "${var.vm_name}-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "Allow_SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow_HTTP"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow_HTTPS"
    priority                   = 1003
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow_All_Outbound"
    priority                   = 1004
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
  }
}

# Création de l'interface du réseau privé
resource "azurerm_network_interface" "nic" {
  name                = "${var.vm_name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = var.private_ip_configuration_name
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm_ip.id # Exemple de récupération dynamique de la valeur
  }
}

# Création de la machine virtuelle Linux
resource "azurerm_linux_virtual_machine" "vm" {
  name                  = var.vm_name
  location              = var.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.nic.id]
  size                  = var.vm_size
  admin_username        = var.admin_username

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = var.os_disk_size_gb
  }

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }

  computer_name                   = var.vm_name
  disable_password_authentication = true

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_public_key
  }

  tags = {
    environment = var.environment_tag
  }

  depends_on = [
    azurerm_subnet.subnet,
    azurerm_network_security_group.nsg
  ]
}

# Association NSG à l'interface réseau
resource "azurerm_network_interface_security_group_association" "nic_nsg_assoc" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# Installation et enregistrement de GitLab Runner avec GITLAB_RUNNER_TOKEN
resource "null_resource" "install_gitlab_runner" {
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = var.admin_username
      private_key = base64decode(var.ssh_private_key)
      host        = azurerm_public_ip.vm_ip.ip_address
    }

    inline = [
      "echo 'Installation de l'agent GitLab Runner...'",
      "sudo apt update -y",
      "sudo apt install -y curl git",
      "curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh | sudo bash",
      "sudo apt install -y gitlab-runner",
      "which gitlab-runner || { echo 'Agent GitLab Runner non installé !'; exit 1; }",

      "echo 'Activation de l'agent GitLab Runner...'",
      "sudo systemctl enable gitlab-runner",
      "sudo systemctl start gitlab-runner",
      "sudo systemctl status gitlab-runner --no-pager",

      "echo 'Enregistrement du GitLab Runner...'",
      "sudo gitlab-runner register --non-interactive --url '${var.gitlab_url}' --token '${var.gitlab_runner_token}' --executor 'shell' --description 'Azure Runner' --tag-list 'azure,terraform' --run-untagged='true' --locked='false' --access-level='not_protected'",

      "sudo systemctl restart gitlab-runner",
      "echo 'GitLab Runner enregistré avec succès !'"
    ]
  }
}