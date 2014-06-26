Return-Path: <mbizon@freebox.fr>
Message-ID: <1403781352.52578.103.camel@sakura.staff.proxad.net>
From: Maxime Bizon <mbizon@freebox.fr>
In-Reply-To: <20140625161335.11598f09@haswell>
References: <1403534015-28496-1-git-send-email-mbizon@freebox.fr>
	<20140625161335.11598f09@haswell>
Content-Type: text/plain; charset="ANSI_X3.4-1968"
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
Subject: Re: [Bridge] [PATCH] bridge: mark packets sent to any local mac
 address as PACKET_HOST
Reply-To: mbizon@freebox.fr
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Thu, 26 Jun 2014 11:15:59 -0000
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net


On Wed, 2014-06-25 at 16:13 -0700, Stephen Hemminger wrote:

> > The bridge code only set PACKET_HOST on packets sent to the bridge mac
> > address, packets sent to other local mac addresses are sent to upper
> > layers, but ignored because they are marked as PACKET_OTHERHOST.
> > 
> > Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
> 
> What are you trying to do? Bridge device itself only has one MAC address.
> Are you trying to run macvlan on top of bridge?
> We only respond to ARP with bridge's MAC address.

host1 uses a bridge with two interfaces: ethernet and wireless (AP mode
using hostapd)

for some reasons, hostapd kept adding and removing the interface from
the bridge, triggering a mac address of the bridge change each time (I
did not notice that).

Another host had a static arp entry for host1, using the ethernet mac
address, so its packets to host1 were randomly trashed depending on the
current mac of the bridge.

I have since fixed this by setting a static mac address on the bridge to
prevent dynamic change, but I thought this patch would prevent other
people from having the same bug in the future.

What do you think ?

-- 
Maxime


