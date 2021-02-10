Return-Path: <nikolay@nvidia.com>
References: <20210210091445.741269-1-olteanv@gmail.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <a8e9284b-f0a6-0343-175d-8c323371ef8d@nvidia.com>
Date: Wed, 10 Feb 2021 12:31:43 +0200
In-Reply-To: <20210210091445.741269-1-olteanv@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1612953133; bh=KLTHAFomU+Mg/TCDgh9di6anHsIucD8bjG1LXW1Y+8Q=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:
 Authentication-Results:Subject:To:CC:References:From:Message-ID:
 Date:User-Agent:In-Reply-To:Content-Type:Content-Language:
 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
 MIME-Version:X-MS-Exchange-MessageSentRepresentingType:
 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-TrafficTypeDiagnostic:X-MS-Exchange-Transport-Forked:
 X-Microsoft-Antispam-PRVS:X-Header:X-MS-Oob-TLC-OOBClassifiers:
 X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 b=RvWsLAc1VzBgLcTIAoBLNt0HOG/go2uVVHpIePMQJoaELyh6cfswvVWyT3NqVfoCB
 Xzs8Idkrxkx1YKOALISdTKCu/uXoM20DUkvNeKQP0T/SrkE6zv9FiEdgSe6WpP5Yax
 YxHuUY84z/z9V4QDr542VHU2/iGfLjs1sda9xgJuzMOCRaa5B2vsjJzmCzlgX/t+ed
 wFA9TfkublGR0+91HtvaICjJwBJ82ocm50aoJoOPDPqV1BzRXMl7CZSbYVd0ZDGCZX
 OffFkyJF69+JCvpzvWROgHkxMtV92bNQnaqwKp65WAuahWT34St0MsTya3GaWY+8eM
 ww9dM/udbZikA==
Subject: Re: [Bridge] [PATCH v3 net-next 00/11] Cleanup in brport flags
 switchdev offload for DSA
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <olteanv@gmail.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Vadym Kochan <vkochan@marvell.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Ioana Ciornei <ioana.ciornei@nxp.com>, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, Taras Chornyi <tchornyi@marvell.com>, Ido Schimmel <idosch@idosch.org>, Claudiu Manoil <claudiu.manoil@nxp.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Roopa Prabhu <roopa@nvidia.com>, linux-omap@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>

On 10/02/2021 11:14, Vladimir Oltean wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> The initial goal of this series was to have better support for
> standalone ports mode and multiple bridges on the DSA drivers like
> ocelot/felix and sja1105. Proper support for standalone mode requires
> disabling address learning, which in turn requires interaction with the
> switchdev notifier, which is actually where most of the patches are.
> 
> I also noticed that most of the drivers are actually talking either to
> firmware or SPI/MDIO connected devices from the brport flags switchdev
> attribute handler, so it makes sense to actually make it sleepable
> instead of atomic.
> 

Hi Vladimir,
Let's take a step back for a moment and discuss the bridge unlock/lock sequences
that come with this set. I'd really like to avoid those as they're a recipe
for future problems. The only good way to achieve that currently is to keep
the PRE_FLAGS call and do that in unsleepable context but move the FLAGS call
after the flags have been changed (if they have changed obviously). That would
make the code read much easier since we'll have all our lock/unlock sequences
in the same code blocks and won't play games to get sleepable context.
Please let's think and work in that direction, rather than having:
+	spin_lock_bh(&p->br->lock);
+	if (err) {
+		netdev_err(p->dev, "%s\n", extack._msg);
+		return err;
 	}
+

which immediately looks like a bug even though after some code checking we can
verify it's ok. WDYT?

I plan to get rid of most of the br->lock since it's been abused for a very long
time because it's essentially STP lock, but people have started using it for other
things and I plan to fix that when I get more time.

Thanks,
 Nik
