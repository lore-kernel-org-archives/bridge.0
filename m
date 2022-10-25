Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3C110400FE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0DF11400C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mgrt68RTokIPjxFk9F1VtW4AgjAvWhPVw4wFYPgG+7o=;
 b=pLRRqlS78PrNILEG8db0Kbjrzc97tg/uT92QegIJGh5zRaagxZpp6bQ26kpWJkh6R6zdpnptpPDPXrDfQy5ouBRbwinz0kugst2oK7X/DAzaqKS9XzB8MPFKRhCnvueghS4i/qEJmDVr5Sg44NrmxQnt/DQwChuXlHVDK5csoz9qH8YcTbxXlzA6rkyBVDQRokBdCnhTmc6/KJcrjxtxI+BYiW5QLYPFAxzWk97Y63fLSa5LSc2oSSB5GwwrxvVs5srFCDjFQxXKEArOswYn+Luet++fFzXyc6K1+gI5lzyENebDHzGdsfDIGkksFLeOz5cJweMYANfXiRB6Iz78Xg==
Date: Tue, 25 Oct 2022 13:53:04 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <Y1fAEDkgAG3ttvOQ@shredder>
References: <20221018120420.561846-1-idosch@nvidia.com>
 <20221018122112.7218792b@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018122112.7218792b@kernel.org>
MIME-Version: 1.0
Subject: Re: [Bridge] [RFC PATCH net-next 00/19] bridge: mcast: Extensions
	for EVPN
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, razor@blackwall.org, bridge@lists.linux-foundation.org, edumazet@google.com, mlxsw@nvidia.com, roopa@nvidia.com, pabeni@redhat.com, davem@davemloft.net

On Tue, Oct 18, 2022 at 12:21:12PM -0700, Jakub Kicinski wrote:
> On Tue, 18 Oct 2022 15:04:01 +0300 Ido Schimmel wrote:
> > 	[ MDBE_ATTR_SRC_LIST ]		// new
> > 		[ MDBE_SRC_LIST_ENTRY ]
> > 			[ MDBE_SRCATTR_ADDRESS ]
> > 				struct in_addr / struct in6_addr
> > 		[ ...]
> 
> nit: I found that the MDBE_ATTR_SRC_LIST level of wrapping corresponds
> to how "sane" formats work, but in practice there is no need for it in
> netlink. You can put the entry nests directly in the outer. Saves one
> layer of parsing. Just thought I'd mention it, you can keep as is if
> you prefer.

I guess you mean:

[ MDBA_SET_ENTRY_ATTRS ]
	[ MDBE_SRC_LIST_ENTRY ]
		[ MDBE_SRCATTR_ADDRESS ]
			struct in_addr / struct in6_addr
	[ MDBE_SRC_LIST_ENTRY ]
	[ ... ]

It is a good suggestion, but I wanted to make the request format similar
to the existing response / notification format that already has this
level of wrapping. See example in the commit message of patch #17:

https://lore.kernel.org/netdev/20221018120420.561846-18-idosch@nvidia.com/
