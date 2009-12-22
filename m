Message-ID: <4B31354D.3080805@navigue.com>
Date: Tue, 22 Dec 2009 16:08:29 -0500
From: Jonathan Thibault <jonathan@navigue.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Bridge] ebtables/iptables ambiguity
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

I am trying to use connmark based on the bridge output port.

Normally, I would:

...
iptables -t mangle -A VMARK -i out -m physdev --physdev-out in.15 -j MARK --or-mark 0x00F
...
iptables -t mangle -A VMARK -j CONNMARK --save-mark

(VMARK is called in -t mangle POSTROUTING)

But since this traffic is routed and not bridged, I get the expected:

"physdev match: using --physdev-out in the OUTPUT, FORWARD and POSTROUTING chains for non-bridged traffic is not supported anymore."

Now I could use ebtables to perform the mark in, say, filter FORWARD, but would it know which member interface the packets are going if the traffic is not being bridged?  And if so, would the mark appear in time for me to -j CONNMARK --save-mark in POSTROUTING/VMARK?

I obviously could try it to see if it works, but I'd rather *understand* what I'm doing first ;)

Jonathan
