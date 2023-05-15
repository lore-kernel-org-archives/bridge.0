Return-Path: <stephen@networkplumber.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8895341F87
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7959C41F86
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1684166192;
 x=1686758192; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OcLsr78EN7rEqPNewa0hKsosvcKEefYu9hxdkOGF9BE=;
 b=t42S/uV9vuqdYs8egpECgEbmFeiZUT1aZki0nf0JVuoyYW8YQ7ZKnF2tqrcnyPr7tN
 zKTZqCG0Ct6pqg1xPsUsNSrKV9UO2Um2lH0gXMV11EOx/I/8jhZJK6Lx5NN95JSiZJ6b
 hKquYr4POpSLvb2pLTFcUZSWmnOc8FXSNtE1WSU+rmUg84cp/rpLx01Q/xH6q9lYzj0z
 KSh34pKnJ2NZkAPs6J8I6z5ExFaC6N7NdxyXlvT0abEj7yn1hKx0Ad1eYnBvRURXkW+A
 rDnVClHXDXjhlVLZ2QcNaeczaVVU4FQqLaerj4haqy82hiXNY4PIaxvptlhxqB0TlHbi
 lcyA==
Date: Mon, 15 May 2023 08:56:27 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20230515085627.5897dab1@hermes.local>
In-Reply-To: <20230515085046.4457-2-jnixdorf-oss@avm.de>
References: <20230515085046.4457-1-jnixdorf-oss@avm.de>
 <20230515085046.4457-2-jnixdorf-oss@avm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: Johannes Nixdorf <jnixdorf-oss@avm.de>
Cc: netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

On Mon, 15 May 2023 10:50:46 +0200
Johannes Nixdorf <jnixdorf-oss@avm.de> wrote:

> +static struct ctl_table br_sysctl_table[] = {
> +	{
> +		.procname     = "bridge-fdb-max-entries-default",


That name is too long.

Also, all the rest of bridge code does not use sysctl's.  Why is this
special and why should the property be global and not per bridge?

NAK
