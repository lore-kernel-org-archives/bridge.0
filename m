Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D615A60AD0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C61C3605A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=y5UsByWLMWEYobec0CN6KDFyOSWUvAwaZ8r1U9iYpCA=;
 b=GSP8LRnEUC3YB9em437uwIQRy41VuAuO8g4G5+rvlN9pk2hRaUTIC7RPWtP+4/iLfX
 NbsuWSaMTClElRWXyedG58ZqOOrY3YChazC5x54rw4O8k7egy1jc2YTFgWJa0c+1ttes
 WDniBrpGY8CGEvQSfn1HIIBiabI/klkG7e0t/6oshc86Mmf1IwxQVWtQIdNQz47n2Wxq
 Ue14QtxdR3M9VfCM5ucJ5Mlfr4QiWIiaFaUzmo4H9QDF7WWHx7EXyIYXWUM/c6ey2xDY
 JLckjeXOeuKccRqfKBHHRBOHdgNiEomFXjbyXjpOSC/DPYhETa51oG8U7CQViQueT1hO
 iA+Q==
Message-ID: <47d8d747-54ef-df52-3b9c-acb9a77fa14a@blackwall.org>
Date: Thu, 30 Jun 2022 13:22:37 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20220630100512.604364-1-hans@kapio-technology.com>
 <20220630100512.604364-2-hans@kapio-technology.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20220630100512.604364-2-hans@kapio-technology.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v1 1/1] net: bridge: ensure that
 multicast packets cannot unlock a locked port
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hans Schultz <hans@kapio-technology.com>, davem@davemloft.net, kuba@kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org, Hans Schultz <schultz.hans+netdev@gmail.com>, linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean <olteanv@gmail.com>, Shuah Khan <shuah@kernel.org>, Vivien Didelot <vivien.didelot@gmail.com>

On 30/06/2022 13:05, Hans Schultz wrote:
> This makes it possible to use the locked port feature with learning
> turned on which is needed for various driver features.
> 
> Signed-off-by: Hans Schultz <hans@kapio-technology.com>
> ---
>  net/bridge/br_input.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> index 68b3e850bcb9..a3ce0a151817 100644
> --- a/net/bridge/br_input.c
> +++ b/net/bridge/br_input.c
> @@ -215,6 +215,7 @@ static void __br_handle_local_finish(struct sk_buff *skb)
>  	if ((p->flags & BR_LEARNING) &&
>  	    nbp_state_should_learn(p) &&
>  	    !br_opt_get(p->br, BROPT_NO_LL_LEARN) &&
> +	    !(p->flags & BR_PORT_LOCKED) &&
>  	    br_should_learn(p, skb, &vid))
>  		br_fdb_update(p->br, p, eth_hdr(skb)->h_source, vid, 0);
>  }

hmm this is called for link-local traffic (01:80:c2), the title is misleading
please include the real traffic type because it doesn't concern mcast

Also please include the long explanation from the 0 patch in this one
and drop the cover letter, it's good to have the info.

Thanks,
 Nik




