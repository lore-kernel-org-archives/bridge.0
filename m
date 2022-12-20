Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BCF97400F1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DDB76400D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6UrO2j9DEey1G8UqydjmxQqMxVbqAZzAn1bK1fPzhSc=;
 b=Ce84Cz9ZMLrEN2Gk2uhhVVozKt2Ab9/SVRJooyCg87u9QWuaXj2DzyRfdtJPOtJ/y1
 caxj6AxhZeVQV21Mz7mN99Oe9sUOteH83ZZBnEC1zGQIS+y56hR0g9LEc4yKwfcI876m
 8BL/xL0n1Zkpxa4xIK8ntmNbuGmbMqXb6DMKHmlGAeEQ07STXlZkyerrchrhlcAXsq5O
 fEuxO7r57G7VHe8XV15zLqyUdmuh4l/DQIhRor++mvff2ByfO+/2rKHymzbFOkLs2/RX
 OyoVx1HDQm1yNO0rfnMdz7pIKj106xQFQo/JrlKIe1Ae9oFkDn+G/SislAwKHyP3092p
 Ssow==
Message-ID: <05d630bf-7fa8-4495-6345-207f133ef746@blackwall.org>
Date: Tue, 20 Dec 2022 12:13:12 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20221220024807.36502-1-jgu@purestorage.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20221220024807.36502-1-jgu@purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] net: bridge: mcast: read ngrec once in
	igmp3/mld2 report
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Joy Gu <jgu@purestorage.com>, bridge@lists.linux-foundation.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, joern@purestorage.com

On 20/12/2022 04:48, Joy Gu wrote:
> In br_ip4_multicast_igmp3_report() and br_ip6_multicast_mld2_report(),
> "ih" or "mld2r" is a pointer into the skb header. It's dereferenced to
> get "num", which is used in the for-loop condition that follows.
> 
> Compilers are free to not spend a register on "num" and dereference that
> pointer every time "num" would be used, i.e. every loop iteration. Which
> would be a bug if pskb_may_pull() (called by ip_mc_may_pull() or
> ipv6_mc_may_pull() in the loop body) were to change pointers pointing
> into the skb header, e.g. by freeing "skb->head".
> 
> We can avoid this by using READ_ONCE().
> 
> Suggested-by: Joern Engel <joern@purestorage.com>
> Signed-off-by: Joy Gu <jgu@purestorage.com>
> ---
>  net/bridge/br_multicast.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

I doubt any compiler would do that (partly due to the ntohs()). If you have hit a bug or
seen this with some compiler please provide more details, disassembly of the resulting
code would be best.

Thanks.

