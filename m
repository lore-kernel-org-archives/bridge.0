Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2DEB1401E1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2BA8A40474
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=X+gkU/NqbzBkggz5iJ5jkNMymmdjI88HmNgirY0p7mo=;
 b=TPiipjpDMk6wGWOJP+Agw+/0B6vH+/ztEW3I5tVyt2LoCYXke1TXQmFBwagKR/ECpK
 gEOm4H8c5qA8hZGz4VSJZPpkqt/IbvYZ19Te5+K8V6qcAjLW+yd00jruzQfGjWyTw1cr
 D5eAElpBXfz6xrI/19Get5d4/+bXbVvXDLrr4XJpc6KgZGXdlyBIfs1ftcluwlcs3TzI
 FPdNNA1X3wp1dFiIVzbhTRBNAtVDAHuEP77BPZNag0f6UGW/O85leK27nNsrOFr5A8gj
 BturwMnkyEbZpgiYOgFFYhxOalzV668fNDGJNiEqvHrmEQZIJTIN3mr4jmBQMU8LwU4k
 tOOg==
Date: Thu, 20 Oct 2022 16:11:01 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20221020131101.zotvyglhlayqdvu7@skbuf>
References: <20221018165619.134535-1-netdev@kapio-technology.com>
 <20221018165619.134535-12-netdev@kapio-technology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018165619.134535-12-netdev@kapio-technology.com>
Subject: Re: [Bridge] [PATCH v8 net-next 11/12] net: dsa: mv88e6xxx: add
 blackhole ATU entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Hans J. Schultz" <netdev@kapio-technology.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Joachim Wiberg <troglobit@gmail.com>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Amit Cohen <amcohen@nvidia.com>, Christian Marangi <ansuelsmth@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Hans Schultz <schultz.hans@gmail.com>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Yuwei Wang <wangyuweihx@gmail.com>, Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Florent Fourcot <florent.fourcot@wifirst.fr>, UNGLinuxDriver@microchip.com, davem@davemloft.net

On Tue, Oct 18, 2022 at 06:56:18PM +0200, Hans J. Schultz wrote:
> Blackhole FDB entries can now be added, deleted or replaced in the
> driver ATU.

Why is this necessary, why is it useful?

> 
> Signed-off-by: Hans J. Schultz <netdev@kapio-technology.com>
> ---
>  static int mv88e6xxx_port_fdb_add(struct dsa_switch *ds, int port,
>  				  const unsigned char *addr, u16 vid,
>  				  u16 fdb_flags, struct dsa_db db)
> @@ -2742,9 +2794,10 @@ static int mv88e6xxx_port_fdb_add(struct dsa_switch *ds, int port,
>  	struct mv88e6xxx_chip *chip = ds->priv;
>  	int err;
>  
> -	/* Ignore entries with flags set */
> -	if (fdb_flags)
> +	if (fdb_flags & DSA_FDB_FLAG_LOCKED)
>  		return 0;

I don't understand this. If no driver looks at DSA_FDB_FLAG_LOCKED
(not even mv88e6xxx, up until the end of the series), then why was it
propagated all the way in the first place?

> +	if (fdb_flags & DSA_FDB_FLAG_BLACKHOLE)
> +		return mv88e6xxx_blackhole_fdb_add(ds, addr, vid);
>  
>  	if (mv88e6xxx_port_is_locked(chip, port))
>  		mv88e6xxx_atu_locked_entry_find_purge(ds, port, addr, vid);
> @@ -2765,9 +2818,10 @@ static int mv88e6xxx_port_fdb_del(struct dsa_switch *ds, int port,
>  	bool locked_found = false;
>  	int err = 0;
>  
> -	/* Ignore entries with flags set */
> -	if (fdb_flags)
> +	if (fdb_flags & DSA_FDB_FLAG_LOCKED)
>  		return 0;
> +	if (fdb_flags & DSA_FDB_FLAG_BLACKHOLE)
> +		return mv88e6xxx_blackhole_fdb_del(ds, addr, vid);
>  
>  	if (mv88e6xxx_port_is_locked(chip, port))
>  		locked_found = mv88e6xxx_atu_locked_entry_find_purge(ds, port, addr, vid);
> -- 
> 2.34.1
> 
