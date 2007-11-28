Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Wed, 28 Nov 2007 08:22:56 -0500
Message-ID: <8A55DBB97B4FBF4D9A6F23C92FE0F117EA43B1@BE08.exg3.exghost.com>
In-Reply-To: <200711261705.lAQH5qT1004343@smtp2.linux-foundation.org>
References: <200711261705.lAQH5qT1004343@smtp2.linux-foundation.org>
From: "Jay Libove" <libove@felines.org>
Content-Transfer-Encoding: 8bit
Subject: [Bridge] RE: BitTorrent crashes Linux firewall running bridging
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Many thanks to Ryan for his comment that multiple Digital Tulip Ethernet
adapters in a system have been known in the past to crack up the kernel.
Looks like that problem still exists.

I hope I'm not speaking too soon and jinxing myself, but last night I
pulled out the single quad Tulip card and replaced it with three
independent Ethernet controllers (of various parentage, none of them
Digital), and have since BitTorrent downloaded a few hundred megabytes
with no crashes at all.


To Stephen, thank you too for replying. I should have been more
specific, you're right. The "Crash" I'm referring to is the whole kernel
going down so hard and fast that nothing even gets left in a memory
buffer to be picked up on reboot. It's as if someone hit the hard reset
switch on the system.

Unfortunately, due to my complex network design, it is difficult to test
with the bridging rules out, because without the bridging rules, I can't
talk through this firewall.  That's because I have a static IP address
range which runs through a Vonage customized not-very-smart bridge/NAT
device which doesn't actually understand how to have one IP address on
its public interface and bridge all other traffic that comes its way. It
doesn't answer ARPs for anything but itself. So, I have to have bridging
rules on the firewall on an interface peeking at the outside segment and
replying to ARPs, so that the packets can get through this Vonage box.
To test without bridging, I'd have to discombobulate the whole darn
network, which I've been trying to avoid.

Hopefully, the problem was just with the Tulip card or drivers.

Thanks again everyone,
-Jay



