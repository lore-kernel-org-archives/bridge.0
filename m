Return-Path: <davem@davemloft.net>
Date: Fri, 20 Jan 2017 15:08:31 -0500 (EST)
Message-Id: <20170120.150831.840272160400257097.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20170120181042.GB1784@nanopsycho.orion>
References: <20170120171217.20617-1-cera@cera.cz>
	<20170120181042.GB1784@nanopsycho.orion>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net v3] bridge: netlink: call br_changelink()
 during br_dev_newlink()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: jiri@resnulli.us
Cc: netdev@vger.kernel.org, jiri@mellanox.com, cera@cera.cz, bridge@lists.linux-foundation.org

From: Jiri Pirko <jiri@resnulli.us>
Date: Fri, 20 Jan 2017 19:10:42 +0100

> Fri, Jan 20, 2017 at 06:12:17PM CET, cera@cera.cz wrote:
>>Any bridge options specified during link creation (e.g. ip link add)
>>are ignored as br_dev_newlink() does not process them.
>>Use br_changelink() to do it.
>>
>>Fixes: 1332351 ("bridge: implement rtnl_link_ops->changelink")
> 
> Should have 12 chars. Other than that,
> 
> Reviewed-by: Jiri Pirko <jiri@mellanox.com>

I fixed up the SHA1-ID.

Applied and queued up for -stable, thanks.
