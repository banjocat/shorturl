resource "digitalocean_droplet" "ny_short" {
    name = "short0${count.index + 1}"
    size = "s-1vcpu-1gb"
    image = "ubuntu-18-04-x64"
    region = "nyc3"
    ipv6 = true
    count = "${var.ny_short_count}"
    private_networking = false
    ssh_keys = [
        "c9:37:26:2e:b3:7c:f1:56:1f:72:f0:61:98:61:ed:65"
        ]
    tags = [
        "ny_short",
        "short"
    ]
}

resource "digitalocean_floating_ip" "ny_short" {
    droplet_id = "${element(digitalocean_droplet.ny_short.*.id, count.index)}"
    region = "${digitalocean_droplet.ny_short.region}"
    count = "${var.ny_short_count}"
}


resource "digitalocean_firewall" "short" {
    name = "short"

    tags = [
        "short"
    ]

    droplet_ids = ["${digitalocean_droplet.ny_short.*.id}"]

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
}


resource "ns1_record" "ny_short" {
    zone = "${ns1_zone.brief.zone}"
    domain = "${ns1_zone.brief.zone}"
    type = "A"
    answers {
        answer = "${digitalocean_floating_ip.ny_short.0.ip_address}"
    }
}
