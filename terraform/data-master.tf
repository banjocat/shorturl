resource "digitalocean_droplet" "data" {
    name = "data-master"
    size = "s-1vcpu-1gb"
    image = "ubuntu-18-04-x64"
    region = "nyc3"
    ipv6 = true
    private_networking = false
    ssh_keys = [
        "c9:37:26:2e:b3:7c:f1:56:1f:72:f0:61:98:61:ed:65"
        ]
    tags = [
        "data"
    ]
}

resource "digitalocean_floating_ip" "data" {
    droplet_id = "${digitalocean_droplet.data.id}"
    region = "${digitalocean_droplet.data.region}"
}

resource "digitalocean_firewall" "data" {
    name = "data"

    droplet_ids = ["${digitalocean_droplet.data.*.id}"]
    tags = [
        "data"
    ]

    outbound_rule {
        protocol = "tcp"
        port_range = "1-65535"
        destination_addresses = ["0.0.0.0/0", "::/0"]
    }

    outbound_rule {
        protocol = "udp"
        port_range = "1-65535"
        destination_addresses = ["0.0.0.0/0", "::/0"]
    }

    outbound_rule {
        protocol                = "icmp"
        destination_addresses   = ["0.0.0.0/0", "::/0"]
    }

    inbound_rule {
        protocol                = "icmp"
        source_addresses   = ["0.0.0.0/0", "::/0"]
    }

    inbound_rule {
        protocol = "tcp"
        port_range = "443"
        source_addresses = ["0.0.0.0/0", "::/0"]
    }

    inbound_rule {
        protocol = "tcp"
        port_range = "80"
        source_addresses = ["0.0.0.0/0", "::/0"]
    }

    inbound_rule {
        protocol = "tcp"
        port_range = "22"
        source_addresses = ["0.0.0.0/0", "::/0"]
    }

    inbound_rule {
        protocol = "tcp"
        port_range = "5432"
        source_tags = [
            "short"
        ]
    }

    inbound_rule {
        protocol = "tcp"
        port_range = "5432"
        source_tags = [
            "jack"
        ]
    }
}

resource "ns1_record" "data-master" {
    zone = "${ns1_zone.shortcurl.zone}"
    domain = "${ns1_zone.shortcurl.zone}"
    type = "A"
    answers {
        answer = "${digitalocean_floating_ip.data.0.ip_address}"
    }
}

resource "ns1_record" "data01-data-master" {
    zone = "${ns1_zone.shortcurl.zone}"
    domain = "data01.${ns1_zone.shortcurl.zone}"
    type = "A"
    answers {
        answer = "${digitalocean_floating_ip.data.0.ip_address}"
    }
}

resource "ns1_record" "www-data-master" {
    zone = "${ns1_zone.shortcurl.zone}"
    domain = "www.${ns1_zone.shortcurl.zone}"
    type = "CNAME"
    answers {
        answer = "${ns1_zone.shortcurl.zone}"
    }
}


