Message-ID: <FD52892BD296D71183B400065BFCB6900BAE5436@il02exm12>
From: Lewis Adam-CAL022 <Adam.Lewis@motorola.com>
Date: Thu, 24 Jun 2004 11:57:30 -0500
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] Interface or Linux crashes when put in bridge mode
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org


Hi all,  let me see if I can explain my problem in an explicable way.  I have written a WLAN driver which runs on a dedicated box (e.g. not a PCMCIA card).  The box is plugged into a client that wants WLAN connectivity via Ethernet.  E.g.:


[        ]     Ethernet     [              ]    RF/WLAN
[ Laptop ]------------------[ WLAN adapter ]-------------
[        ]                  [              ]


For testing, I put two WLAN adapters back-to-back


[        ]     RF/WLAN      [       ]
[ WLAN-1 ]------------------[ WLAN-2]
[        ]                  [       ]


And assigned each WLAN interface and IP address (192.168.0.1 and .2).
Then I started a fast ping with a size above the WLAN MTU (for my test the MTU was set to 500).

ping -s1000 -i0.00001 192.168.0.2 (from .1)

Everything work perfectly!

Now for the problem ...

Next I put each WLAN adapter into bridge mode, tying wlan0 to eth0 on each box.  Note that this is now a layer-2 bridge and hence br0 has no IP address.  I connect a laptop on each WLAN adapter: 


[        ]     Eth     [        ]   RF/WLAN   [        ]     Eth     [         ]
[ Laptop ]-------------[ WLAN 1 ]-------------[ WLAN 2 ]-------------[ Laptop2 ]
[        ]             [        ]             [        ]             [         ]


And I do the same ping as above, but from laptop1 to laptop2.  Regrettably, this causes a kernel crash (appears to be a deadlock somewhere because no oops is output to the serial port).  It is also interesting to note that it does not crash if the ping size is below the WLAN MTU.

So I am hoping somebody can shed some light.  I am not an expert on the Linux bridge code, but I would assume it simply takes the data passed to one interface and gives it to the next; so my WLAN driver should not know or care if the data is coming from a local ping or a ping from another box, cause it should receive the same skb, right?  I am at a total loss to explain it at this time.


Thanks for any help offered!
Adam
