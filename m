Return-Path: <wolfhumble@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to
	:content-transfer-encoding;
	bh=4lB45NiryKlsh6m1nM+X3Jti98XK0+2dioMCDAn+ONk=;
	b=vSjvuXCmIBP0b9nhTPI2DWz9KEIGtrFFsJu8mGcBh0HSwox8HOL3SYuD9wlEXKHhoP
	2HetaoBhd3v1uWlXd7qZIFKyFS1xqa7DQ+gWYJEG5Gxq3V3Sh9Q9XQtFgC7+kFTzMbqo
	Lz/aTEADYDLL+F9Z+LHVD2D3N+ROPZ/HZpPax85nB+BHN2v98a5AK2APoVwva0uZERqu
	+T6jc2/E94WdkgCLedcbz1qF9v7TvgPkQBlkEJtJ4cOzl0X64yNV4UuVjwZqvDE/GXrf
	56C7Xi7sEVYdhh+5wqq65T4X4roh/PEnLRCzAQD0Yghv8MyqI/zZ6zKYSHjJLkNf0Rpf
	YkQQ==
MIME-Version: 1.0
From: Wolf Humble <wolfhumble@gmail.com>
Date: Mon, 29 Jan 2018 22:41:52 +0100
Message-ID: <CAE-gC+8affYow7rwZ6d6Cg9AzvtRcgAz3ekkExmjegzeSe7Y8w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Bridge] Setting up 2 bridges on 2 network adapters
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi,

I have two network cards and the devices, ip addresses and gateways
are as following:
eth1 =E2=80=93 ip1: aaa.189.aaa.254 - GW: aaa.189.aaa.253
eth1 =E2=80=93 ip2: bbb.143.bbb.214 - GW: bbb.143.bbb.213

eth2 =E2=80=93 ip3: ccc.170.ccc.202  - GW: ccc.170.ccc.201
eth2 =E2=80=93 ip4: ddd.180.ddd.101 - GW: ddd.180.ddd.100

As the interfaces are in different broadcast domains I have learned,
via the libteam list, that I cannot join these two together with any
link aggregation like teaming or bonding.

I will therefore set up two bridges:,
* eth1 in br1 for the IP addresses ip1 and ip2 above
* eth2 in br2 for the IP addresses ip3 and ip4 above

I will be using ip1 to control the host machine, and ip2 - ip4 for KVM VMs.

I have a few questions that I hope you can help me with:

1) Since ip1 only will be used for administrating the host machine,
whereas ip2 - ip4 will be used for the VMs, should br1 be set up any
differently than br2?

2) Would it be better to move ip2 over to br2? If yes, should ip1
still be connected to br1 or should I rather drop br1 and set its IP
address directly on the ethernet adapter itself, e.g. within
ifcfg-eno1 (Centos)?

3) Given two bridges, and initial setup shown above:
Since the machine has only one default route, e.g:
[#] ip route
default via aaa.189.aaa.253 dev br1 proto static metric 425
...

Is it better for the VMs to go via a GW on br2 rather than br1, or
does this not have any effect for the VMs?


4) I have seen examples where the bridge is set up with the following
bridging options for VMs:

[#] cat network-scripts/ifcfg-br0
=E2=80=A6
BRIDGING_OPTS=3Dpriority=3D32768
=E2=80=A6

a) Is that used, or should I rather skip it?
b) Is there good, basic setup I could follow when setting up a bridge
to use for VMs?

Thanks for you comments!


Wolf
