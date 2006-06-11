Message-ID: <448C7F02.7000700@freemail.hu>
Date: Sun, 11 Jun 2006 22:37:22 +0200
From: =?UTF-8?B?S3Vuc3p0IMOBcnDDoWQ=?= <kunszt@freemail.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Bridge] 802.1Q tagging
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

	Hi!

I'm new on the list and I'm Hungarian so please forgive my terribly bad
English.
First greetings to all.
I want to create a Linux box which will be act as a rate limiter ( with
tc ) and an IP<->MAC checker ( now iptables on br0 ).
I have three interfaces. Two Gigabits ( eth1 and eth2 ) and 100Mbps (
eth0 ) for management. On the eth1 and eth2 there are approx 60 802.1Q
tagged VLANs so I don't want to create one bridge for every single VLAN.
I want to use one bridge. This is br0.
I set up iptables it's mainly stands lines like -A <chain> -m mac
--mac-source <...> -s <...> -j ACCEPT then DROP without -m mac stuff.
Then I set up tc on eth1 and eth2 using HTB, PRIO and SFQ. The
classifier was U32.
The bridge and the iptables worked ( the counters increased ) . I can
arping from a machine from the eth1 interface to another machine on the
eth2 interface. The tc didn't worked, the classifer didn't matched any
packet ( I used ip dst addr/32 ). I thought this is because the 4 byte
802.1Q header.
I tried to correct this but suddenly the bridge was stopped. ( There
wasn't outgoing traffic on one interface. Only one, the second was okay. )
I'm using Gentoo with 2.6.16-gentoo-r9 kernel.
Did I something wrong? Is this configuration/idea good? Or is there any
fundamental errors? Expected somebody this symptoms?
Any helps or ideas are welcome.
Thanks,

Arpad
