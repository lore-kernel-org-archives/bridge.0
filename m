Return-Path: <atul14.kumar@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:content-type;
	bh=MigDpr0nh4BpucJEOJb/m2Z2NDOafMwFEnJjMaXCyqc=;
	b=Abe+8ltHBlMpUHqc1MZltKjiJNrDtXDpw7isH/u43OZn793SDqpRf7jZK+3HPe2M81
	0qykbiE5O4/YzOLafPJd81WxqZcN0+bjAgTVuG2FgxgFs5Mf2AYOV5NIdqMowmiFkEap
	lS5tdFkw4f5UYwVhv4fPBae43m/a1ZRWQxZKwBOWTqknZ/FXUz6Qr/US+z1xsAVuc0IR
	rO2D9oW/CenPBJ04zMSNi486blkoOz8XAiqtMtXyGR/G7Ff+FMlT7K8rzArMxouMQ8wa
	63FDYF1z/42HjdU++hy5/F6YoxLRBKVMvLhHbsDuVBbUow82JMoo+pymYLR9LljAxiEw
	Hkrg==
MIME-Version: 1.0
Date: Mon, 24 Dec 2012 20:48:17 +0530
Message-ID: <CAMCE1acYsVSmsCP+hc+xSwuAbgR7p-BPRSk7Ex2C9e4j=Y4NpA@mail.gmail.com>
From: Atul Gupta <atul14.kumar@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bridge] Does linux support per vlan stp
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

I want to connect two pc`s on a redundant way with each other. On
those pc`s a 64 bit ubuntu 11.10 is running with kernel version
3.0.0-16-generic.


Setup1:
----------

PC1:
          PC2:


br0
            br1
|
               |
-- eth0.1000  ---------------------------------------------------eth0.1000
|
               |
__eth1.1001 ----------------------------------------------------eth1.1001




When I enable spanning tree on both bridges (brctl stp br0 on). They
both stay sending BPDU packages and no port is disabled. So I get a
loop. For some reason spanning tree is not working.

Setup2:
---------
When I repeat the following test without the VLANs the spanning tree
protocol is working:

br0                                                                          br1
|                                                                              |
-- eth0  -----------------------------------------------------eth0
|                                                                              |
__eth1 ------ -----------------------------------------------eth1







The problems is that in the final solution I only have vlans, so I need Setup1.


Is spanning tree in Linux possible with VLANS?
If so, how do I have to set-up this?

Thanks,

Atul
