Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1391341C80
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5775B41C73
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20221208.gappssmtp.com; s=20221208; t=1684143349; x=1686735349;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HSSdUyfUPyGYycaIqfuqW/+pghUKLLVTSGYMfpy13LM=;
 b=D7GbvBX6PgLbCDR/Yqdo2kXDxg5n5V1DaOw9R41jA3f2HwW8Qv1g9yHj76/W/q7ZT4
 7pvp31roCIgy6seejg9uqmy1l//Is7be6P50+9GoKYlgFLdB6fm3DaEHNSUiINYbHmEg
 vHoBo+e/pvj2G155jQwlO1vvz3CavlYZgFmDZ+5MrPN9qj1W29XUt86sdNSsGl4wKozd
 Ndx28demcmGTOz05b1Mq6xWMv0dq6mS4sXNRzgDp9LVhF78Xe8Vrge8DTZap3xlu2nAo
 H3bc1/ig/YC78MTvoXHdH+FhXhcZOw6I4vHtnUOnPrVW3r1tNnTy2cYuD60RLdb38BPh
 +8Tg==
Message-ID: <dc8dfe0b-cf22-c4f9-8532-87643a6a9ceb@blackwall.org>
Date: Mon, 15 May 2023 12:35:47 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20230515085046.4457-1-jnixdorf-oss@avm.de>
 <20230515085046.4457-2-jnixdorf-oss@avm.de>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230515085046.4457-2-jnixdorf-oss@avm.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 2/2] bridge: Add a sysctl to limit new
 brides FDB entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Johannes Nixdorf <jnixdorf-oss@avm.de>, netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

On 15/05/2023 11:50, Johannes Nixdorf wrote:
> This is a convenience setting, which allows the administrator to limit
> the default limit of FDB entries for all created bridges, instead of
> having to set it for each created bridge using the netlink property.
> 
> The setting is network namespace local, and defaults to 0, which means
> unlimited, for backwards compatibility reasons.
> 
> Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>
> ---
>  net/bridge/br.c         | 83 +++++++++++++++++++++++++++++++++++++++++
>  net/bridge/br_device.c  |  4 +-
>  net/bridge/br_private.h |  9 +++++
>  3 files changed, 95 insertions(+), 1 deletion(-)
> 

The bridge doesn't need private sysctls. Netlink is enough.
Nacked-by: Nikolay Aleksandrov <razor@blackwall.org>
