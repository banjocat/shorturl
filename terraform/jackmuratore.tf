variable ny_jack_count {
    default = 1
}
resource "digitalocean_droplet" "jackmuratore" {
    name = "jack0${count.index + 1}"
    size = "s-1vcpu-1gb"
    image = "ubuntu-18-04-x64"
    region = "nyc3"
    ipv6 = true
    count = "${var.ny_jack_count}"
    private_networking = false
    ssh_keys = [
        "c9:37:26:2e:b3:7c:f1:56:1f:72:f0:61:98:61:ed:65"
        ]
    tags = [
        "jackmuratore",
        "jack"
    ]
}

resource "digitalocean_floating_ip" "jackmuratore" {
    droplet_id = "${element(digitalocean_droplet.jackmuratore.*.id, count.index)}"
    region = "${digitalocean_droplet.jackmuratore.region}"
    count = "${var.ny_jack_count}"
}


resource "digitalocean_firewall" "jack" {
    name = "jack"

    tags = [
        "jack"
    ]

    droplet_ids = ["${digitalocean_droplet.jackmuratore.*.id}"]

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


resource "ns1_record" "jackmuratore" {
    zone = "${ns1_zone.jackmuratore.zone}"
    domain = "${ns1_zone.jackmuratore.zone}"
    type = "A"
    answers {
        answer = "${digitalocean_floating_ip.jackmuratore.0.ip_address}"
    }
}
resource "ns1_record" "jackmuratore_cname" {
    zone = "${ns1_zone.jackmuratore.zone}"
    domain = "*.${ns1_zone.jackmuratore.zone}"
    type = "CNAME"
    answers {
        answer = "${ns1_zone.jackmuratore.zone}"
    }
}
