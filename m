Return-Path: <nikolay@nvidia.com>
References: <20201213024018.772586-1-vladimir.oltean@nxp.com>
 <20201213024018.772586-2-vladimir.oltean@nxp.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <85b824ea-5f43-b483-55b6-4ffd0e8275d8@nvidia.com>
Date: Sun, 13 Dec 2020 15:22:16 +0200
In-Reply-To: <20201213024018.772586-2-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1607865753; bh=NoqOydHicIMi/TM0s+KBjVs1U4WPirPhj650n4vekIQ=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:
 Authentication-Results:Subject:To:CC:References:From:Message-ID:
 Date:User-Agent:In-Reply-To:Content-Type:Content-Language:
 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
 MIME-Version:X-MS-Exchange-MessageSentRepresentingType:
 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-TrafficTypeDiagnostic:X-MS-Exchange-Transport-Forked:
 X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
 X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData:
 X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 b=GMb11Wn9Rrdz3EdcTpfEw6ckrHSj0muIE+FMWFqqLqKNHiAmBeUCUdFxZd6KrsbEs
 x6LBFMKIeZxzFYT6OcPzTumqvSeB6ewhyCCDGuKQ7QGhIWi1FtgUWifcLFI1lZhxLr
 MUE5rCrhOGogc7huGrDd8E5Bzfmxe82DKJDqfgq6CCof0KqKd/1s2emcmTUBLPjV5+
 v9+/sNsMBNYMgRVZ2PLi1XaQtfraggjbaoogg6Ewp+ylF/Oq6PsuxJCFnR+fAJBSlG
 xfp3mwWGN5dSlYTFD7m4kE9rOQTUEHyA4swZV2va+gxkOZ+4wL7GqrJe4qShIHtyE+
 vTQGxLFGu8h3w==
Subject: Re: [Bridge] [PATCH v2 net-next 1/6] net: bridge: notify switchdev
 of disappearance of old FDB entry upon migration
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, Andrew Lunn <andrew@lunn.ch>, Vivien Didelot <vivien.didelot@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org, Roopa Prabhu <roopa@nvidia.com>, "David
 S. Miller" <davem@davemloft.net>
Cc: Jiri Pirko <jiri@resnulli.us>, Alexandra Winter <wintera@linux.ibm.com>, Ido Schimmel <idosch@idosch.org>, Russell King - ARM Linux admin <linux@armlinux.org.uk>, Marek Behun <marek.behun@nic.cz>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, Tobias Waldekranz <tobias@waldekranz.com>

