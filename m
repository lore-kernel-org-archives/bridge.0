Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=fWQG/k0OVHbooOklcKYlEu2p9kauhgKvczx4e4B0QGY=;
	b=YxvO6ADlounh/ekJMu8wWKqV5AUjyjGGborhRROB4OAIf4g3VocDUl662i8b02SaGI
	7I+li6pLx659r96f+h4awM/MlDssv/b6y49C8ddLsIKc7wGUbGhqu8t5eo0s3rmETq3x
	ik8dbBkEnkCe398CaHV6MTDZICMJdp4euy1oJqGXYmu+nG5f/8mZdM40PjGdigdrwZyu
	zLOzLnlXIeGvu30+2RLhJ6R/U/I91dkP8OzV6gKfvnu/5jqwl5pRALdvM7SCaD3QbKDC
	u55dSkUbqvObDUj6zdPxgN+qzNDAfCGkrAWEUcd84sLPsXRCEWa+gJICmSNlqIrFs6o/
	dqAA==
Date: Tue, 13 Dec 2016 09:41:28 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20161213094128.3fa3f4a5@xeon-e3>
In-Reply-To: <CAAtMjxaGCpd_3axCbinnpDpgR+H3DPn9y+cLabodGiytwckc7A@mail.gmail.com>
References: <CAAtMjxaGCpd_3axCbinnpDpgR+H3DPn9y+cLabodGiytwckc7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Bridge interface not forwarding DHCP-Broadcast
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Balaji J <ping2balaji@gmail.com>
Cc: bridge@lists.linux-foundation.org

On Tue, 13 Dec 2016 21:13:43 +0530
Balaji J <ping2balaji@gmail.com> wrote:

> Hi all,
> 
> I am trying to setup a bridge with 2 interfaces attached to it in Router-1.
> Interface-1: eth1 ==> EoGRE Tunnel interface(gretap) connecting to another
> Router-2 where DHCP server is running.
> Interface-2: eth2 ==> Trying to use DHCP to assign IP for this eth2
> interface from DHCP-Server running on Router-2.
> 
> Basically the setup i am expecting is like:
> (eth2)[Router-1](eth1:100.1.1.1) <----------EoGRE
> Tunnel----->(eth0:100.1.1.254)[Router-2](DHCP-Server)
> 
> Following are the setup i did to check the 1st stage to see if the
> dhcp-discover broadcast is going out of Router-1 over EoGRE tunnel or not.
> But i am not able to achieve the same.
> 
> Can anyone please let me know what is missing here? Thanks in advance.
> 
> Router-1:
> 1) ip link add eogre type gretap local 100.1.1.1 remote 100.1.1.254 ==>
> created gretap with endpoints.
> 2) ip link set eogre up ==> brought the eogre interface up.
> [root@centos]# ifconfig
> eogre     Link encap:Ethernet  HWaddr 9E:25:FC:54:7F:F2
>           inet6 addr: fe80::9c25:fcff:fe54:7ff2/64 Scope:Link
>           UP BROADCAST RUNNING MULTICAST  MTU:1462  Metric:1
>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:6 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:1000
>           RX bytes:0 (0.0 b)  TX bytes:492 (492.0 b)
> 
> eth1      Link encap:Ethernet  HWaddr 08:00:27:3C:FB:14
>           inet addr:100.1.1.1  Bcast:0.0.0.0  Mask:255.255.255.0
>           inet6 addr: fe80::a00:27ff:fe3c:fb14/64 Scope:Link
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:13 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:40 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:1000
>           RX bytes:1398 (1.3 KiB)  TX bytes:4103 (4.0 KiB)
> 
> eth2      Link encap:Ethernet  HWaddr 08:00:27:5E:7F:83
>           BROADCAST MULTICAST  MTU:1500  Metric:1
>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:1000
>           RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
> 3) brctl addbr br0  ==> created bridge interface
> 4) brctl addif br0 eogre ==> attach eogre interface to bridge
> 5) brctl addif br0 eth2 ==> attach eth2 interface to bridge
> 6) sysctl -w net.ipv6.conf.eth2.disable_ipv6=1 ==> disable ipv6 in eth2
> just to avoid unwanted ipv6 signalling messages from it.
> 7) ifconfig eth2 up ==> eth2 iface up with no IP in it yet.
> 8) ifconfig eogre up ==> eogre iface up
> 9) ifconfig br0 up ==> Bridge up.
> 10) brctl show ==>
> bridge name     bridge id               STP enabled     interfaces
> br0             8000.0800275e7f83       no              eogre
> 
>   eth2
> 
> 11) brctl showstp br0
> 
> [root@centos-dev ~]# brctl showstp br0
> br0
>  bridge id              8000.0800275e7f83
>  designated root        8000.0800275e7f83
>  root port                 0                    path cost                  0
>  max age                  19.99                 bridge max age
>  19.99
>  hello time                1.99                 bridge hello time
>  1.99
>  forward delay            14.99                 bridge forward delay
>  14.99
>  ageing time             299.95
>  hello timer               0.50                 tcn timer
>  0.00
>  topology change timer     0.00                 gc timer
> 1.50
>  hash elasticity           4                    hash max                 512
>  mc last member count      2                    mc init query count        2
>  mc router                 1                    mc snooping                1
>  mc last member timer      0.99                 mc membership timer
>  259.96
>  mc querier timer        254.96                 mc query interval
>  124.98
>  mc response interval      9.99                 mc init query interval
>  31.24
>  flags
> 
> 
> eogre (0)
>  port id                0000                    state
>  forwarding
>  designated root        8000.0800275e7f83       path cost                100
>  designated bridge      8000.0800275e7f83       message age timer
>  0.00
>  designated port        8001                    forward delay timer
>  0.00
>  designated cost           0                    hold timer
> 0.00
>  mc router                 1
>  flags
> 
> eth2 (0)
>  port id                0000                    state
>  forwarding
>  designated root        8000.0800275e7f83       path cost                  4
>  designated bridge      8000.0800275e7f83       message age timer
>  0.00
>  designated port        8002                    forward delay timer
>  0.00
>  designated cost           0                    hold timer
> 0.00
>  mc router                 1
>  flags
> 
> 12) dhclient -i eth2 ==> This command triggers a DHCP-DISCOVER
> broadcast(both l2/l3 broadcast destination addressed) from eth2 and
> initiate ip allocation process.
> 
> Now if i capture packets in wireshark in eth1+br0+eogre interface of
> Router-1, i don't see the dhcp-discover packet sent from eth2 interface
> going over EoGRE Tunnel to Router-2.
> But the same DHCP-Discover packet i can see if i capture in eth2
> interface(obvious reason).
> 
> Is it not like whatever packets coming in or originating from eth2 will be
> bridged to eogre interface using bridge "br0"?
> I am using kernel 2.6 in CentOS
> 
> Can someone please help here?
> 
> Regards,
> ...Balaji

You can't and shouldn't try to do anything that assigns an IP address
to a device that is a member of a bridge.  In your case that is eth2.


The correct thing to do is run DHCP client on the bridge device.
