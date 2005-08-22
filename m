Message-ID: <20050822093430.57927.qmail@web34103.mail.mud.yahoo.com>
Date: Mon, 22 Aug 2005 02:34:30 -0700 (PDT)
From: Zoran s <s_zoran@yahoo.com>
Subject: Re: [BRIDGE]A basic question: what's the relationship of the Rx/Tx
	packets count between the bridge and its enslaved NIC.
In-Reply-To: <20050817092132.3160f383@dxpl.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Steven,

In addition to what Stephen wrote, you can perform
simple tests just assigning the IP address to bridge
interface br0 issuing command:

ifconfig br0 x.y.z.w up

where x.y.z.w is a unused subnet IP address (class C
x.y.z.0) you are bridging.

Then you can ping any member via the bridge and
observe br0, eth0 and eth1 stats, and also you can
ping br0 itself by using ping x.y.z.w command and see
stats as well.

Regards,
Zoran

--- Stephen Hemminger <shemminger@osdl.org> wrote:

> On Tue, 16 Aug 2005 11:40:40 +0800
> Steven Zhang <zhangseven@gmail.com> wrote:
> 
> > I have a bridge br0, it enslaves two NICs: eth0
> and eth1. 
> > By using "cat /proc/net/dev ", i can see the Rx/Tx
> packets and bytes
> > through each interface. just like this:
> 
> 
> 
> > I wonder the meaning of the value of the br0, 
> it's Rx/Tx packets is
> > less than both eth0 and eth1.
> > what's the relationship of the values between
> bridge and it's enslaved NIC?
> > 
> 
> The pseudo-device br0 is used for locally generated
> traffic
> 
> There will be several possible flows through a
> bridge:
> 
> Traffic going from 
> 	eth0 to eth1 will increase eth0:Rx and eth1:Tx
> 	eth1 to eth0               eth1:Rx     eth0:Tx
> Locally transmits to eth0          br0:Tx  and
> eth0:Tx
> Locally received via eth0          br0:Rx  and
> eth0:Rx
> 
> Also, packets generated locally with unknown
> destination
> will be flooded to both eth0 and eth1.
> 
> You get the idea


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
