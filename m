Message-ID: <40588C13.1030903@web.de>
Date: Wed, 17 Mar 2004 18:34:11 +0100
From: Michael Renzmann <mrenzmann@web.de>
MIME-Version: 1.0
Subject: Re: [Bridge] bridge wlan-eth
References: <200403171813.58862.mangel@gmx.de>
In-Reply-To: <200403171813.58862.mangel@gmx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: mrenzmann@web.de
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Christoph Kaminski <mangel@gmx.de>
Cc: bridge@lists.osdl.org

Hi.

Christoph Kaminski wrote:
> It works and I can from both sides ping the router with the bridge device but 
> I cant ping the devices from other net so I cant ping wlan devs from eth net 
> and other way around
> 
> the wlan card is an atmel usbw11 from linksys and eth is a intel e100 
> 10/100mbit nic

You'll have two problems:
1. The e100 is said to have a problem with bridging, depending on the 
driver you use.

2. You need to have your wlan device working in a special mode, which is 
not available to the atmel-chipsets afaik. This mode is known under many 
names, such as "Host-AP", "Master-Mode", "AP-Mode" and others. Without 
this mode, you won't be able to bridge between wlan and lan. The only 
way to work around this problem then would be to use proxy arp - afair 
there is a daemon available that cares about the wlan-lan situation in 
context to proxy arp. You should find it when searching freshmeat.net 
with "proxy arp" or thelike.

Bye, Mike
