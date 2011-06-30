Date: Thu, 30 Jun 2011 10:03:22 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20110630100322.21c7b28a@nehalam.ftrdhcpuser.net>
In-Reply-To: <201106301527.19539.alexander.stein@systec-electronic.com>
References: <201106301033.23997.alexander.stein@systec-electronic.com>
	<201106301527.19539.alexander.stein@systec-electronic.com>
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
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org

On Thu, 30 Jun 2011 15:27:19 +0200
Alexander Stein <alexander.stein@systec-electronic.com> wrote:

> On Thursday 30 June 2011 10:33:23 Alexander Stein wrote:
> > BTW: I noticed that in 2.6.39.2 independently from this patch revert this
> > bridge didn't show up RUNNING ifconfg. Is this intended? Another bridge I
> > have, which doesn't use (R)STP, is shown as RUNNING like before.
> 
> This change was caused by commit 1faa4356a3bd89ea11fb92752d897cff3a20ec0e 
> "bridge: control carrier based on ports online". It prevents the bridge from 
> actually receiving/sending packets. Reverting restores the old behavior.

It is really a bug in RSTP, I will fix it there.
