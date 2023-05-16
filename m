Return-Path: <vladimir.oltean@nxp.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D44FC41740
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D82C7418E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSpYoJC8JtTsGNmeF2rMLk9B6x2zRqpIoGmw53g7rkY=;
 b=B+NOCTSQE3AjIKUA/GJh9Iq6C8FhZYsk+JC/gFX5LONznlc6YPRfceWWtzz2TkyX1eJ6U12Q4LEngFY0v2pkBOTWBapV8LBrzS9tyUjgSSurVQLCQKPDREyCqlLkUhTXLr7NfHdYQFpw2bhaUM7RwkkTJgBcb84S2poYAOtmUrk=
Date: Tue, 16 May 2023 14:10:05 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Message-ID: <20230516111005.ni3jygnnxgygoenh@skbuf>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a688292-a7a0-20c9-03b9-cad11a61144f@blackwall.org>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next 1/2] bridge: Add a limit on FDB entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Johannes Nixdorf <jnixdorf-oss@avm.de>, netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org, Oleksij Rempel <linux@rempel-privat.de>, Eric Dumazet <edumazet@google.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

On Tue, May 16, 2023 at 02:04:30PM +0300, Nikolay Aleksandrov wrote:
> That was one of the questions actually. More that I'm thinking about this, the more
> I want to break it apart by type because we discussed being able to specify a flag
> mask for the limit (all, dynamic, dynamic+static etc). If we embed these stats into a
> bridge fdb count attribute, it can be easily extended later if anything new comes along.
> If switchdev doesn't support some of these global limit configs, we can pass the option
> and it can deny setting it later. I think this should be more than enough as a first step.

Ok, and by "type" you actually mean the impossibly hard to understand
neighbor discovery states used by the bridge UAPI? Like having
(overlapping) limits per NUD_REACHABLE, NUD_NOARP etc flags set in
ndm->ndm_state? Or how should the UAPI look like?
