From: "Lefti C" <lefti_99@hotmail.com>
Date: Sat, 25 Sep 2004 00:33:33 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY1-F99IJsaJbqJGNz000630d4@hotmail.com>
Subject: [Bridge] problem with Honeynet Project's rc.firewall script
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Bridge@lists.osdl.org

Hi all,

I'm new to the world of bridging and the mailing list but I am hopeful my 
initial problems are fairly trivial.  I am running the Honeynet Project's 
rc.firewall script at boot time (on my Sparc running Aurora) but the script 
is having trouble establishing the bridge.

In my logs, I have found the following error:

tSIOCSIFADDR : No such device
eth1: unknown interface: No such device

Meanwhile my eth0 interface is successfully negotiated.
I am unsure as to why my second interface has not been initialised and I am 
hoping you guys can help.

My second interface does have a link light on the hub, but I havent 
configured anything since installing the NIC.  I just plugged it in and 
tried to get going.
Do I need to configure the second NIC, or does Linux know that it is 
there?!!

Many thanks,

Lefti

_________________________________________________________________
Stay in touch with absent friends - get MSN Messenger 
http://www.msn.co.uk/messenger

