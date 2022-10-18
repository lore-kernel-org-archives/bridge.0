Return-Path: <kuba@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 43D71610CC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D73D760B6E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1666120873;
 bh=AQ4yB5Ac7ETTgAmEBRKy2WlBUrbMZ1TtZeZz1xVByU4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=ISTTBdpU+cHma5SnbaIVWgRj+lX/ZmIkrgZHgOYkMUAC9fJHg99Eq3F/W8jw0VmoA
 9BShnifPmNRs7b6oVE3abXn3Nt1aoSgq6QkTJpmk/P1GL9B/T1qXzOwybnyQoyP3bo
 AmJzLUL4X4l+TrNMaYxWAwxqhdpSFWXYL4SO74e4EoJbyJieE8tj22coI2tmYL8BAP
 Qu4NMX6dlnGh6gZWE/igyDyQdxaIusPkaDHMUV86ggqZiyIefZhfmvl3jQF25IWHwB
 8vxT+p41V4fz7JTD4NDy+Dxm6RbqECJYDYuOI6kRzGwFPPqVSysKJMMcdDvALhT+CD
 CsNf49Z6FN1zA==
Date: Tue, 18 Oct 2022 12:21:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20221018122112.7218792b@kernel.org>
In-Reply-To: <20221018120420.561846-1-idosch@nvidia.com>
References: <20221018120420.561846-1-idosch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, razor@blackwall.org, bridge@lists.linux-foundation.org, edumazet@google.com, mlxsw@nvidia.com, roopa@nvidia.com, pabeni@redhat.com, davem@davemloft.net

On Tue, 18 Oct 2022 15:04:01 +0300 Ido Schimmel wrote:
> 	[ MDBE_ATTR_SRC_LIST ]		// new
> 		[ MDBE_SRC_LIST_ENTRY ]
> 			[ MDBE_SRCATTR_ADDRESS ]
> 				struct in_addr / struct in6_addr
> 		[ ...]

nit: I found that the MDBE_ATTR_SRC_LIST level of wrapping corresponds
to how "sane" formats work, but in practice there is no need for it in
netlink. You can put the entry nests directly in the outer. Saves one
layer of parsing. Just thought I'd mention it, you can keep as is if
you prefer.
