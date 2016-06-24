Return-Path: <linus.luessing@c0d3.blue>
Date: Fri, 24 Jun 2016 15:24:41 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160624132441.GJ5511@otheros>
References: <1466764518-11358-1-git-send-email-daniel@dd-wrt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1466764518-11358-1-git-send-email-daniel@dd-wrt.com>
Subject: Re: [Bridge] [PATCH net] Bridge: Fix ipv6 mc snooping if bridge has
 no ipv6 address
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Daniel Danzberger <daniel@dd-wrt.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, davem@davemloft.net

On Fri, Jun 24, 2016 at 12:35:18PM +0200, Daniel Danzberger wrote:
> The bridge is falsly dropping ipv6 mulitcast packets if there is:
>  1. No ipv6 address assigned on the brigde.
>  2. No external mld querier present.
>  3. The internal querier enabled.
> 
> When the bridge fails to build mld queries, because it has no
> ipv6 address, it slilently returns, but keeps the local querier enabled.
> This specific case causes confusing packet loss.
> 
> Ipv6 multicast snooping can only work if:
>  a) An external querier is present
>  OR
>  b) The bridge has an ipv6 address an is capable of sending own queries
> 
> Otherwise it has to forward/flood the ipv6 multicast traffic,
> because snooping cannot work.
> 
> This patch fixes the issue by adding a flag to the bridge struct that
> indicates that there is currently no ipv6 address assinged to the bridge
> and returns a false state for the local querier in
> __br_multicast_querier_exists().

Acked-by: Linus Lüssing <linus.luessing@c0d3.blue>
