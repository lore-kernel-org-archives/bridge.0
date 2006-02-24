Message-ID: <00f701c63945$10dc7d90$4a27b3d5@tungemaskin>
From: =?utf-8?Q?J=C3=B8rgen_Hovland?= <jorgen@hovland.cx>
References: <01f701c63728$6203bef0$4a27b3d5@tungemaskin><20060221141743.32d66879@localhost.localdomain><003101c6378b$f5f65060$4a27b3d5@tungemaskin><20060222080250.363d5e30@localhost.localdomain><005601c63854$a2fdace0$0f01a8c0@tungemaskin>
	<20060223102731.5756f778@localhost.localdomain>
Subject: Re: [Bridge] physical interface on a bridge
Date: Fri, 24 Feb 2006 14:20:22 +0100
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8"; reply-type=original
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bridge@lists.osdl.org


----- Original Message ----- 
From: "Stephen Hemminger" <shemminger@osdl.org>


>
> The old way is to do ioctl() SIOCDEV_PRIVATE with BRCTL_GET_BRIDGES
> and that gives a table of ifindices, you can use that to map port -> 
> ifindex -> etherdevice
>
> Newer way is to look in directory:
> /sys/class/net/brX/brif
> It has symlinks to the devices that are being bridged.
> /sys/class/net/eth0/brport/port_id
> contains the portid of eth0 in what ever bridge it is in.
>

Works perfectly.
Thanks

Joergen 

