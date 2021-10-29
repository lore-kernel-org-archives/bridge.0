Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MVZndbcHO12R31T2zRQ5u/20++i9cI/d2ar/UND6WI=;
 b=rfM7H/WLJwT3bEtlcrve72px7/PcT7jJzRJYqV7KHUNx3yEt/5yDPL3w6yKsT7Z4lpk7EzANZBF6qVxSxYd376sjJJJ8REO5H1J0/dQLM1pyYVrs7UG7yDAOvA7R7TzFMuStu9lJYAN8/9b4fq/bOxF0dUY9HUqK2Q/myG1PcSzgDEs0Icobu3YXkBh1zzPpPQ6wnJuR4tVW5Bs6wncVsAuoXKChJSa7iI7yJFY8kxv+TOvrluDBXPv5j61btdqMPFAyrgxkyDXaolmfjbxb0xohYeUojc282GQwsMhAyKpBrjzvsiXW22ITzqeGq0DoLMMK9aKx++V3lZiMFIWmiQ==
Message-ID: <c09158a8-f94c-5e33-db31-59430501e631@nvidia.com>
Date: Fri, 29 Oct 2021 14:48:05 +0300
Content-Language: en-US
References: <20211029105343.2705436-1-razor@blackwall.org>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
In-Reply-To: <20211029105343.2705436-1-razor@blackwall.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net] selftests: net: bridge: update IGMP/MLD
 membership interval value
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, roopa@nvidia.com

On 29/10/2021 13:53, Nikolay Aleksandrov wrote:
> From: Nikolay Aleksandrov <nikolay@nvidia.com>
> 
> When I fixed IGMPv3/MLDv2 to use the bridge's multicast_membership_interval
> value which is chosen by user-space instead of calculating it based on
> multicast_query_interval and multicast_query_response_interval I forgot
> to update the selftests relying on that behaviour. Now we have to
> manually set the expected GMI value to perform the tests correctly and get
> proper results (similar to IGMPv2 behaviour).
> 
> Fixes: fac3cb82a54a ("net: bridge: mcast: use multicast_membership_interval for IGMPv3")
> Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
> ---
>  tools/testing/selftests/net/forwarding/bridge_igmp.sh | 3 +++
>  tools/testing/selftests/net/forwarding/bridge_mld.sh  | 3 +++
>  2 files changed, 6 insertions(+)

Self-NAK, sorry for the noise but I'd prefer to have these values set by a single
command, no need to be different and also to reset to defaults afterwards, I'll
send v2 to do that.


