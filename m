Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Wed, 13 Jun 2007 18:28:07 -0700
Message-ID: <63CB92BFF23FC54A8CF2F4A67654B24601F5D163@i-worx-srv-02.i-worx.ca>
From: "Roman Lisagor" <RLisagor@wurldtech.com>
Content-Transfer-Encoding: 8bit
Subject: [Bridge] Trouble with bridged interfaces
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@osdl.org

Hi,

We need to bridge several interfaces together, but still retain the
ability to communicate through the individual interfaces. So for
example, we have eth0 and eth1 bridged and we bind IP addresses to both
of them, in order to inject packets into communication between two
devices connected to our interfaces.

It seems that several problems arise intermittently:

1. When sending ping requests, replies sometimes come in on eth0/1, but
sometimes on br0. We can work around this, but it would be great to get
some idea of why and when this happens (and possibly whether we can
prevent it from occurring);

2. Occasionally, ARP requests sent by external devices for the IPs of
eth0/1 are ignored.

We are running Fedora Core 6 (2.6.13-15-smp).
Any ideas?
 
Thanks in advance for your help.

Roman

