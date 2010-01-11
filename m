Date: Mon, 11 Jan 2010 10:18:48 -0800
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20100111101848.38fad04f@nehalam>
In-Reply-To: <0B4BAD7651DDBF4CB463FDBCA36C673F108C64BE@EXCHANGE.claremont.globaldial.com>
References: <0B4BAD7651DDBF4CB463FDBCA36C673F108C64BE@EXCHANGE.claremont.globaldial.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] MAC intermittently being learnt on wrong port
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ryan King <ryank@staff.globaldial.com>
Cc: "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>

On Fri, 8 Jan 2010 03:25:10 +0000
Ryan King <ryank@staff.globaldial.com> wrote:

> Hi,
> 
> I am seeing a strange issue with a fairly simple bridge I have setup (for openvpn in bridge mode).
> 
> eth0 ---  [ openvpn machine  (tap0) ] --- eth1
> 
> The bridge is between tap0 and eth1 on a debian machine running on ESX 4.  (tap0 being the openvpn tunnel interface).  Intermittently, I see openvpn client MAC addresses on port 2 (eth1).  When this happens, their vpn link stops working, since arp replies are being sent back via the wrong interface.  But after a random amount of time, it will change back to port 1 (tap0) and start working again.  Sometimes this is quick, sometimes it doesn't happen for hours.
> 
> Anyone else had these issues?  I've searched the archives, and come across several people who seem to have had similar problems - but haven't found one that has a solution yet.
> 
> I'd appreciate any suggestions on where I should start looking to find out why/how these MAC's are being learnt on the wrong interface...
> 

By default the address of the bridge interface is the minimum of all the interfaces,
and the tap one is generated randomly; that might be your problem.
So either:
   1. force a specific MAC address on the tap interface
or 2. force the the MAC address of the bridge interface to be that of eth
 
