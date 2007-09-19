Date: Wed, 19 Sep 2007 08:24:56 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: Re: [Bridge] Arp & Bridge
Message-ID: <20070919082456.69882e04@freepuppy.rosehill.hemminger.net>
In-Reply-To: <46F132FA.8050501@mediatvcom.com>
References: <46F132FA.8050501@mediatvcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Martin <dmartin@mediatvcom.com>
Cc: bridge@lists.linux-foundation.org

On Wed, 19 Sep 2007 16:32:26 +0200
David Martin <dmartin@mediatvcom.com> wrote:

> here is my bridge config :
> Let say br0 containing eth0 and eth1, with br0 IP adress is 192.168.0.10
> 
> For some reasons, I would like to be able to send packet from the bridge 
> machine, only via a specific device.
> Thus, I set IP adress for eth0 and eth1 (let's say 192.168.0.11 and 
> 192.168.0.12).
> I know a bridge is not supposed to have IP adress on the interfaces..
>  ___________________________
> | br0 (192.168.0.10)                |
> |  +---   eth0  (192.168.0.11)   --------------------------- ethernet 
> wire --------------------- 192.168.0.1
> |  +---   eth1  (192.168.0.12)   ----------------------------ethernet 
> wire --------------------- 192.168.0.254
> |___________________________|
> 
> But when I try to send packet's from only one device, it does not work.
> ie : ping -I eth0 192.168.0.1  gives no response.
> 
> I noticed that arp are sent and received by eth1, but they are of course 
> received by br0 too.
> So the arp table is completed for br0 but not for eth1...
> 
> The question is :
> Why does br0 update the arp table, but eth1 doesnt? how is the arp table 
> are updated? eth1 is the one sending the request!
> Is there any mean to solve that?

If you need to limit arp responses checkout arp_filter sysctl and
stop doing the wierdness with IP addresses.

If you are trying to do some form of security (or ISP workarounds)
investigate using filtering (ebtables) to do it.


-- 
Stephen Hemminger <shemminger@linux-foundation.org>
