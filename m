Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9FA8F60BEC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D969960B35
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20221208.gappssmtp.com; s=20221208; t=1684235898; x=1686827898;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oLNTOgpd74kTGPMOubmCg/68yes1Cl/99CRgAydnyPY=;
 b=KanS41noryOELVYIa+m4eah7qvA+WecJpxc2xTF7gfEUW2viqVfNiPckR+sm7Q2jjY
 edTpP9uSmKSf7Vuu92x+N3iQqUk1cihKECxg3ti3LAQWRVNUJhYvrqhcUNpppV2Lr+3C
 N/U4hyEBmP2cnxxYmsAE8MWcAi/c0zHNwWOOp9R2YeWqk1HXeWl0YtjzN+9rIv/eGUdO
 a61/tgnvSocGwmAsbXJd54448SNms8Z8QYJqM+TGbwEPMAOcVBS6N1S2nuaunCgwvBfR
 GPzwYiYrb8Xdx+GF6mbJDhbce4IrTzSJecEglgqQzpMCXRkRuIZ6yTy8CTLDl7wOpJpT
 6V8Q==
Message-ID: <b12a817f-de9f-6d25-f189-67e5e7ef49a4@blackwall.org>
Date: Tue, 16 May 2023 14:18:15 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20230515085046.4457-1-jnixdorf-oss@avm.de>
 <a1d13117-a0c5-d06e-86b7-eacf4811102f@blackwall.org>
 <ZGNEk3F8mcT7nNdB@u-jnixdorf.ads.avm.de>
 <f899f032-b726-7b6d-953d-c7f3f98744ca@blackwall.org>
 <20230516102141.w75yh6pdo53ufjur@skbuf>
 <ce3835d9-c093-cfcb-3687-3a375236cb8f@blackwall.org>
 <20230516104428.i5ou4ogx7gt2x6gq@skbuf>
 <c05b5623-c096-162f-3a2d-db19ca760098@blackwall.org>
 <20230516105509.xaalfs77vrlr663u@skbuf>
 <6a688292-a7a0-20c9-03b9-cad11a61144f@blackwall.org>
 <20230516111005.ni3jygnnxgygoenh@skbuf>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230516111005.ni3jygnnxgygoenh@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 1/2] bridge: Add a limit on FDB entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Johannes Nixdorf <jnixdorf-oss@avm.de>, netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org, Oleksij Rempel <linux@rempel-privat.de>, Eric Dumazet <edumazet@google.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

On 16/05/2023 14:10, Vladimir Oltean wrote:
> On Tue, May 16, 2023 at 02:04:30PM +0300, Nikolay Aleksandrov wrote:
>> That was one of the questions actually. More that I'm thinking about this, the more
>> I want to break it apart by type because we discussed being able to specify a flag
>> mask for the limit (all, dynamic, dynamic+static etc). If we embed these stats into a
>> bridge fdb count attribute, it can be easily extended later if anything new comes along.
>> If switchdev doesn't support some of these global limit configs, we can pass the option
>> and it can deny setting it later. I think this should be more than enough as a first step.
> 
> Ok, and by "type" you actually mean the impossibly hard to understand
> neighbor discovery states used by the bridge UAPI? Like having

Yes, that is what I mean. It's not that hard, we can limit it to a few combinations
that are well understood and defined.

> (overlapping) limits per NUD_REACHABLE, NUD_NOARP etc flags set in
> ndm->ndm_state? Or how should the UAPI look like?

Hmm, perhaps for the time being and for keeping it simpler it'd be best if the type initially is just about
dynamic entries and the count reflects only those. We can add an abstraction later if we want "per-type"/mask limits.
Adding such abstraction should be pretty-straight forward if we keep in mind the flags that can change only
under lock, otherwise proper counting would have to be revisited.
