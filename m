Message-ID: <4154B668.4080400@jxvf.net>
Date: Sat, 25 Sep 2004 02:06:00 +0200
From: Fredrik Laestadius <lists@jxvf.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] problem, vlan and a bridge.
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hello world.

I'm new to this list so bare with me.

I have a procurve 2424m with 3 vlans configured.
I get the internet from another procurve that is connected to vlan1, and 
the bridge is connected between vlan1 and vlan2 (doing some filtering here)

So, internet > vlan1 > bridge > vlan2

The problem is that I get a packet loss between 30% and 70% and the logs 
on the bridge looks okay, same with the logs on the procurve.

The bridge works like a charm if I use another switch instead of vlan1.
like this: Internet > another switch > bridge > vlan2
Internet > vlan1 > bridge > another switch gives the same positive result.

The bridge is actually configured to serve as both a bridge between 2 
vlans and as a NAT-box for another vlan with workstations, dont think 
that is relevant to this problem though.
I used to use a router between those 2 vlans to filter, that also worked.

Any clues on where to even start looking? It might be a problem with the 
switch, but I might as well ask here.

Oh, and the vlans are all untagged, and there is no stp running on the 
switch.

Cheers, Fredrik Laestadius. .se
