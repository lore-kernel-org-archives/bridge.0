Date: Fri, 27 Oct 2006 11:21:41 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20061027112141.7b271a0e@freekitty>
In-Reply-To: <565F40B9893580489B94B8D324460AF4E291BF@zmy16exm63.ds.mot.com>
References: <565F40B9893580489B94B8D324460AF4E291BF@zmy16exm63.ds.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] How to bridge a eth0 and usb0 device
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Sun Zongjun-E5739C <E5739C@motorola.com>
Cc: bridge@lists.osdl.org

On Tue, 24 Oct 2006 10:46:20 +0800
"Sun Zongjun-E5739C" <E5739C@motorola.com> wrote:

> 
> Hi
> 
>  I intent to use brctl to bridge two devices on linux box. One is eth0,
> the other is USB net which is recognized as usb0 by linux box.
> 
>  Then I run following command 
> 
> # ifconfig eth0 down
> # ifconfig usb0 down
> # brctt addbr ipbr
> # brctl addif ipbr eth0
> # brctl addif ipbr usb0
> 
> # ifconfig eth0 up
> # ifconfig eth0 0.0.0.0
> # ifconfig usb0 up
> # ifconfig usb0 0.0.0.0
> 
> # ifconfig ipv6 up
> 
>                           eth0            usb0
> 192.168.16.2
> Box1<----------------> Linux bridge <----------------------> Box
> 
> Then I connet another device into the eth0 interface of bridge. Its ip
> address is 192.168.16.1, the device on the othe end of usb lan is
> 192.168.16.2
> 
> When I ping 192.168.16.2 from 192.168.16.1. The tcpdump on bridge is
> message of ARP "who has 192.168.16.2 tell 192.168.16.1", but I neve see
> the ARP reply why?
> 
> Thanks
> Best Regards
> 

You forgot to bring ipbr up in your example?
 Unless ipv6 is a typo for ipbr

Are the mac addresses being picked up?

You probably want to set forwarding delay to 0 (or wait 30 secs)
before testing.
 # brctl setfd ipbr 0



-- 
Stephen Hemminger <shemminger@osdl.org>
