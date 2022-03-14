Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=B8S5CePBfzrVCN/ZCs2BTxWuc9mvMQ9JoCGkKm6n008=;
 b=JddOuH6IACYyaa/tIi4d1gXpCB3xrMraVpH2XUdtQatNapgahGumBtAtcfu0gaVfVf
 mqwtx4llIbo3SomPBbJgGPUwYvfaXGOcOuGqqdMcc3d7qAd3n8Spg43A2ZbenDG2kxUK
 9wPgmy2V+kw43rle8itGKuJXYe0FlZyFrvytPNB1wnw+Xlz5qlgPor6K1RjsGVP/bxzo
 9rMg+ElMLBhrj+uAhZe9zjrtNgObr+hLPHBFSIp2EppxsdglnssMcYq5P164i2ivBBSi
 3ldreuPWdV1810u6wrWU5cX0f579X/uLvA76/Mvsl/F58Kt5u+LPXK/SVz8780uLM75Q
 ffZA==
Date: Mon, 14 Mar 2022 19:07:44 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20220314170744.ugirixeq5t7ddcgo@skbuf>
References: <20220314095231.3486931-1-tobias@waldekranz.com>
 <20220314095231.3486931-11-tobias@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314095231.3486931-11-tobias@waldekranz.com>
Subject: Re: [Bridge] [PATCH v3 net-next 10/14] net: dsa: Pass VLAN MSTI
 migration notifications to driver
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, Petr Machata <petrm@nvidia.com>, Russell King <linux@armlinux.org.uk>, Vivien Didelot <vivien.didelot@gmail.com>, netdev@vger.kernel.org, Cooper Lees <me@cooperlees.com>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Matt Johnston <matt@codeconstruct.com.au>, davem@davemloft.net, linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 10:52:27AM +0100, Tobias Waldekranz wrote:
> Add the usual trampoline functionality from the generic DSA layer down
> to the drivers for VLAN MSTI migrations.
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
