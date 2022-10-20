Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9B47C4155E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8E45441508
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KSyGYu5mB1+N4wjZMirWYKsm/OR0IsapLyRpo6UTXsY=;
 b=Q56oC/qBd5xz35WvyWQaS0SIowWdUGsQJGKXPYPkAnTa/HBtAJArmBFWpYa4LsxwZM
 dRlIx8DC4hBSeGgM//j/8NzY/dw+Mei+dUBUkDFIh3SWNbBNewoDZE8vZ/mFvCJkaweH
 0CKHQ+Vq2hMhLVz/iryTvkBEYh0mrRiBrB4oYDVCPYsjTyYcfL3/8OWk6wBEmwcnyunB
 bfZj7X3bwD0eLmPx25r+dHE2SgvNwcmrhiVxN7WFCmB6G9CggNc4ICHBDYecYO19eAPq
 BVOtx5Sl6l9g0jIebCbhH8xJIrdO3wx8ylyCdfSuAbVFe17RATgQJ8cNesesZpShl+Zx
 k8vg==
Date: Fri, 21 Oct 2022 02:00:54 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20221020230054.542nmf66rvaswr32@skbuf>
References: <20221018165619.134535-1-netdev@kapio-technology.com>
 <20221018165619.134535-1-netdev@kapio-technology.com>
 <20221018165619.134535-11-netdev@kapio-technology.com>
 <20221018165619.134535-11-netdev@kapio-technology.com>
 <20221020132538.reirrskemcjwih2m@skbuf>
 <3e58594c1223f4591e56409cd5061de7@kapio-technology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e58594c1223f4591e56409cd5061de7@kapio-technology.com>
Subject: Re: [Bridge] [PATCH v8 net-next 10/12] net: dsa: mv88e6xxx:
 mac-auth/MAB implementation
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@kapio-technology.com
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Joachim Wiberg <troglobit@gmail.com>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Amit Cohen <amcohen@nvidia.com>, Christian Marangi <ansuelsmth@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Hans Schultz <schultz.hans@gmail.com>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Yuwei Wang <wangyuweihx@gmail.com>, Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Florent Fourcot <florent.fourcot@wifirst.fr>, UNGLinuxDriver@microchip.com, davem@davemloft.net

On Thu, Oct 20, 2022 at 11:09:40PM +0200, netdev@kapio-technology.com wrote:
> > Again, dsa_port_fast_age() is also called when dp->learning is turned
> > off in dsa_port_bridge_flags(). I don't want to see the mv88e6xxx driver
> > doing this manually.
> 
> Maybe I am wrong, but I have only been able to trigger fast ageing by setting
> the STP state of the port to blocked...

Maybe you didn't try hard enough? On a DSA bridge port that is up and in
the FORWARDING state and with 'learning' on, running "ip link set dev
swp0 type bridge_slave learning off" triggers dsa_port_fast_age().
