Date: Thu, 30 Jun 2011 10:08:19 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20110630100819.0e4b536f@nehalam.ftrdhcpuser.net>
In-Reply-To: <201106301033.23997.alexander.stein@systec-electronic.com>
References: <201106301033.23997.alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>

On Thu, 30 Jun 2011 10:33:23 +0200
Alexander Stein <alexander.stein@systec-electronic.com> wrote:

> * echo $(pgrep rstpd) > /var/run/rstpd.pid
> * brctl addbr br1
> * echo 1 > /sys/class/net/br1/bridge/stp_state

This bogus. You are running both kernel and spanning
tree daemon at the same time!

Doing the echo of 1 to stp_state forces kernel spanning
tree. You want 2 which is what is supposed to be use for user
mode spanning tree.

Note: dropping LKML off the thread to save time/space/noise.
