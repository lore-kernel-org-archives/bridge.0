Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=tIojDdwExwM2bQG0JEvEesKc8kB3tKWJV3J1f0da5ZA=;
 b=pdHzLs5JGnc0J1gic2eKxFomgPy6zqT0sZNphWWO9rk6ZQr5XoeVwd+EvAce7pSnzl
 pUIE2LXmpy2gAR6WEkKk2qmmtpaTsjwWSMhBTCVNRoud2hIVrFnHzipUadejss5eMiWv
 3mQ0B5ahMAiUUsn4MY92QQzo7jbwH2qMqx6VbDXqW4Uf6OmRns2EdMOpUfj6M3U28t2T
 FD7+wmaDWFfbgtKG64yhGyNB/0v+F46q9C1FEyXJTjt1KuHVb7GxDX3Onq1myrr17Bcc
 SS/5FzCblHim68zec4TUheUDGVsFHiV2D8bolqpNdEp3VK4laF2LZp2n11HMiqNzdYv0
 vc+Q==
Date: Mon, 19 Jul 2021 11:19:08 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20210719081908.qnxw7gjetwkubxz3@skbuf>
References: <20210718214434.3938850-1-vladimir.oltean@nxp.com>
 <20210718214434.3938850-11-vladimir.oltean@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210718214434.3938850-11-vladimir.oltean@nxp.com>
Subject: Re: [Bridge] [PATCH v4 net-next 10/15] net: bridge: switchdev
 object replay helpers for everybody
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Ido Schimmel <idosch@idosch.org>, Ioana Ciornei <ioana.ciornei@nxp.com>, Marek Behun <kabel@blackhole.sk>, Florian Fainelli <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>, Steen Hegelund <Steen.Hegelund@microchip.com>, bridge@lists.linux-foundation.org, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Vivien Didelot <vivien.didelot@gmail.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Jiri Pirko <jiri@resnulli.us>, Vadym Kochan <vkochan@marvell.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, Lars Povlsen <lars.povlsen@microchip.com>, netdev@vger.kernel.org, UNGLinuxDriver@microchip.com, Taras Chornyi <tchornyi@marvell.com>, Tobias Waldekranz <tobias@waldekranz.com>

On Mon, Jul 19, 2021 at 12:44:29AM +0300, Vladimir Oltean wrote:
> Note that:
> (c) I do not expect a lot of functional change introduced for drivers in
>     this patch, because:
>     - nbp_vlan_init() is called _after_ netdev_master_upper_dev_link(),
>       so br_vlan_replay() should not do anything for the new drivers on
>       which we call it. The existing drivers where there was even a
>       slight possibility for there to exist a VLAN on a bridge port
>       before they join it are already guarded against this: mlxsw and
>       prestera deny joining LAG interfaces that are members of a bridge.
>     - br_fdb_replay() should now notify of local FDB entries, but I
>       patched all drivers except DSA to ignore these new entries in
>       commit 2c4eca3ef716 ("net: bridge: switchdev: include local flag
>       in FDB notifications"). Driver authors can lift this restriction
>       as they wish.
>     - br_mdb_replay() should now fix the issue described in commit
>       2c4eca3ef716 ("net: bridge: switchdev: include local flag in FDB
>       notifications") for all drivers, I don't see any downside.

I really meant commit 4f2673b3a2b6 ("net: bridge: add helper to replay
port and host-joined mdb entries"), sorry for the copy-pasta mistake.
