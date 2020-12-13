Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4bNUNyX2OkcA/p7RRz8/0NoCDR167RI4yVLO7Zke4+Y=;
 b=Fy1N42YJw/0HIQ7RCvewEOSaC5jkv/k7IxyT191WspJzF4q+fwwpq8vVOMMXPJI4hDPmbsllLMYEwAvrtO8F0Rj2vPBrzHJc75GlwUszeba7SrxKTN22kvQBzUqvyDMNGAdk74jmKkMFrKeGnWYnxvie+neZ9bceWOQJd9ceyho=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Sun, 13 Dec 2020 13:57:58 +0000
Message-ID: <20201213135757.wf7c7dkl4odnn44z@skbuf>
References: <20201213024018.772586-1-vladimir.oltean@nxp.com>
 <20201213024018.772586-2-vladimir.oltean@nxp.com>
 <85b824ea-5f43-b483-55b6-4ffd0e8275d8@nvidia.com>
 <562e27af-ff7a-8dad-4303-19edd5b15af8@nvidia.com>
In-Reply-To: <562e27af-ff7a-8dad-4303-19edd5b15af8@nvidia.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <58F46658F1B9A4458E3B58A4F77D0D92@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
To: Nikolay Aleksandrov <nikolay@nvidia.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Alexandra Winter <wintera@linux.ibm.com>, Ido Schimmel <idosch@idosch.org>, Russell King - ARM Linux admin <linux@armlinux.org.uk>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Marek Behun <marek.behun@nic.cz>, Vivien Didelot <vivien.didelot@gmail.com>, Tobias Waldekranz <tobias@waldekranz.com>

On Sun, Dec 13, 2020 at 03:36:13PM +0200, Nikolay Aleksandrov wrote:
> Nevermind the whole comment. :) I was looking at the wrong code and got c=
onfused.
>
> All is well (thanks to Ido).
>
> Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>

Ok, thanks. By the way, which wrong code were you looking at?=
