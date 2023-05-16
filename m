Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CC69160ACA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 140E360ABA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20221208.gappssmtp.com; s=20221208; t=1684235072; x=1686827072;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kGCJ/W5iGEq3jH2YQIO8Cak7WirO4MEH/2Ql3CIQFcs=;
 b=ua9GQGF5QP7jIELA0XMiXvgx3sZt6AzmsV8XrnPk36Ych0TKFyhT6BSS05R9m+0spS
 Q6wrZXSCagxCV5Zl+36GPGtJjuPlERhLECmbnzYLB6SwV2EvJQG0VM9LJ66ZvOFJOCXt
 1qVTHkio0XWSyvmPSdOwUyJF2gQCbG65vcq1MNLx8VIB41WKwlCHuPj08JEqiDlvRB7U
 PB7bEuMiUUtiBkpFGVLPuntP8q4Zi+WLaqEhxP56bMhIKRZL8z3Xxc70foBYCuDoRimW
 XaJnTp7yDaXIs8Be8XA4oBCCGxgGbirIQpPczctPUQQWVOTceF4E1r6/7mNHiZAz/RE2
 814g==
Message-ID: <6a688292-a7a0-20c9-03b9-cad11a61144f@blackwall.org>
Date: Tue, 16 May 2023 14:04:30 +0300
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
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230516105509.xaalfs77vrlr663u@skbuf>
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

On 16/05/2023 13:55, Vladimir Oltean wrote:
> On Tue, May 16, 2023 at 01:47:47PM +0300, Nikolay Aleksandrov wrote:
>> Having the current count is just a helper, if you have a high limit dumping the table
>> and counting might take awhile. Thanks for the feedback, then we'll polish and move
>> on with the set for a global limit.
> 
> Ok, but to be useful, the current count will have to be directly
> comparable to the limit, I guess. So the current count will also be for
> dynamically learned entries? Or is the plan to enforce the global limit
> for any kind of FDB entries?

That was one of the questions actually. More that I'm thinking about this, the more
I want to break it apart by type because we discussed being able to specify a flag
mask for the limit (all, dynamic, dynamic+static etc). If we embed these stats into a
bridge fdb count attribute, it can be easily extended later if anything new comes along.
If switchdev doesn't support some of these global limit configs, we can pass the option
and it can deny setting it later. I think this should be more than enough as a first step.
