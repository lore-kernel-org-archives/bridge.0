DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
	bh=8hB2l3IDWSt0dzvDD4pMRWPpyQ2gyap/LyZ9+90qr9Y=;
	b=DWxzK7jN5sCB0Bh+RtnboOuDAkqe1yeci5Jls0DyOwg9xqoTBUmF5MTuDBaaL2YkMbdb7Ljep8gfMdT8AW4GJ3+FcNb1ZyBZ5T9NmUlrsjTjFR2FQJI4GwEFZ4kJ/MskyvDWq98u6Kwuem8NMA/CCu+IT8vKzrrIbZRmNvB4z8Y=
Message-ID: <2e59e6970801232217h26a11499h112e0e049e553c84@mail.gmail.com>
Date: Thu, 24 Jan 2008 06:17:41 +0000
From: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
Subject: Re: [Bridge] trying to bridge eth0 & usb0 but arp requests go to the
	wrong network
In-Reply-To: <Pine.LNX.4.62.0801182226450.20707@wadonga.seg>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.62.0801182226450.20707@wadonga.seg>
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: andreas@bunten.de
Cc: bridge@lists.linux-foundation.org

On Jan 18, 2008 9:35 PM,  <andreas@bunten.de> wrote:
> Hello,
>
> I'm trying to get bridging to work between eth0 and usb0:
>
> 192.168.13.2  <--->  br0:192.168.13.47  <---> 192.168.13.1
>                       usb0         eth0
>
> 192.168.13.2:~ # ping 192.168.13.1
> ... 100 % packet loss
>
> On 192.168.13.1 I do see the arp requests but no icmp packet :-/
>
> Just like "No traffic gets trough (except ARP and STP)" in the
> FAQ on http://www.linux-foundation.org/en/Net:Bridge
>
> Except ...
>
> I can ping 192.168.13.1 from the bridge (192.168.13.47)
> Trying to ping 192.168.13.2 from the bridge does not work
> I do see the arp requests for 192.168.13.2 on 192.168.13.1 (!)
>
> I get the same result if if enable STP on the bridge.
>
> What is going wrong here? :-/
>
> Any hint appreciated!
>
> Regards,
> andreas
>
>
> PS: The bridge system is a SUSE 10.2 with kernel 2.6.18.8-0.7-default
> (incl. suse patches) usb0 is a MosChip usb nic using the mcs7830 driver
> and eth0 is an on board intel nic. both work fine in non bridging mode.
>
> my routing table (just ignore the vmnet stuff):
>
> bibo:/proc/sys/net/ipv4 # route -n
> Kernel IP routing table
> Destination  Gateway      Genmask       Flags Metric Ref Use Iface
> 10.0.0.0     0.0.0.0      255.255.255.0 U     0      0     0 vmnet8
> 192.168.13.0 0.0.0.0      255.255.255.0 U     0      0     0 br0
> 10.0.10.0    0.0.0.0      255.255.255.0 U     0      0     0 vmnet1
> 127.0.0.0    0.0.0.0      255.0.0.0     U     0      0     0 lo
> 0.0.0.0      192.168.13.1 0.0.0.0       UG    0      0     0 br0
>
> Filtering is not enabled as far as I can see:
>
>    bibo:/proc/sys/net/bridge # ls
>    bridge-nf-call-arptables  bridge-nf-call-iptables
>    bridge-nf-call-ip6tables  bridge-nf-filter-vlan-tagged
>    bibo:/proc/sys/net/bridge # cat *
>    0
>    0
>    0
>    0
>    bibo:/proc/sys/net/bridge #
>
>    # iptables -vnL
>    Chain INPUT (policy ACCEPT 842 packets, 683K bytes)
>    pkts bytes target     prot opt in     out     source  destination
>    Chain FORWARD (policy ACCEPT 0 packets, 0 bytes)
>    pkts bytes target     prot opt in     out     source  destination
>    Chain OUTPUT (policy ACCEPT 885 packets, 98734 bytes)
>    pkts bytes target     prot opt in     out     source  destination
>
> How I set up the bridge:
>
>    # ifconfig usb0 0.0.0.0 down
>    # ifconfig eth0 0.0.0.0 down

I've always had the best luck bringing bridge member interfaces "up"
(but with no IP address).

On my system, which uses the newer networking utilities, that would be

ip link set usb0 up
ip link set eth0 up

Also I configure the bridge IP address and bring it up before adding
slave interfaces, but I don't think the order should matter.

>    # brctl addbr br0
>    # brctl addif br0 eth0
>    # brctl addif br0 usb0
>    # ifconfig br0 192.168.13.47 up
>    # brctl show br0
>    bridge name   bridge id               STP enabled     interfaces
>    br0           8000.000d6080dcd6       no              eth0
>                                                          usb0
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>
