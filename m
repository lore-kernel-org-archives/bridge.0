Return-Path: <davem@davemloft.net>
Date: Wed, 31 Jul 2019 19:13:57 -0400 (EDT)
Message-Id: <20190731.191357.886589630333387649.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190730122041.14647-1-nikolay@cumulusnetworks.com>
References: <20190730122041.14647-1-nikolay@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] net: bridge: mcast: add delete due to
 fast-leave mdb flag
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Tue, 30 Jul 2019 15:20:41 +0300

> In user-space there's no way to distinguish why an mdb entry was deleted
> and that is a problem for daemons which would like to keep the mdb in
> sync with remote ends (e.g. mlag) but would also like to converge faster.
> In almost all cases we'd like to age-out the remote entry for performance
> and convergence reasons except when fast-leave is enabled. In that case we
> want explicit immediate remote delete, thus add mdb flag which is set only
> when the entry is being deleted due to fast-leave.
> 
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Applied, thanks Nikolay.
