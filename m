Date: Tue, 24 Mar 2009 23:40:51 -0700 (PDT)
Message-Id: <20090324.234051.60226102.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1237539869-30721-1-git-send-email-leoli@freescale.com>
References: <1237539869-30721-1-git-send-email-leoli@freescale.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] net/bridge: use the maximum hard_header_len of
 ports for bridging device
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: leoli@freescale.com
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

From: Li Yang <leoli@freescale.com>
Date: Fri, 20 Mar 2009 17:04:29 +0800

> The bridging device used a constant hard_header_len.  This will cause
> headroom shortage for ports with additional hardware header.  The patch
> makes bridging device to use the maximum value of all ports.
> 
> Signed-off-by: Li Yang <leoli@freescale.com>

Your driver must be able to cope with any amount of
available headroom, no matter what hacks we put into
the bridging layer.

Please fix your driver, I'm not applying this patch.
