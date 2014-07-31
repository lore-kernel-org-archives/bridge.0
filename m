Return-Path: <stimits@comcast.net>
Date: Thu, 31 Jul 2014 20:51:06 +0000 (UTC)
From: stimits@comcast.net
Message-ID: <1645433484.36982455.1406839866983.JavaMail.root@comcast.net>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_36982454_1486465939.1406839866981"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1406839867;
	bh=e+MGpjfrsrQWhe64Xa2lAvoyh6/uy/aOjBSttOeCpKA=;
	h=Received:Received:Date:From:To:Message-ID:Subject:MIME-Version:
	Content-Type;
	b=QnRaxtAAjihsO2zDQhdAWezf4FIHq8nhswJnfhPsi9+HuCEbMvJoEdLE0puIo3yHO
	YS8rjJy1RSi3WWBpz/dN+sTAOjZ6r1N2tluriPW3HWrHLNimYIBKGP9bFTIrtFDZ2q
	lfcMzPmC8ybFI/P/MzRIh92vRZ53SjkLQ5yP10rdKgIXsKm5lVqtCtdYLvLHIvmW0X
	NX2Z7Zo92mFbaRCICrFO3GqtaBHuJzo4D7awTb8el+/lNeX0OhpLr752fuwoYBZdp1
	IVd4gBhReQ6Ktl7uqGa0bnBxIPcztaLkXgCQl+pyBd7qXjX4CYPZHqdKXJVme64s8x
	zASqiK4DhR3dw==
Subject: [Bridge] Bridge "address x.x.x.x" Configuration
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

------=_Part_36982454_1486465939.1406839866981
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi,
 
Long ago I used a linux bridge with an IP address bound specifically to one of the two NICs of the bridge. Currently, it seems as though the address configuration cannot be explicitly assigned to just one physical port (I have eth0 and eth1, wanted it bound specifically and only to eth0). I'm hoping this is just a quirk of how my Ubuntu 14.04 LTS is built, and not a limitation of the bridging software. Because I'm binding ports to the bridge, but not binding addresses to ports, I have to bind an address to the bridge as a whole. Using ifconfig after the bridge is up to bind an address directly to a port (independent of the bridge) fails.
 
One of my concerns is that I want the NIC on the "unfriendly" side to have no response to any address. The other concern is that with the current setup, I have a 10:1 latency increase problem using the address assigned, compared to the NIC just having an IP address without bridging. The latency issues are so bad that there is no use in using this for outside world connections. The system itself is ARMv7 embedded, and the two NICs are all that can ever be connected. No hardware flexibility exists for a third NIC to offload this function. Perhaps specifically binding the IP address to one NIC would remove the latency issue? If not, I have to debug and profile the kernel module on ARMv7, which will not be easy.
 
Thanks
------=_Part_36982454_1486465939.1406839866981
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<div>Hi,</div>
<div>&nbsp;</div>
<div>Long ago I used a linux bridge with an IP address bound specifically to one of the two NICs of the bridge. Currently, it seems as though the address configuration cannot be explicitly assigned to just one physical port (I have eth0 and eth1, wanted it bound specifically and only to eth0). I'm hoping this is just a quirk of how my Ubuntu 14.04 LTS is built, and not a limitation of the bridging software. Because I'm binding ports to the bridge, but not binding addresses to ports, I have to bind an address to the bridge as a whole. Using ifconfig after the bridge is up to bind an address directly to a port (independent of the bridge) fails.</div>
<div>&nbsp;</div>
<div>One of my concerns is that I want the NIC on the "unfriendly" side to have no response to any address. The other concern is that with the current setup, I have a 10:1 latency increase problem using the address assigned, compared to the NIC just having an IP address without bridging. The latency issues are so bad that there is no use in using this for outside world connections. The system itself is ARMv7 embedded, and the two NICs are all that can ever be connected. No hardware flexibility exists for a third NIC to offload this function. Perhaps specifically binding the IP address to one NIC would remove the latency issue? If not, I have to debug and profile the kernel module on ARMv7, which will not be easy.</div>
<div>&nbsp;</div>
<div>Thanks</div>
------=_Part_36982454_1486465939.1406839866981--
