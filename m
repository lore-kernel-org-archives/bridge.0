Return-Path: <brandon.carpenter@cypherpath.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cypherpath.com; s=google;
	h=mime-version:from:date:message-id:subject:to:cc;
	bh=ZWzTBxb2nh0+Ab76iOs+B5ttC2Q+OUaxQesLXb8CsNM=;
	b=TKjmNGHB/fc/AB+bPVPu/IGtCImWVB3GUWKYBgtGzZahUpsCHkKTOZ4bwEpgtiDcz4
	mfhHW1ronujNC+uLmh2sqWZ48I5bvPKkLvxdWyY5nDM6Bs+J5iY2wK4CC7zkm+DD0jIv
	dndpsGzfv0se398Rm9u7QxYndZJQonlh1pGVo=
MIME-Version: 1.0
From: Brandon Carpenter <brandon.carpenter@cypherpath.com>
Date: Tue, 28 Nov 2017 11:11:20 -0800
Message-ID: <CAPpVWGuVsUP-4Ty7db4DQueL23yjPBMPG4+1Ui+OBTjfUHmVVg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

While attempting to send ARP DAD packets on a bridge device, I noticed
that hosts attached to the bridge ports were not responding. After
digging in with tcpdump/wireshark, I noticed that the MAC addresses of
the packets (the first 12 bytes of the Ethernet frame) were wrong and
were an exact duplicate of bytes 14-25 (zero-based), but only on slave
bridge ports. The bridge device itself has the correct addresses. Here
is an example setup:

   # uname -a
   Linux servo 4.13.12-1-ARCH #1 SMP PREEMPT Wed Nov 8 11:54:06 CET
2017 x86_64 GNU/Linux
   # ip -V
   ip utility, iproute2-ss171113
   # bridge -V
   bridge utility, 0.0

   # ip link add br0 type bridge vlan_filtering 1
   # ip link add veth0 type veth peer name veth1
   # sysctl -wq net.ipv6.conf.{br0,veth{0,1}}.disable_ipv6=1  #
Eliminate IPv6 noise
   # ip link set veth0 master br0
   # bridge vlan add dev br0 vid 1 self
   # bridge vlan add dev veth0 vid 1
   # ip link set veth0 up
   # ip link set veth1 up
   # ip link set br0 up


The following Python script sends a DAD probe on the given interface:

   import socket
   import sys

   ifname = sys.argv[1]

   frame = (b"\xff\xff\xff\xff\xff\xff\xaa\xbb\xcc\xdd\xee\xff\x81\x00"
 # Ethernet header
            b"\x00\x01\x08\x06"   # 802.1Q header with VID 1 and ARP ethertype
            # DAD Request for 10.11.12.13
            b"\x00\x01\x08\x00\x06\x04\x00\x01"
            b"\xaa\xbb\xcc\xdd\xee\xff\x00\x00\x00\x00"
            b"\xff\xff\xff\xff\xff\xff\x0a\x0b\x0c\x0d")

   with socket.socket(socket.AF_PACKET, socket.SOCK_RAW, 0) as sock:
       sock.sendto(frame, (ifname, 0x8100))   # ETH_P_8021Q


Save the script above to arping.py and send a probe on the bridge
device while snooping the bridge ports:

   # python3 arping.py br0


In one terminal:

   # tcpdump -envli br0 -xx
   tcpdump: listening on br0, link-type EN10MB (Ethernet), capture
size 262144 bytes
   10:20:18.591728 aa:bb:cc:dd:ee:ff > ff:ff:ff:ff:ff:ff, ethertype
802.1Q (0x8100), length 46: vlan 1, p 0, ethertype ARP, Ethernet (len
6), IPv4 (len 4), Request who-has 10.11.12.13 (ff:ff:ff:ff:ff:ff) tell
0.0.0.0, length 28
      0x0000:  ffff ffff ffff aabb ccdd eeff 8100 0001
      0x0010:  0806 0001 0800 0604 0001 aabb ccdd eeff
      0x0020:  0000 0000 ffff ffff ffff 0a0b 0c0d

and another:

   # tcpdump -envli veth0 -xx
   tcpdump: listening on veth0, link-type EN10MB (Ethernet), capture
size 262144 bytes
   10:20:18.591736 08:00:06:04:00:01 > 00:01:08:06:00:01, ethertype
802.1Q (0x8100), length 46: vlan 1, p 0, ethertype ARP, Ethernet (len
6), IPv4 (len 4), Request who-has 10.11.12.13 (ff:ff:ff:ff:ff:ff) tell
0.0.0.0, length 28
      0x0000:  0001 0806 0001 0800 0604 0001 8100 0001
      0x0010:  0806 0001 0800 0604 0001 aabb ccdd eeff
      0x0020:  0000 0000 ffff ffff ffff 0a0b 0c0d


Doing `python3 arping.py veth1` has the expected results, with all MAC
addresses set correctly. The problem also disappears after turning
VLAN filtering off or sending without the VLAN tag. It is just this
one combination of sending VLAN-tagged packets on a AF_PACKET socket
via the filtered bridge master device that causes the incorrect MAC
addresses on slave bridge ports. I also tried with a unicast Ethernet
address and SOCK_DGRAM socket and saw the same result.

I looked through the bridge code, but didn't see anything obvious. I
don't do much kernel programming and haven't touched it in years, so
I'm not sure what to look for. I first suspected it had to do with
pushing/pulling the head of sk_buff clones, but I didn't see anything
that concerned me. And so I am bringing it to the attention of the
experts. I am willing to poke around and test things, if you can just
point me in the right direction.

Thanks in advance and sorry for any previous messages I accidentally
sent. My email app was being stupid. And I may have pressed the wrong
key combination.

Brandon

-- 


CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, is 
for the sole use of the intended recipient(s) and may contain proprietary, 
confidential or privileged information or otherwise be protected by law. 
Any unauthorized review, use, disclosure or distribution is prohibited. If 
you are not the intended recipient, please notify the sender and destroy 
all copies and the original message.
