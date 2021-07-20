Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=1pTMpOorH4LXisVDsXChy+V+9uhVQ+gNlcIaEeOCwgw=;
 b=PN0n7YiIgzdEzWTu+Hn+Zg1BVFbf8oa8DRCmTAwLnsS/hNSCj7BW9S5xB97H2O0AMc
 cZv2dH7j3sdKeolAH9wQUkAtIthofsXJVmyKUQer3a4tRlxQ7Mv06d1DRsNWX4PlOT5j
 gj6elyDDBkh0ongrV/OMYJFxmY/riLEenq1ukRLXN36IUCt6Edbuvu02k3Wz1zDII8kJ
 ROiEBPoddxtJ+LTak9vMOz5fJAFwgPalbrUZ1hRk2eEE7VA+aFOVWWyE9lkH8SjcmZp5
 depv9ZvyeSQYnkFCZZX7ugVebi5PQBlIfLwhFgpJLdiJaQNgW9sesCGtjE5Tc/zZhrJH
 hHNA==
Date: Tue, 20 Jul 2021 11:45:20 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20210720084520.4t7sfshyzeuw4ba3@skbuf>
References: <20210718214434.3938850-1-vladimir.oltean@nxp.com>
 <20210718214434.3938850-10-vladimir.oltean@nxp.com>
 <20210720075354.u57sju7bvn5o3ses@soft-dev3-1.localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720075354.u57sju7bvn5o3ses@soft-dev3-1.localhost>
Subject: Re: [Bridge] [PATCH v4 net-next 09/15] net: bridge: switchdev: let
 drivers inform which bridge ports are offloaded
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Ido Schimmel <idosch@idosch.org>, Ioana Ciornei <ioana.ciornei@nxp.com>, UNGLinuxDriver@microchip.com, Marek Behun <kabel@blackhole.sk>, Florian Fainelli <f.fainelli@gmail.com>, Steen Hegelund <Steen.Hegelund@microchip.com>, bridge@lists.linux-foundation.org, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Vivien Didelot <vivien.didelot@gmail.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Jiri Pirko <jiri@resnulli.us>, Vadym Kochan <vkochan@marvell.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, Lars Povlsen <lars.povlsen@microchip.com>, netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Taras Chornyi <tchornyi@marvell.com>, Tobias Waldekranz <tobias@waldekranz.com>

Hi Horatiu,

On Tue, Jul 20, 2021 at 09:53:54AM +0200, Horatiu Vultur wrote:
> Tested-by: Horatiu Vultur <horatiu.vultur@microchip.com> # ocelot-switch

Thanks for testing.
Next time could you please trim the quoted portion to maybe just the
commit message? I spent around 30 seconds scrolling down, half expecting
there to be an inline comment on a line of code or something.
