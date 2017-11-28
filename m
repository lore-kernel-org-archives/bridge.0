Return-Path: <brandon.carpenter@cypherpath.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cypherpath.com; s=google;
	h=date:from:subject:to:cc:message-id:mime-version;
	bh=iLf+4bacF3VSdy7ZRjDKdN6i+DRpRqaq7vVkgFVmU9U=;
	b=jEyyOZS84SHqgcy0fKhh3O92R3Hi99cmDcHKfXf50nY4kQDbz0bp1vlxUtHarrljoE
	Ob7qn6zR9rAiHRRA/Iq0649+7vGcRZHdlQ68fZDD9qsP691oItpy4aQApILbP1Y/a4Cw
	qYbmu7gXVyE9zeEHHIb+y8Mk4lWh85fDuz3fc=
Date: Tue, 28 Nov 2017 09:21:17 -0800
From: Brandon Carpenter <brandon.carpenter@cypherpath.com>
Message-Id: <1511889677.1204.0@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="=-2uo575ZQ+byBnEeMkCuK"
Subject: [Bridge] Sending 802.1Q packets using AF_PACKET socket on filtered
 bridge forwards with wrong MAC addresses
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org

--=-2uo575ZQ+byBnEeMkCuK
Content-Type: text/plain; charset="US-ASCII"; format=flowed

While attempting to send ARP DAD packets on a bridge device, I noticed 
that hosts attached to the bridge ports were not responding. After 
digging in with tcpdump/wireshark, I noticed that the MAC addresses of 
the packets (the first 12 bytes of the Ethernet frame) were wrong and 
were an exact duplicate of the following 12 bytes (bytes 13-24), but 
only on slave bridge ports. The bridge device itself had the correct 
addresses. Here is an example setup:

> # ip link add br0 type bridge vlan_filtering 1


--
Brandon Carpenter | Software Engineer
Cypherpath, Inc.
400 Columbia Point Drive Ste 101 | Richland, Washington USA
Office: (650) 713-3060


-- 


CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, is 
for the sole use of the intended recipient(s) and may contain proprietary, 
confidential or privileged information or otherwise be protected by law. 
Any unauthorized review, use, disclosure or distribution is prohibited. If 
you are not the intended recipient, please notify the sender and destroy 
all copies and the original message.

--=-2uo575ZQ+byBnEeMkCuK
Content-Type: text/html; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<div id=3D"geary-body"><div>While attempting to send ARP DAD packets on a b=
ridge device, I noticed that hosts attached to the bridge ports were not re=
sponding. After digging in with tcpdump/wireshark, I noticed that the MAC a=
ddresses of the packets (the first 12 bytes of the Ethernet frame) were wro=
ng and were an exact duplicate of the following 12 bytes (bytes 13-24), but=
 only on slave bridge ports. The bridge device itself had the correct addre=
sses. Here is an example setup:</div><div><br></div><blockquote type=3D"cit=
e"># ip link add br0 type bridge vlan_filtering 1</blockquote><br><br></div=
><div id=3D"geary-signature"><div style=3D"white-space: pre;">--
Brandon Carpenter | Software Engineer
Cypherpath, Inc.
400 Columbia Point Drive Ste 101 | Richland, Washington USA
Office: (650) 713-3060
</div></div>
<br>
<img src=3D"https://www.cypherpath.com/img/cypherpath-logo-r-trans-265.png"=
><br><br>CONFIDENTIALITY NOTICE: This e-mail message, including any attachm=
ents, is for the sole use of the intended recipient(s) and may contain prop=
rietary, confidential or privileged information or otherwise be protected b=
y law. Any unauthorized review, use, disclosure or distribution is prohibit=
ed. If you are not the intended recipient, please notify the sender and des=
troy all copies and the original message.
--=-2uo575ZQ+byBnEeMkCuK--

