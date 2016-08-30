Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=p4+JxJ2NYeFfNx/AHTrzmIhaQtGeV6eanKJ9fV6JBAE=;
	b=1zO+yZsV2LD7M6JH094LEsc8BOOsKe9K+3jlNDiFUmg1jpiwPLnOdJ07rMcF66lhkQ
	rURVsM75oyakzgPDH0GHuPT+x202r23b56pOtqJ0aB+HoAdTFeAiDG8DfnYooapK77Cs
	gM9p4lmfNXe/ERie3XKFK+PD3x9eaN+Ja6f1u6ZzN0ircNPEnMb+im3o83F0hlo0mzfi
	3QJCCS4oNcXD2BAk/KPCFpcERKPyJExa6mRaK/eWEE/YUuOeUxlQ0TQX/bs0SOD77qY/
	9khKHd5XSfrdlgACbLrIcYSZ877YdyDOVg7JejkwvBtzJfdcZkZRLIqlt0z64eE75wPz
	c0HQ==
Date: Tue, 30 Aug 2016 07:56:23 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20160830075623.15af2674@xeon-e3>
In-Reply-To: <1472562539-23247-2-git-send-email-nikolay@cumulusnetworks.com>
References: <1472562539-23247-1-git-send-email-nikolay@cumulusnetworks.com>
	<1472562539-23247-2-git-send-email-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, davem@davemloft.net, bridge@lists.linux-foundation.org

On Tue, 30 Aug 2016 15:08:58 +0200
Nikolay Aleksandrov <nikolay@cumulusnetworks.com> wrote:

>  /* br_forward.c */
> +enum {
> +	BR_PKT_UNICAST,
> +	BR_PKT_MULTICAST,
> +	BR_PKT_BROADCAST
> +};
>  int br_dev_queue_push_xmit(struct net *net, struct sock *sk, struct sk_buff *skb);
>  void br_forward(const struct net_bridge_port *to, struct sk_buff *skb,
>  		bool local_rcv, bool local_orig);
>  int br_forward_finish(struct net *net, struct sock *sk, struct sk_buff *skb);
>  void br_flood(struct net_bridge *br, struct sk_buff *skb,
> -	      bool unicast, bool local_rcv, bool local_orig);
> +	      int pkt_type, bool local_rcv, bool local_orig);

Why not make pkt_type an enum value, you already have that infrastructure there.

enum br_pkt_type {
	BR_PKT_UNICAST,
...
};

void br_flood(struct net_bridge *br, struct sk_buff *skb,
              enum br_pkt_type pkt_type, ...

