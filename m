Message-ID: <4B313D6F.600@free.fr>
Date: Tue, 22 Dec 2009 22:43:11 +0100
From: =?ISO-8859-1?Q?Nicolas_de_Peslo=FCan?= <nicolas.2p.debian@free.fr>
MIME-Version: 1.0
References: <4B31354D.3080805@navigue.com>
In-Reply-To: <4B31354D.3080805@navigue.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] ebtables/iptables ambiguity
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jonathan Thibault <jonathan@navigue.com>
Cc: bridge@lists.linux-foundation.org

Jonathan Thibault wrote:
> I am trying to use connmark based on the bridge output port.
> 
> Normally, I would:
> 
> ...
> iptables -t mangle -A VMARK -i out -m physdev --physdev-out in.15 -j MARK --or-mark 0x00F
> ...
> iptables -t mangle -A VMARK -j CONNMARK --save-mark
> 
> (VMARK is called in -t mangle POSTROUTING)
> 
> But since this traffic is routed and not bridged, I get the expected:
> 
> "physdev match: using --physdev-out in the OUTPUT, FORWARD and POSTROUTING chains for non-bridged traffic is not supported anymore."
> 
> Now I could use ebtables to perform the mark in, say, filter FORWARD, but would it know which member interface the packets are going if the traffic is not being bridged?  And if so, would the mark appear in time for me to -j CONNMARK --save-mark in POSTROUTING/VMARK?
> 
> I obviously could try it to see if it works, but I'd rather *understand* what I'm doing first ;)

If you want to try and understand the relation between ebtables and routing, have a look at 
http://ebtables.sourceforge.net/br_fw_ia/br_fw_ia.html and in particular at the nice picture at the 
end : http://ebtables.sourceforge.net/br_fw_ia/PacketFlow.png

'hope this helps.

	Nicolas.
