Return-Path: <kuba@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E42A0405DB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CDB31405BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1666631284;
 bh=qWgfUtE4UN4/iCrWAyctAyzwt74lHMnUej7miAfWozs=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Zu+kqShRcjC8nRPj+ZPavRcjYG48rUxYr/xtUKVxq/tVD3qP4BQ8938gc4JRHh+sQ
 wUEoCQstYbywkycJbXo1Gx9NudXpA31ePGv1ymKF7AziAkUafYLdFNwgeHV1QImOEK
 JFwJgG3tBQ+MqnkxeUpIBTBFzGPMlWiBuQYZJPplfyUZSfiekZhXplF9BCf4TEz5cR
 BoSuO18xOEhTlK5W4tnJUnjIc+5268Ad/+OGpyLVWX/qO+ewTt1u6BRu/hvzFkn3Kl
 CbW0He1dZ/toR97u7dANoXILUr18MDMSTzT2iOWvvh3xihpjn8Gr15icEr7MzFt17l
 NwXsJuVW8BO6Q==
Date: Mon, 24 Oct 2022 10:08:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20221024100801.6c391ff9@kernel.org>
In-Reply-To: <7690b7f836b144b60f60b3b68d3bf784@kapio-technology.com>
References: <20221018165619.134535-1-netdev@kapio-technology.com>
 <20221018165619.134535-3-netdev@kapio-technology.com>
 <Y1FHuXE+X/V9aRvh@shredder>
 <7690b7f836b144b60f60b3b68d3bf784@kapio-technology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v8 net-next 02/12] net: bridge: add blackhole
 fdb entry flag
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@kapio-technology.com
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Joachim Wiberg <troglobit@gmail.com>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Florent Fourcot <florent.fourcot@wifirst.fr>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Ido Schimmel <idosch@nvidia.com>, Paolo Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Amit Cohen <amcohen@nvidia.com>, Christian Marangi <ansuelsmth@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Hans Schultz <schultz.hans@gmail.com>, Roopa Prabhu <roopa@nvidia.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Yuwei Wang <wangyuweihx@gmail.com>, Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net

On Sun, 23 Oct 2022 07:32:02 +0200 netdev@kapio-technology.com wrote:
> >> @@ -1140,7 +1148,7 @@ static int __br_fdb_add(struct ndmsg *ndm, 
> >> struct net_bridge *br,
> >>  		err = br_fdb_external_learn_add(br, p, addr, vid, true);
> >>  	} else {
> >>  		spin_lock_bh(&br->hash_lock);
> >> -		err = fdb_add_entry(br, p, addr, ndm, nlh_flags, vid, nfea_tb);
> >> +		err = fdb_add_entry(br, p, addr, ndm, nlh_flags, vid, ext_flags, 
> >> nfea_tb);  
> > 
> > I believe the preference is to wrap to 80 columns when possible.  
> 
> Very strange... since I ran checkpatch.pl from the net-next kernel 
> itself and it did not
> give me any warnings about 80 columns, but rather said 'patch is ready 
> for submission'.
> 
> As this is silent, could it be some missing python plugins or something 
> to do with perl?

I run:

./scripts/checkpatch.pl --strict --max-line-length=80

