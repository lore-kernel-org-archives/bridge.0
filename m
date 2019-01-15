Return-Path: <sergei.shtylyov@cogentembedded.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=zXbtgk1bFv5Ke2szaIb7HFYbeDpAIIIgmmLLpP7xaLY=;
	b=UbQ5uemQCHxLl2lWf/3q1Alf0yD6jFYOJBblQHgRBQhkv5VshX7o7cmHQhy14+wqdI
	aM97akyohv9hRvflHR8MnEvJ+3R9MlPu4CNSJ39uizY783LX+S/fvsBQifC01X6GqPye
	PNqnLgcvcFwai1Z2c4YtBgP5h13l0l6UbUkFXQ1AWGRzckuVAm+Xgngjjp9+LGvyOd25
	bf5Ef0dvpBrNZho8cuCF2RevWdml1SSuecWym+iB9iGYfY1+XYQR8u3mj08buR3qMfA9
	OtlqkT5va94bB0MDCQEH31NOE1xyj1ZZLYV6L82kR8S0s3TqsmkdwKVC53OknZMU3VXj
	FXkw==
References: <1547521959-3736-1-git-send-email-wangyunjian@huawei.com>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <2a04e21b-c24a-cd7c-258f-6a09b0f09df2@cogentembedded.com>
Date: Tue, 15 Jan 2019 12:21:56 +0300
MIME-Version: 1.0
In-Reply-To: <1547521959-3736-1-git-send-email-wangyunjian@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net v2] net: bridge: Fix ethernet header
 pointer before check skb forwardable
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: wangyunjian <wangyunjian@huawei.com>, netdev@vger.kernel.org
Cc: Nkolay Aleksandrov <nikolay@cumulusnetworks.com>, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, xudingke@huawei.com

On 15.01.2019 6:12, wangyunjian wrote:

> From: Yunjian Wang <wangyunjian@huawei.com>
> 
> The skb header should be set to ethernet header before using
> is_skb_forwardable. Because the ethernet header length has been
> considered in is_skb_forwardable(including dev->hard_header_len
> length).
> 
> To reproduce the issue:
> 1, add 2 ports on linux bridge br using following commands:
> $ brctl addbr br
> $ brctl addif br eth0
> $ brctl addif br eth1
> 2, the mtu of eth0 and eth1 is 1500
> 3, send a 1504 packet from eth0 to eth1
> 
> So the expect result is packet larger than 1500 cannot pass through
> eth0 and eth1. But currently, the packet passes through success, it
> means eth1's mtu limit donen't take effect.

    Doesn't. And MTU.

> Fixes: f6367b4660dd ("bridge: use is_skb_forwardable in forward path")
> Cc: bridge@lists.linux-foundation.org
> Cc: Nkolay Aleksandrov <nikolay@cumulusnetworks.com>
> Cc: Roopa Prabhu <roopa@cumulusnetworks.com>
> Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
[...]

MBR, Sergei
