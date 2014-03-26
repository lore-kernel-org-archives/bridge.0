Return-Path: <sergei.shtylyov@cogentembedded.com>
Message-ID: <53332809.4000404@cogentembedded.com>
Date: Wed, 26 Mar 2014 22:18:33 +0300
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
References: <1395850490-27628-1-git-send-email-vyasevic@redhat.com>
	<1395850490-27628-2-git-send-email-vyasevic@redhat.com>
In-Reply-To: <1395850490-27628-2-git-send-email-vyasevic@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v2 net 1/2] net: Allow modules to use
	is_skb_forwardable
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vlad Yasevich <vyasevic@redhat.com>, netdev@vger.kernel.org
Cc: shemminger@vyatta.com, bridge@lists.linux-foundation.org

Hello.

On 03/26/2014 07:14 PM, Vlad Yasevich wrote:

> Signed-off-by: Vlad Yasevich <vyasevic@redhat.com>
[...]

> diff --git a/net/core/dev.c b/net/core/dev.c
> index b1b0c8d..a98f7fa 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -1645,7 +1645,7 @@ static inline void net_timestamp_set(struct sk_buff *skb)
>   			__net_timestamp(SKB);		\
>   	}						\
>
> -static inline bool is_skb_forwardable(struct net_device *dev,
> +bool is_skb_forwardable(struct net_device *dev,
>   				      struct sk_buff *skb)

    Please re-indent the above line, so that it still starts under *struct*.

>   {
>   	unsigned int len;

WBR, Sergei

