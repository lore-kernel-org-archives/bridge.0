Return-Path: <kuba@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605749246;
 bh=ruN/fazh+ZYXqMcXIkuyqUm+o6MpFy89SaMV9Dvmj1Y=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=xc/MwMP1ZlJjtBAKv6iZ4/uyWGRy4F1dwSc1dAaklacTGNCz+aFLdMHvOX9rbmv/J
 x/s/m9LDoNwvsfSJ15cvxJJx3X5a8myn3Sa5+MaHqiZz3kb/amskLkx1LY3PWrmosD
 sOvfwpHl/Tvx7uNaN0bnB7DXzMc6czWQmL4uYFRg=
Date: Wed, 18 Nov 2020 17:27:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20201118172724.3c8e0092@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
In-Reply-To: <04d25c3d-c5f6-3611-6d37-c2f40243dae2@gmail.com>
References: <04d25c3d-c5f6-3611-6d37-c2f40243dae2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] net: bridge: replace struct
 br_vlan_stats with pcpu_sw_netstats
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: bridge@lists.linux-foundation.org, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>

On Tue, 17 Nov 2020 21:25:42 +0100 Heiner Kallweit wrote:
> Struct br_vlan_stats duplicates pcpu_sw_netstats (apart from
> br_vlan_stats not defining an alignment requirement), therefore
> switch to using the latter one.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Applied, thanks!
