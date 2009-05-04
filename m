Message-ID: <49FF4AF8.1050801@free.fr>
Date: Mon, 04 May 2009 22:07:20 +0200
From: =?ISO-8859-1?Q?Nicolas_de_Peslo=FCan?= <nicolas.2p.debian@free.fr>
MIME-Version: 1.0
References: <20090428124009.GA26387@kallisti.us>	<2e59e6970904281200u44e3ebbfga0f074dfaa78c1ab@mail.gmail.com>	<49F77248.1050800@gmail.com>	<2e59e6970904281600u42142392vb8e0eb45c4ede15c@mail.gmail.com>	<49F87D4E.4060705@gmail.com>
	<20090429162651.GA9455@kallisti.us>	<49F882F9.4010100@gmail.com>
	<20090429165329.GA9893@kallisti.us>	<49F8C4C3.9020504@gmail.com>	<2e59e6970904292118u71ff441ft19448f753c1b6dd9@mail.gmail.com>
	<db99f77d0904292330n4c460ccbv45e60f06bfa49c4@mail.gmail.com>
	<49FA1E28.5020604@free.fr> <49FC4764.3030707@gmail.com>
	<49FDD890.1090302@free.fr> <49FF41C4.4090404@gmail.com>
In-Reply-To: <49FF41C4.4090404@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Ubuntu: network bridging between wireless and wired
 connection fails
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jochen Hebbrecht <jochenhebbrecht@gmail.com>, bridge@lists.linux-foundation.org

Jochen Hebbrecht wrote:
> Maybe my picture isn't very clear, but my WAN access is on location A. 
> There's a router which receives an ip from the ISP. On the other side, 
> I'm having a 192.168.1.0/24 network

> $ cat /etc/network/interfaces
> auto lo
> iface lo inet loopback
> 
> auto eth1
> iface eth1 inet manual
> wpa-driver wext
> wpa-ssid ##SSID##
> wpa-ap-scan 1
> wpa-proto RSN
> wpa-pairwise CCMP
> wpa-group CCMP
> wpa-key-mgmt WPA-PSK
> wpa-psk ##PSK KEY##
> 
> auto br0
> iface br0 inet static
> bridge_ports eth1
> address 192.168.1.111
> netmask 255.255.255.0
> gateway 192.168.1.1
> 

> $ ping 192.168.1.1
> PING 192.168.1.1 (192.168.1.1) 56(84) bytes of data.
>  From 192.168.1.111 icmp_seq=2 Destination Host Unreachable
>  From 192.168.1.111 icmp_seq=3 Destination Host Unreachable
>  From 192.168.1.111 icmp_seq=5 Destination Host Unreachable
>  From 192.168.1.111 icmp_seq=6 Destination Host Unreachable
> 
> So here it goes wrong. I didn't execute any other steps as step 2 fails 

I think that the "Destination Host Unreachable" is caused by some sort 
of "down link", because wpa_supplicant failed to establish the wifi 
link. When eth1 is part of the br0, packets received on eth1 is 
"forwarded" to br0 and not available on eth1. So wpa_supplicant must be 
instructed to listen for incoming packets on br0, not on eth1.

Can you try the exact same configuration, adding wpa-bridge br0 in the 
eth1 stanza, to inform wpa_supplicant where to listen from ?

auto lo
iface lo inet loopback

auto eth1
iface eth1 inet manual
wpa-driver wext
wpa-ssid ##SSID##
wpa-ap-scan 1
wpa-proto RSN
wpa-pairwise CCMP
wpa-group CCMP
wpa-key-mgmt WPA-PSK
wpa-psk ##PSK KEY##
wpa-bridge br0          <--- HERE.

auto br0
iface br0 inet static
bridge_ports eth1
address 192.168.1.111
netmask 255.255.255.0
gateway 192.168.1.1

If this fail, please provide the output of i_w_config eth1 and arp -an.

	Nicolas.
