Date: Wed, 17 Mar 2004 09:40:19 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] bridge wlan-eth
Message-Id: <20040317094019.1e52bea9@dell_ss3.pdx.osdl.net>
In-Reply-To: <200403171813.58862.mangel@gmx.de>
References: <200403171813.58862.mangel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Wed, 17 Mar 2004 18:13:58 +0100
Christoph Kaminski <mangel@gmx.de> wrote:

> Hi!
> 
> I have some problems with an bridge between wlan0 and eth0 device...
> 
> It works and I can from both sides ping the router with the bridge device but 
> I cant ping the devices from other net so I cant ping wlan devs from eth net 
> and other way around
> 
> the wlan card is an atmel usbw11 from linksys and eth is a intel e100 
> 10/100mbit nic
> 
> I have configured the bridge according to the how to and dont see any errors 
> in kern.log or somewhere else....
> 
> What is wrong?
> 
> PS: sorry for my english but I hope you can understand what I mean
> _______________________________________________
> Bridge mailing list
> Bridge@lists.osdl.org
> http://lists.osdl.org/mailman/listinfo/bridge



More info in bridge FAQ
	http://bridge.sourceforge.net/faq.html

It doesn't work with my Wireless card!
This is a known problem, and it is not caused by the bridge code. Many wireless cards don't allow spoofing of the source address. It is a firmware restriction with some chipsets. You might find some information in the bridge mailing list archives to help.
-- 
Stephen Hemminger 		mailto:shemminger@osdl.org
Open Source Development Lab	http://developer.osdl.org/shemminger
