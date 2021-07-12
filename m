Return-Path: <kabel@blackhole.sk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=blackhole.sk;
 s=mail; t=1626104461;
 bh=RWYhEtAwTgLXUQOVcWGtAxGzTFa/bMHHrTYq7ywzREE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=kwOYoP0vDwN7lEgYWF+w/8XPSj4+0UK18zCtnWvMuutSLKZR2tnK/ZAoGhV/ggRXp
 3QC1iQ3StGFLmXr+sLecOpX3rRWb99ntnpSzFpF0koTVkTJlyfu4OuDIy10i0TZ8p4
 go0HudYCEd+31SrgBXwYDhlOPrsaEVPNuJlTA3AU=
Date: Mon, 12 Jul 2021 17:40:59 +0200
From: Marek Behun <kabel@blackhole.sk>
Message-ID: <20210712174059.7916c0da@thinkpad>
In-Reply-To: <20210712152142.800651-1-vladimir.oltean@nxp.com>
References: <20210712152142.800651-1-vladimir.oltean@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [RFC PATCH v3 net-next 00/24] Allow forwarding for the
 software bridge data path to be offloaded to capable devices
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@idosch.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Tobias Waldekranz <tobias@waldekranz.com>

Vladimir, on what mv88e6xxx devices are you developing this stuff?
Do you use Turris MOX for this?

Marek
