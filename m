Return-Path: <m4rtntns@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:content-type;
	bh=ZfF3usRyBMnQ4A8Uha36vumuHEpiW60fbzU6HtrpWFg=;
	b=VrZFeJXI74XLCu2LbEiJILnBOQHmK9WQOIFwXKLQvCAnfuwVvuUtdz/deDa5e9RFWD
	10pQUzMVsTGlzeL7xnxyo0ZPTYNcMVKbn6h13aX0q0gTQIPmiwuepOG8gjvZVM7kWKdJ
	I3IOLJqk8ujUjxjRMAfwB2YbeD1cUpZdHs+ZUTH1WxRhnuObAnN04j/e7EmvH8kn79x7
	Q4tfHbZNltJnzc5OPhbbQPqubjytKs5VOc83LkpOs44J0PULDxA+YsOltfuTl7beZQKC
	yDguSEHE2a4GFBMt8lYsdINDEC7B0m9284Csuithj/CVGxJ4/BnPhXjxg7IG35NhQWA9
	a16g==
MIME-Version: 1.0
Date: Wed, 25 Mar 2015 11:01:57 +0200
Message-ID: <CAJx5YvG4G-f_u6svYeoCZsY5ZSXutgNz4g89PL8i1RQ==Z+0gg@mail.gmail.com>
From: Martin T <m4rtntns@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Bridge] Are multicast Ethernet frames supported in Linux bridge?
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

I have a network topology where in "Dell PE860" runs a Linux virtual-switch br0:

http://s24.postimg.org/j1un2gs9h/virtual_bridge.png

Now if I send an Ethernet frame to broadcast address from "IBM ThinkCentre":

17:10:23.569021 00:a1:ff:01:02:05 > ff:ff:ff:ff:ff:ff, ethertype IPv4
(0x0800), length 34: 127.0.0.1 > 127.0.0.1:  ip-proto-0 0

..then I see this frame in both virtual-machines as I should. If I
send an Ethernet frame to MAC address which is not known in br0 MAC
address table, then the br0 also behaves correctly and floods the
frame to all ports expect to one where the frame came in(eth1 in this
example). However, if I send a multicast frame from "IBM ThinkCentre":

17:17:05.513283 00:a1:ff:01:02:05 > 01:33:44:55:66:77, ethertype IPv4
(0x0800), length 34: 127.0.0.1 > 127.0.0.1:  ip-proto-0 0

..then for some reason Linux virtual-switch does not flood it to all
the ports(except the one where the frame came in from). Why is that
so? I would expect that switch handles multicast frames exactly like
broadcast frames.


thanks,
Martin
