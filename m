From: "kingz" <jzhang@cienettechnologies.com>
Date: Mon, 6 Dec 2004 22:28:31 -0800
Message-ID: <000001c4dc25$fcfc7280$0901a8c0@kingz>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: My configuration in Bridge, 802.1Q VLAN,
	and hotmail login, Thanks to all
Reply-To: jzhang@cienettechnologies.com
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: vlan@lanforge.com, bridge@lists.osdl.org, ebtables-user@lists.sourceforge.net
Cc: stuge-vlan@cdy.org, greearb@candelatech.com, bdschuym@pandora.be, shemminger@osdl.org

Hi Peter, Stephen Hemminger, and All

Thanks to Peter, Stephen  for the following reply!

In Peter's reply, he said, when I use e1000 cards as eth0,1, I needn't
change any MTU for eth0/1 and bridge br0. IS my understanding right?

I use Redhat 9.0+ Linux 2.4.28 kernel as bridge box, use the native
bridge code, for e1000 card, I needn't patch any, then I can let VLAN
tag traffic go through my bridge box, IS my understanding right?

Stephen Hemminger: in your reply, when I use the above configuration
(9.0+ Linux 2.4.28 kernel as bridge box, use the native bridge code
without ebtable patch) with e1000 cards, for VLAN tag traffic going
through the bridge, I also need patch something as you wrote, it as if
that your suggestion is not same as Peter's ( see above).
If need patch it, but I can't find where it is patched? Which file? Is
the patch apply to kernel 2.4.28?

Peter, Stephen Hemminger :I am confused. How I do then?

All, any comments, help would be highly appreciated!

Thanks to All!

BR
Kingz


Peter's reply:

On Fri, Dec 03, 2004 at 10:12:39PM -0800, kingz wrote:
> I changed all two NICs on my Bridge box to Intel Pro/1000 MT
> card(with Intel e1000 driver). I think they can handle larger
> frames with VLAN tag. ( Thanks to Ben, Peter)

Correct, they can.


> I also have one doubt: how to configure NICs and my bridge for
> larger frames with VLAN tag?

You don't need to do anything if you are using the e100 and e1000
drivers.


> I guess I need do so: (please correct me)
> Bridge box: Redhat 9.0  Linux 2.4.28 kernel
> 1. Change NICs on bridge MTU to 1504 ( 0r other value)Is it
> necessary?
>   ifconfig eth0(1) mtu 1504
> 
> 2. Change bridge MTU to larger value? ( is it necessary?) 
> I couldn't change the MTU of br0, I got the " SIOCSIFMTU: Invalid
> argument" error. What's wrong with it?

You aren't supposed to change the MTU, and especially not upwards.

If you ARE going to do it, you should change the MTU downwards by at
least 4 on all interfaces in that broadcast domain.

If you aren't confident about the term broadcast domain, please look
it up. Basically everything between two routers is one broadcast
domain. Ie. including switches. It isn't always possible to change
MTU of switchports, making this a suboptimal "solution."


> Hemminger: For this patch in your reply, Do I need apply it to the
> bridge code? As you know, the bridge code is built in the 2.4.28
> kernel, I also need apply this change to bridge code? And a stupid
> question:
> where I apply it to? Which file?

You should not need to patch at all, if you're using the e100 and/or
e1000 drivers.


//Peter




