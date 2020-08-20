Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=U5n6SRT8Sjz1CPU13WE9d5LyTZiKHzyZjLgHZoxXOTE=;
 b=aqEEg19xOzHTc3ozUAXeqmBIsz/TxteAu/dHfpFyffdvzCI0suNWh4lVdHYbTteaQs
 OwOUuXvXjz7P5oYJiISCCLCsgVQFlym97GpZAeY9RzKEc20kmHFwcVWHGY86p2tu/3e4
 YURoEZWEfJlJorMoUduq5s3XoX4O5Fz2XxKfE=
References: <20200820105737.5089-1-kurt@linutronix.de>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <5affe98d-bb16-0744-5266-db708fb9dc16@cumulusnetworks.com>
Date: Thu, 20 Aug 2020 14:23:12 +0300
MIME-Version: 1.0
In-Reply-To: <20200820105737.5089-1-kurt@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [RFC PATCH] net: bridge: Don't reset time stamps on
 SO_TXTIME enabled sockets
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Kurt Kanzenbach <kurt@linutronix.de>, Roopa Prabhu <roopa@cumulusnetworks.com>
Cc: Jakub Kicinski <kuba@kernel.org>, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org

On 8/20/20 1:57 PM, Kurt Kanzenbach wrote:
> When using the ETF Qdisc in combination with a bridge and DSA, then all packets
> gets dropped due to invalid time stamps. The setup looks like this:
> 
> Transmit path:
> 
> Application -> bridge (br0) -> DSA slave ports (lan0, lan1) -> ETF Qdisc
>              -> ethernet (eth0)
> 
> The user space application uses SO_TXTIME to attach a sending time stamp for
> each packet using the corresponding interface. That time stamp is then attached
> to the skb in the kernel. The first network device involved in the chain is the
> bridge device. However, in br_forward_finish() the time stamp is reset to zero
> unconditionally. Meaning when the skb arrives at the ETF Qdisc, it's dropped as
> invalid because the time stamp is zero.
> 
> The reset of the time stamp in the bridge code is there for a good reason. See
> commit 41d1c8839e5f ("net: clear skb->tstamp in bridge forwarding path")
> Therefore, add a conditional for SO_TXTIME enabled sockets.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---
>   net/bridge/br_forward.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> RFC, because I don't know if that's the correct way to solve that issue.
> 


The new conditionals will be for all forwarded packets, not only the ones that are transmitted through
the bridge master device. If you'd like to do this please limit it to the bridge dev transmit.

Thanks,
  Nik
