Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:references:cc:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding;
	bh=I5VWfn6GTv69y1YGBSRL3K9gQdwYj2y6uv+z8KGiB68=;
	b=JVZTOU8Dm4K4Xk1b5QibW11ghri2lg6FE2VXiWugPgh+nl1t7LBr+b1/NqIL0P38N3
	FcmG/qqqNfpOPPrG+h1WACK13NKSG3i51WAufyuq4gT1TR+argp4rExKwOcKia2dmQkU
	e8CZDMGsJJCutrx79PFB6QJOHrTbVU+f0ysbg=
References: <1472562539-23247-1-git-send-email-nikolay@cumulusnetworks.com>
	<1472562539-23247-2-git-send-email-nikolay@cumulusnetworks.com>
	<20160830075623.15af2674@xeon-e3>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <45e77078-6acf-5ac0-5222-4b435fdc7524@cumulusnetworks.com>
Date: Tue, 30 Aug 2016 16:57:53 +0200
MIME-Version: 1.0
In-Reply-To: <20160830075623.15af2674@xeon-e3>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 1/2] net: bridge: change unicast
 boolean to exact pkt_type
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, davem@davemloft.net, bridge@lists.linux-foundation.org

On 30/08/16 16:56, Stephen Hemminger wrote:
> On Tue, 30 Aug 2016 15:08:58 +0200
> Nikolay Aleksandrov <nikolay@cumulusnetworks.com> wrote:
> 
>>  /* br_forward.c */
>> +enum {
>> +	BR_PKT_UNICAST,
>> +	BR_PKT_MULTICAST,
>> +	BR_PKT_BROADCAST
>> +};
>>  int br_dev_queue_push_xmit(struct net *net, struct sock *sk, struct sk_buff *skb);
>>  void br_forward(const struct net_bridge_port *to, struct sk_buff *skb,
>>  		bool local_rcv, bool local_orig);
>>  int br_forward_finish(struct net *net, struct sock *sk, struct sk_buff *skb);
>>  void br_flood(struct net_bridge *br, struct sk_buff *skb,
>> -	      bool unicast, bool local_rcv, bool local_orig);
>> +	      int pkt_type, bool local_rcv, bool local_orig);
> 
> Why not make pkt_type an enum value, you already have that infrastructure there.
> 
> enum br_pkt_type {
> 	BR_PKT_UNICAST,
> ...
> };
> 
> void br_flood(struct net_bridge *br, struct sk_buff *skb,
>               enum br_pkt_type pkt_type, ...
> 

sure, will change it to enum
v2 coming up
