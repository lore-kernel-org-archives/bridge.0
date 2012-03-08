Return-Path: <davem@davemloft.net>
Date: Thu, 08 Mar 2012 00:25:40 -0800 (PST)
Message-Id: <20120308.002540.2134888106193611323.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20120307082522.6293.26893.stgit@localhost.localdomain>
References: <20120307082514.6293.59158.stgit@localhost.localdomain>
	<20120307082522.6293.26893.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 2/2] bridge: fix state reporting when port is
	disabled
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: paulius.zaleckas@gmail.com
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

From: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Date: Wed, 07 Mar 2012 10:25:22 +0200

> Now we have:
> eth0: link *down*
> br0: port 1(eth0) entered *forwarding* state
> 
> br_log_state(p) should be called *after* p->state is set
> to BR_STATE_DISABLED.
> 
> Reported-by: Zilvinas Valinskas <zilvinas@wilibox.com>
> Signed-off-by: Paulius Zaleckas <paulius.zaleckas@gmail.com>
> Acked-by: Stephen Hemminger <shemminger@vyatta.com>

Applied.
