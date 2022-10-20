Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0007C401E1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B33884013F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6W8i9o8o3JEGbLuSjyxc6XgXvQsYfIY429ZrCGIGH7A=;
 b=LT6l9n3GBTcSQvOt/Zkq2tCDu4edixzNqa/k2gkqkki+ohFuVM0AsUxiNrQDPuQ9dp
 B8LzUHG6JrjRQj4yo+Fwtsf2X3kIvJkaCeWMmiC9fn/wkKNB9HLSlhiilFT9xxo2Q0Ih
 HVR2Qu+RkqbyPNfTZMGYM8QuIDe2OXDl1NiUSgEQw4kpsBwGGTf7cdDbkST3rJPXldCJ
 jyEqdtUxCuylTDY808GKyiUgzYWXGtEZgj/ZGKEFBlt5lPjfOcKiZQzgZ3JhNwwsKskM
 g5Jte+zUA232UjbG0/dLOu5ZfzViovNPhkJSQ9NdfP82wKAyVo5fcwzQMVmg/eq3Labc
 enPA==
Date: Thu, 20 Oct 2022 16:35:06 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20221020133506.76wroc7owpwjzrkg@skbuf>
References: <20221018165619.134535-1-netdev@kapio-technology.com>
 <20221018165619.134535-1-netdev@kapio-technology.com>
 <20221018165619.134535-6-netdev@kapio-technology.com>
 <20221018165619.134535-6-netdev@kapio-technology.com>
 <20221020130224.6ralzvteoxfdwseb@skbuf> <Y1FMAI9BzDRUPi5Y@shredder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1FMAI9BzDRUPi5Y@shredder>
Subject: Re: [Bridge] [PATCH v8 net-next 05/12] net: dsa: propagate the
 locked flag down through the DSA layer
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, "Hans J. Schultz" <netdev@kapio-technology.com>, Joachim Wiberg <troglobit@gmail.com>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Florent Fourcot <florent.fourcot@wifirst.fr>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Amit Cohen <amcohen@nvidia.com>, Christian Marangi <ansuelsmth@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Hans Schultz <schultz.hans@gmail.com>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Yuwei Wang <wangyuweihx@gmail.com>, Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, davem@davemloft.net

On Thu, Oct 20, 2022 at 04:24:16PM +0300, Ido Schimmel wrote:
> On Thu, Oct 20, 2022 at 04:02:24PM +0300, Vladimir Oltean wrote:
> > On Tue, Oct 18, 2022 at 06:56:12PM +0200, Hans J. Schultz wrote:
> > > @@ -3315,6 +3316,7 @@ static int dsa_slave_fdb_event(struct net_device *dev,
> > >  	struct dsa_port *dp = dsa_slave_to_port(dev);
> > >  	bool host_addr = fdb_info->is_local;
> > >  	struct dsa_switch *ds = dp->ds;
> > > +	u16 fdb_flags = 0;
> > >  
> > >  	if (ctx && ctx != dp)
> > >  		return 0;
> > > @@ -3361,6 +3363,9 @@ static int dsa_slave_fdb_event(struct net_device *dev,
> > >  		   orig_dev->name, fdb_info->addr, fdb_info->vid,
> > >  		   host_addr ? " as host address" : "");
> > >  
> > > +	if (fdb_info->locked)
> > > +		fdb_flags |= DSA_FDB_FLAG_LOCKED;
> > 
> > This is the bridge->driver direction. In which of the changes up until
> > now/through which mechanism will the bridge emit a
> > SWITCHDEV_FDB_ADD_TO_DEVICE with fdb_info->locked = true?
> 
> I believe it can happen in the following call chain:
> 
> br_handle_frame_finish
>    br_fdb_update // p->flags & BR_PORT_MAB
>        fdb_notify
>            br_switchdev_fdb_notify
> 
> This can happen with Spectrum when a packet ingresses via a locked port
> and incurs an FDB miss in hardware. The packet will be trapped and
> injected to the Rx path where it should invoke the above call chain.

Ah, so this is the case which in mv88e6xxx would generate an ATU
violation interrupt; in the Spectrum case it generates a special packet.
Right now this packet isn't generated, right?

I think we have the same thing in ocelot, a port can be configured to
send "learn frames" to the CPU.

Should these packets be injected into the bridge RX path in the first
place? They reach the CPU because of an FDB miss, not because the CPU
was the intended destination.
