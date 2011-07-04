From: Alexander Stein <alexander.stein@systec-electronic.com>
Date: Mon, 4 Jul 2011 08:46:44 +0200
References: <201106301033.23997.alexander.stein@systec-electronic.com>
	<20110630100819.0e4b536f@nehalam.ftrdhcpuser.net>
In-Reply-To: <20110630100819.0e4b536f@nehalam.ftrdhcpuser.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201107040846.45016.alexander.stein@systec-electronic.com>
Subject: Re: [Bridge] possible bridge regression in "bridge: implement
	[add/del]_slave ops"?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>

On Thursday 30 June 2011 19:08:19 Stephen Hemminger wrote:
> On Thu, 30 Jun 2011 10:33:23 +0200
> 
> Alexander Stein <alexander.stein@systec-electronic.com> wrote:
> > * echo $(pgrep rstpd) > /var/run/rstpd.pid
> > * brctl addbr br1
> > * echo 1 > /sys/class/net/br1/bridge/stp_state
> 
> This bogus. You are running both kernel and spanning
> tree daemon at the same time!
> 
> Doing the echo of 1 to stp_state forces kernel spanning
> tree. You want 2 which is what is supposed to be use for user
> mode spanning tree.

Well, at first sight you're right. But looking at the code at 
br_stp_set_enabled() in br_stp_if.c it doesn't matter which value you echo 
into stp_state, it just have to be non-zero
The detection of usermode oder kernelmode STP is done using the usermode 
helper (see br_stp_start). I tried echoing 1, 2 or even 5 into stp_state, with 
a working /sbin/bridge-stp I get 2 from stp_state each time.

Maybe it is valuable to change this odd behavior.

Regards,
Alexander
