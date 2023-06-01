Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CC74684304
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 06D4C84303
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20221208.gappssmtp.com; s=20221208; t=1685640332; x=1688232332;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zQsLOYw2qsyNq/n+5eOaAgo493QBN57EdOSrWMISRRE=;
 b=BIQzhqi2lFWKFCf8MCcXrdp6Ls+Xl+DSWyM1IbjQ05PzaMPk/+jZkx5JcdIMPBey7X
 6RiIiOmJfpU4vrjY8cUSm0+w4+o2BpfgKd6UZQPXxV84xd9M08PoMmQ1rttHclUHy72D
 9VnfHl6hE5+U/3wiqmdyrHjmPXRdawFJgNXsVb5Hv0OhN5Ysg8gubJkg5H4mNJnDzc15
 CSoooUjd/9BOPZoPKmqAEbCso0kpZU++EKlCoNJXpALsPvbFep8y4BSmUycAH9qekLlq
 KwEjwUQ17zRtZV5OSjjIxq/T3nwTg49ZEupTLcEEozamE+83GlC+19pUnN2dZS0NvPn4
 +Mvg==
Message-ID: <258b291e-4631-bb49-58e8-0dc5bf30ed3e@blackwall.org>
Date: Thu, 1 Jun 2023 20:25:30 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20230601172145.51357-1-stephen@networkplumber.org>
 <20230601172145.51357-4-stephen@networkplumber.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230601172145.51357-4-stephen@networkplumber.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH iproute2 3/7] bridge: make print_vlan_info
	static
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, Roopa Prabhu <roopa@nvidia.com>

On 01/06/2023 20:21, Stephen Hemminger wrote:
> Function defined and used in only one file.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  bridge/br_common.h | 1 -
>  bridge/vlan.c      | 3 ++-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/bridge/br_common.h b/bridge/br_common.h
> index 1bdee65844c1..704e76b0acb2 100644
> --- a/bridge/br_common.h
> +++ b/bridge/br_common.h
> @@ -6,7 +6,6 @@
>  #define MDB_RTR_RTA(r) \
>  		((struct rtattr *)(((char *)(r)) + RTA_ALIGN(sizeof(__u32))))
>  
> -void print_vlan_info(struct rtattr *tb, int ifindex);
>  int print_linkinfo(struct nlmsghdr *n, void *arg);
>  int print_mdb_mon(struct nlmsghdr *n, void *arg);
>  int print_fdb(struct nlmsghdr *n, void *arg);
> diff --git a/bridge/vlan.c b/bridge/vlan.c
> index 5b304ea94224..dfc62f83a5df 100644
> --- a/bridge/vlan.c
> +++ b/bridge/vlan.c
> @@ -18,6 +18,7 @@
>  
>  static unsigned int filter_index, filter_vlan;
>  static int vlan_rtm_cur_ifidx = -1;
> +static void print_vlan_info(struct rtattr *tb, int ifindex);
>  
>  enum vlan_show_subject {
>  	VLAN_SHOW_VLAN,
> @@ -1309,7 +1310,7 @@ static int vlan_global_show(int argc, char **argv)
>  	return 0;
>  }
>  
> -void print_vlan_info(struct rtattr *tb, int ifindex)
> +static void print_vlan_info(struct rtattr *tb, int ifindex)
>  {
>  	struct rtattr *i, *list = tb;
>  	int rem = RTA_PAYLOAD(list);

Thanks,
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

