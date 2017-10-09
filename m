Return-Path: <davem@davemloft.net>
Date: Sun, 08 Oct 2017 21:12:18 -0700 (PDT)
Message-Id: <20171008.211218.2039744025968269985.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1507353159-46814-1-git-send-email-roopa@cumulusnetworks.com>
References: <1507353159-46814-1-git-send-email-roopa@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v6 0/3] bridge: neigh msg proxy and
 flood suppression support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: roopa@cumulusnetworks.com
Cc: nikolay@cumulusnetworks.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org

From: Roopa Prabhu <roopa@cumulusnetworks.com>
Date: Fri,  6 Oct 2017 22:12:36 -0700

> From: Roopa Prabhu <roopa@cumulusnetworks.com>
> 
> This series implements arp and nd suppression in the bridge
> driver for ethernet vpns. It implements rfc7432, section 10
> https://tools.ietf.org/html/rfc7432#section-10
> for ethernet VPN deployments. It is similar to the existing
> BR_PROXYARP* flags but has a few semantic differences to conform
> to EVPN standard. Unlike the existing flags, this new flag suppresses
> flood of all neigh discovery packets (arp and nd) to tunnel ports.
> Supports both vlan filtering and non-vlan filtering bridges.
> 
> In case of EVPN, it is mainly used to avoid flooding
> of arp and nd packets to tunnel ports like vxlan.
> 
> v2 : rebase to latest + address some optimization feedback from Nikolay.
> v3 : fix kbuild reported build errors with CONFIG_INET off
> v4 : simplify port flag mask as suggested by stephen
> v5 : address some feedback from Toshiaki
> v6 : some v5 cleanups in nd suppress (keep it consistent with arp suppress)

Series applied, thank you.