On 13/12/2020 04:40, Vladimir Oltean wrote:
> Currently the bridge emits atomic switchdev notifications for
> dynamically learnt FDB entries. Monitoring these notifications works
> wonders for switchdev drivers that want to keep their hardware FDB in
> sync with the bridge's FDB.
> 
> For example station A wants to talk to station B in the diagram below,
> and we are concerned with the behavior of the bridge on the DUT device:
> 
>                    DUT
>  +-------------------------------------+
>  |                 br0                 |
>  | +------+ +------+ +------+ +------+ |
>  | |      | |      | |      | |      | |
>  | | swp0 | | swp1 | | swp2 | | eth0 | |
>  +-------------------------------------+
>       |        |                  |
>   Station A    |                  |
>                |                  |
>          +--+------+--+    +--+------+--+
>          |  |      |  |    |  |      |  |
>          |  | swp0 |  |    |  | swp0 |  |
>  Another |  +------+  |    |  +------+  | Another
>   switch |     br0    |    |     br0    | switch
>          |  +------+  |    |  +------+  |
>          |  |      |  |    |  |      |  |
>          |  | swp1 |  |    |  | swp1 |  |
>          +--+------+--+    +--+------+--+
>                                   |
>                               Station B
> 
> Interfaces swp0, swp1, swp2 are handled by a switchdev driver that has
> the following property: frames injected from its control interface bypass
> the internal address analyzer logic, and therefore, this hardware does
> not learn from the source address of packets transmitted by the network
> stack through it. So, since bridging between eth0 (where Station B is
> attached) and swp0 (where Station A is attached) is done in software,
> the switchdev hardware will never learn the source address of Station B.
> So the traffic towards that destination will be treated as unknown, i.e.
> flooded.
> 
> This is where the bridge notifications come in handy. When br0 on the
> DUT sees frames with Station B's MAC address on eth0, the switchdev
> driver gets these notifications and can install a rule to send frames
> towards Station B's address that are incoming from swp0, swp1, swp2,
> only towards the control interface. This is all switchdev driver private
> business, which the notification makes possible.
> 
> All is fine until someone unplugs Station B's cable and moves it to the
> other switch:
> 
>                    DUT
>  +-------------------------------------+
>  |                 br0                 |
>  | +------+ +------+ +------+ +------+ |
>  | |      | |      | |      | |      | |
>  | | swp0 | | swp1 | | swp2 | | eth0 | |
>  +-------------------------------------+
>       |        |                  |
>   Station A    |                  |
>                |                  |
>          +--+------+--+    +--+------+--+
>          |  |      |  |    |  |      |  |
>          |  | swp0 |  |    |  | swp0 |  |
>  Another |  +------+  |    |  +------+  | Another
>   switch |     br0    |    |     br0    | switch
>          |  +------+  |    |  +------+  |
>          |  |      |  |    |  |      |  |
>          |  | swp1 |  |    |  | swp1 |  |
>          +--+------+--+    +--+------+--+
>                |
>            Station B
> 
> Luckily for the use cases we care about, Station B is noisy enough that
> the DUT hears it (on swp1 this time). swp1 receives the frames and
> delivers them to the bridge, who enters the unlikely path in br_fdb_update
> of updating an existing entry. It moves the entry in the software bridge
> to swp1 and emits an addition notification towards that.
> 
> As far as the switchdev driver is concerned, all that it needs to ensure
> is that traffic between Station A and Station B is not forever broken.
> If it does nothing, then the stale rule to send frames for Station B
> towards the control interface remains in place. But Station B is no
> longer reachable via the control interface, but via a port that can
> offload the bridge port learning attribute. It's just that the port is
> prevented from learning this address, since the rule overrides FDB
> updates. So the rule needs to go. The question is via what mechanism.
> 
> It sure would be possible for this switchdev driver to keep track of all
> addresses which are sent to the control interface, and then also listen
> for bridge notifier events on its own ports, searching for the ones that
> have a MAC address which was previously sent to the control interface.
> But this is cumbersome and inefficient. Instead, with one small change,
> the bridge could notify of the address deletion from the old port, in a
> symmetrical manner with how it did for the insertion. Then the switchdev
> driver would not be required to monitor learn/forget events for its own
> ports. It could just delete the rule towards the control interface upon
> bridge entry migration. This would make hardware address learning be
> possible again. Then it would take a few more packets until the hardware
> and software FDB would be in sync again.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
> Changes in v2:
> Patch is new.
> 
>  net/bridge/br_fdb.c | 1 +
>  1 file changed, 1 insertion(+)
>

Hi Vladimir,
Thank you for the good explanation, it really helps a lot to understand the issue.
Even though it's deceptively simple, that call adds another lock/unlock for everyone
when moving or learning (due to notifier lock), but I do like how simple the solution
becomes with this change, so I'm not strictly against it. I think I'll add a "refcnt"-like
check in the switchdev fn which would process the chain only when there are registered users
to avoid any locks when moving fdbs on pure software bridges (like it was before swdev).

I get that the alternative is to track these within DSA, I'm tempted to say that's not such
a bad alternative as this change would make moving fdbs slower in general. Have you thought
about another way to find out, e.g. if more fdb information is passed to the notifications ?

Thanks,
 Nik

