Return-Path: <davem@davemloft.net>
Date: Sun, 22 Oct 2017 01:52:08 +0100 (WEST)
Message-Id: <20171022.015208.1040885785483187060.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1508433452-23812-1-git-send-email-nikolay@cumulusnetworks.com>
References: <1508433452-23812-1-git-send-email-nikolay@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] net: bridge: fix returning of vlan range
	op errors
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
Date: Thu, 19 Oct 2017 20:17:32 +0300

> When vlan tunnels were introduced, vlan range errors got silently
> dropped and instead 0 was returned always. Restore the previous
> behaviour and return errors to user-space.
> 
> Fixes: efa5356b0d97 ("bridge: per vlan dst_metadata netlink support")
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Applied and queued up for -stable.
