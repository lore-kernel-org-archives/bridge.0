Return-Path: <tobias@waldekranz.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=z+Sy3daXdZc7eFbdaSwLgS5WLdDuNus4al0ePtnegPY=;
 b=nXjjimFe6hkuycvGrRtBjI1tKHAIDTQIMYAAXSkRjb2oWqSuB/56KJfDcJysox0MNW
 JZgo+cbfllhR/t2NrtkiFGFnBeuEt7tZGrh6Ib1Vw/0OuoHLacO0XOi4RuXFF1hOS2X+
 s6QOSDr89qyk3k5+h2aCsvSU8ZtsqRhvqFiF2cVjVM1RB/b93R7oH8Q14UQI8nCEnil3
 eU336Zo/Yf8z/RNW3DDQbY3LdduKL4XQr5ZrQcGUrgSwhtnFhpk7EIVYOKLR2bgX1BAf
 0XvFoGwBTTXSZ0cC2JWcH8n5czQCnX8QfB0VzjYTnjo+EssdB9v3rjIJKtfhjIJqWEtG
 0cIA==
From: Tobias Waldekranz <tobias@waldekranz.com>
In-Reply-To: <F908AE50-EDF4-4B83-98BD-ECB872CAD776@blackwall.org>
References: <20220301100321.951175-1-tobias@waldekranz.com>
 <20220301100321.951175-2-tobias@waldekranz.com>
 <F908AE50-EDF4-4B83-98BD-ECB872CAD776@blackwall.org>
Date: Mon, 07 Mar 2022 15:53:30 +0100
Message-ID: <87a6e1olud.fsf@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH v2 net-next 01/10] net: bridge: mst: Multiple
 Spanning Tree (MST) mode
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>, davem@davemloft.net, kuba@kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Petr Machata <petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Cooper Lees <me@cooperlees.com>, Roopa Prabhu <roopa@nvidia.com>, Matt Johnston <matt@codeconstruct.com.au>, Vladimir Oltean <olteanv@gmail.com>, Vivien Didelot <vivien.didelot@gmail.com>

On Wed, Mar 02, 2022 at 00:01, Nikolay Aleksandrov <razor@blackwall.org> wrote:
> On 1 March 2022 11:03:12 CET, Tobias Waldekranz <tobias@waldekranz.com> wrote:
>>Allow the user to switch from the current per-VLAN STP mode to an MST
>>mode.
>>
>>Up to this point, per-VLAN STP states where always isolated from each
>>other. This is in contrast to the MSTP standard (802.1Q-2018, Clause
>>13.5), where VLANs are grouped into MST instances (MSTIs), and the
>>state is managed on a per-MSTI level, rather that at the per-VLAN
>>level.
>>
>>Perhaps due to the prevalence of the standard, many switching ASICs
>>are built after the same model. Therefore, add a corresponding MST
>>mode to the bridge, which we can later add offloading support for in a
>>straight-forward way.
>>
>>For now, all VLANs are fixed to MSTI 0, also called the Common
>>Spanning Tree (CST). That is, all VLANs will follow the port-global
>>state.
>>
>>Upcoming changes will make this actually useful by allowing VLANs to
>>be mapped to arbitrary MSTIs and allow individual MSTI states to be
>>changed.
>>
>>Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
>>---
>> include/uapi/linux/if_link.h |  1 +
>> net/bridge/Makefile          |  2 +-
>> net/bridge/br_input.c        | 17 +++++++-
>> net/bridge/br_mst.c          | 83 ++++++++++++++++++++++++++++++++++++
>> net/bridge/br_netlink.c      | 14 +++++-
>> net/bridge/br_private.h      | 26 +++++++++++
>> net/bridge/br_stp.c          |  3 ++
>> net/bridge/br_vlan.c         | 20 ++++++++-
>> net/bridge/br_vlan_options.c |  5 +++
>> 9 files changed, 166 insertions(+), 5 deletions(-)
>> create mode 100644 net/bridge/br_mst.c
>>
>
> Hi,
> As I mentioned in another review, I'm currently traveling and will have pc access
> end of this week (Sun), I'll try to review the set as much as I can through my phone in the
> meantime. Thanks for reworking it, generally looks good.
> A few comments below,
>
>
>>diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
>>index e315e53125f4..7e0a653aafa3 100644
>>--- a/include/uapi/linux/if_link.h
>>+++ b/include/uapi/linux/if_link.h
>>@@ -482,6 +482,7 @@ enum {
>> 	IFLA_BR_VLAN_STATS_PER_PORT,
>> 	IFLA_BR_MULTI_BOOLOPT,
>> 	IFLA_BR_MCAST_QUERIER_STATE,
>>+	IFLA_BR_MST_ENABLED,
>
> Please use the boolopt api for new bridge boolean options like this one.

Ahh, I was not aware of that. Will change it in v3. Thanks.
