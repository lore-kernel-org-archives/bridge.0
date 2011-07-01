Date: Fri, 1 Jul 2011 12:08:33 +0200
From: David Lamparter <equinox@diac24.net>
Message-ID: <20110701100833.GA3988422@jupiter.n2.diac24.net>
References: <201106301033.23997.alexander.stein@systec-electronic.com>
	<20110630100819.0e4b536f@nehalam.ftrdhcpuser.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110630100819.0e4b536f@nehalam.ftrdhcpuser.net>
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
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>, Alexander Stein <alexander.stein@systec-electronic.com>

On Thu, Jun 30, 2011 at 10:08:19AM -0700, Stephen Hemminger wrote:
> On Thu, 30 Jun 2011 10:33:23 +0200
> Alexander Stein <alexander.stein@systec-electronic.com> wrote:
> 
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

I just tested this on my box, you can't echo 2 into that sysfs file (it
reads back as 1).

That you can change this variable at all when an userspace stp
implementation is running is a bug anyway, IMHO. rstpd should do all the
required settings and the kernel should prevent them from being changed
while rstpd has the bridge under its control.


-David

