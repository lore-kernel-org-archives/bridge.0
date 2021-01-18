Return-Path: <kuba@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611009001;
 bh=AB2pnIpG2vO9SbQwThxOJlZMOhzUueP38fYONle5nu8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=EkyqWWx9ZGxBf0F4H8YcVO2dGD3h6JWFvj2coy1jElnmxt9Fg6LLu7CWVXB4hVZLF
 I97vcgMowDUHoODCHw61V/DHHOvBP9JTMFPtv573RXoFAWyM4fXdi5Mg2jDWdEXYcX
 aeBMPMq2MPTzKrawbrplt7MIOS77jFOXzZFinNsloFMNhKVqfWKg9PgWDLm8YpqKfk
 H2NncMISVU/E9YJLthCEz5nHvNdyqfgqhgP64ejLXK0XMi+QI+U1zojSiljKQ0dIBi
 4fFl1rC84kj5UnQhLFPGh+/hX2TwWAOsUcx8yKAnR65KcXoreXVgHbwdK8g7nHUOpA
 dfuk1XmkAljZA==
Date: Mon, 18 Jan 2021 14:30:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20210118143000.0a534525@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <ffce5e21-fdd2-cb2b-6957-7454aea9c665@nvidia.com>
References: <20210117080950.122761-1-dong.menglong@zte.com.cn>
 <ffce5e21-fdd2-cb2b-6957-7454aea9c665@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v4 net-next] net: bridge: check vlan with
 eth_type_vlan() method
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@nvidia.com>, menglong8.dong@gmail.com
Cc: Menglong Dong <dong.menglong@zte.com.cn>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, roopa@nvidia.com, davem@davemloft.net

On Mon, 18 Jan 2021 13:55:11 +0200 Nikolay Aleksandrov wrote:
> On 17/01/2021 10:09, menglong8.dong@gmail.com wrote:
> > From: Menglong Dong <dong.menglong@zte.com.cn>
> > 
> > Replace some checks for ETH_P_8021Q and ETH_P_8021AD with
> > eth_type_vlan().
> > 
> > Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>
> 
> Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>

Applied, thanks!
