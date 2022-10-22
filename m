Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0E67881D18
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2CDF081D02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lb9/zjqYRw+NBkGo45ll85eULcpfPgNmAc+gmZ4GdK8=;
 b=Zn6DNUW7Q97y/Bj/MSIzEC49CS64UT31QlzoAD6wLkmrUxwL1opBKx7FXFWrSqbXaY
 Kr1KrFPsJ5JFxz0E1ldEufc0LNrVaS6CfxrDGIytU7fsPoRNSf7b8USeKEUhwUXCscFM
 a2eyfsGFdsJkoxvamtodBneDSb4qhyXHHlRu7IuxYnRTevp2bmD1yAVHZeigULn1T3uo
 SomsjVAH+PAFo+dUSfG7fdu4CcnjNb6zpwlwRsUS2LdACbuiopa+fiVo3Kp3Y0SXSwg0
 sJQXpsxD9lNfpN8JbakSleno2DDivomz9MFdYdzSmr8s6ium2N25Al1S20hCR2OOVz/t
 QzOQ==
Date: Sat, 22 Oct 2022 14:55:05 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20221022115505.nlnkfy2xrgrq74li@skbuf>
References: <20221018165619.134535-1-netdev@kapio-technology.com>
 <20221018165619.134535-1-netdev@kapio-technology.com>
 <20221018165619.134535-11-netdev@kapio-technology.com>
 <20221018165619.134535-11-netdev@kapio-technology.com>
 <20221020132538.reirrskemcjwih2m@skbuf>
 <a0269818b270ad0537b991bd98725260@kapio-technology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0269818b270ad0537b991bd98725260@kapio-technology.com>
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

On Sat, Oct 22, 2022 at 09:31:06AM +0200, netdev@kapio-technology.com wrote:
> But I think it should be so that turning MAB off will clear the ALE entries
> regardless, as the port can continue to be locked and needing port association,
> or you want them to just age out normally in that case, thus lingering for
> up to bridge ageing time?

Even without BR_PORT_LOCKED, I find it normal that dynamically learned
FDB entries are forcefully aged out when BR_LEARNING is turned off,
instead of lingering on until they expire.

This does not happen in the software bridge, and I did not understand
why (I suspected some backwards compatibility reasons), and for this
reason, it is only from within DSA that we are forcing this behavior to
take place. In dsa_port_bridge_flags(), when BR_LEARNING is turned off,
we call dsa_port_fast_age() which also calls SWITCHDEV_FDB_FLUSH_TO_BRIDGE
(and this clears the bridge software FDB of dynamically learned entries).

I very much expect the same thing with MAB and BR_FDB_LOCKED entries,
that they go away when the BR_PORT_MAB/BR_LEARNING flag (whichever way
we call it) is unset.

Now, if the bridge should initiate the flushing, or still DSA, is
perhaps a topic for further discussion. Given that BR_FDB_LOCKED entries
are new, maybe the bridge could do it in this case (no backwards
compatibility to handle).

Currently the DSA logic mentioned above is bypassed, because we treat
MAB and autonomous learning differently. If we accepted that MAB is
still a form of learning (managed through BR_LEARNING+BR_PORT_LOCKED),
then the DSA logic would kick in, and both the software bridge and the
hardware driver would have a hook to clean up the BR_FDB_LOCKED entries,
plus anything else that is dynamic. The DSA logic would also kick in if
we treated BR_PORT_MAB within DSA like BR_LEARNING, which basically
amounts to the same thing, except for the confusing (IMO) UAPI of having
a flag (BR_PORT_MAB) which is basically a form of learning that isn't
controlled by the BR_LEARNING flag (which is undefined and unclear if it
should be set or not, in BR_PORT_LOCKED mode).
