Message-ID: <006501c40c49$bbf3cec0$7005640a@internal.watertech.com>
From: "Chris Shaw" <chriss@watertech.com>
References: <200403171813.58862.mangel@gmx.de>
Subject: Re: [Bridge] bridge wlan-eth
Date: Wed, 17 Mar 2004 10:00:16 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

I know this is off topic but...

check out the Jouni Malinen's HostAP driver homepage at:

http://hostap.epitest.fi

It enables the special "HostAP" functionality of the Harris/Intersil Prism
2/2.5/3 chipset which allows your card to act as a full AP (and also do
wireless -> ethernet bridging.)

Some Atmels work with this driver, YMMV...

    -Chris


----- Original Message -----
From: "Christoph Kaminski" <mangel@gmx.de>
To: <bridge@lists.osdl.org>
Sent: Wednesday, March 17, 2004 9:13 AM
Subject: [Bridge] bridge wlan-eth


> Hi!
>
> I have some problems with an bridge between wlan0 and eth0 device...
>
> It works and I can from both sides ping the router with the bridge device
but
> I cant ping the devices from other net so I cant ping wlan devs from eth
net
> and other way around
>
> the wlan card is an atmel usbw11 from linksys and eth is a intel e100
> 10/100mbit nic
>
> I have configured the bridge according to the how to and dont see any
errors
> in kern.log or somewhere else....
>
> What is wrong?
>
> PS: sorry for my english but I hope you can understand what I mean
> _______________________________________________
> Bridge mailing list
> Bridge@lists.osdl.org
> http://lists.osdl.org/mailman/listinfo/bridge

