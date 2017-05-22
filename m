Return-Path: <davem@davemloft.net>
Date: Mon, 22 May 2017 14:41:30 -0400 (EDT)
Message-Id: <20170522.144130.1968086500919533289.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20170519173043.10201-1-cera@cera.cz>
References: <20170519173043.10201-1-cera@cera.cz>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2] bridge: fix hello and hold timers
 starting/stopping
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: cera@cera.cz
Cc: lucien.xin@gmail.com, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org

From: Ivan Vecera <cera@cera.cz>
Date: Fri, 19 May 2017 19:30:43 +0200

> Current bridge code incorrectly handles starting/stopping of hello and
> hold timers during STP enable/disable.
> 
> 1. Timers are stopped in br_stp_start() during NO_STP->USER_STP
>    transition. The timers are already stopped in NO_STP state so
>    this is confusing no-op.
> 
> 2. During USER_STP->NO_STP transition the timers are started. This
>    does not make sense and is confusion because the timer should not be
>    active in NO_STP state.
> 
> Cc: davem@davemloft.net
> Cc: sashok@cumulusnetworks.com
> Cc: stephen@networkplumber.org
> Cc: bridge@lists.linux-foundation.org
> Cc: lucien.xin@gmail.com
> Cc: nikolay@cumulusnetworks.com
> Signed-off-by: Ivan Vecera <cera@cera.cz>

Applied.
