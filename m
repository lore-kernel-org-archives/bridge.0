Return-Path: <idosch@idosch.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E03F8819F5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D7B0D819ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
 :feedback-id:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:sender:subject:subject:to:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1664784534; x=1664870934; bh=aqoxBah/X4GiH9ZDPQqIa9iZT5FE
 /SnWRIkJ33v/MSg=; b=mH/yyc34ZlANnESS3QyuEXuqm3u4UBZ9kLJh2miT5S8x
 Bic1WTsWQFD4GURfAVcHFRCGEYmVOFe58keAeWKTjoCA0AAzBoWyG0HWDmkDXCPs
 cn+kdoaaWeflSeiDlX/F3yYwO2aWv0aGXw0JSlECZ/PRWLyHU7F7thAKNE4xXygr
 RYQtuZbbxOwxvlL4EKpzjMrxdVOnHjz0EcRH5eac/FW+oNcbDOLCKObCw84n6a+C
 HqtWNyJ47FGZJNTx6Ub0IvUER1VgQ10sphr/GXUeJZ9OmPsv2sks9i2Wq+ddjWQ5
 wXRDVJDVs0iAf/A5xh4d4lRp7k+/qta3R9Mh7z/IHQ==
Date: Mon, 3 Oct 2022 11:08:48 +0300
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <YzqYkOsTHNj8Y9da@shredder>
References: <20220929152137.167626-1-netdev@kapio-technology.com>
 <YzhV0hU9v7oQ+g+K@shredder>
 <29ab01c9b8e51a57fb83e4af6fa1193f@kapio-technology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29ab01c9b8e51a57fb83e4af6fa1193f@kapio-technology.com>
Subject: Re: [Bridge] [PATCH iproute2-next 1/2] bridge: link: enable
 MacAuth/MAB feature
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@kapio-technology.com
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Joachim Wiberg <troglobit@gmail.com>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Florent Fourcot <florent.fourcot@wifirst.fr>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Ido Schimmel <idosch@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Amit Cohen <amcohen@nvidia.com>, Christian Marangi <ansuelsmth@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Hans Schultz <schultz.hans@gmail.com>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Yuwei Wang <wangyuweihx@gmail.com>, Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net

On Sun, Oct 02, 2022 at 05:20:31PM +0200, netdev@kapio-technology.com wrote:
> On 2022-10-01 16:59, Ido Schimmel wrote:
> > 
> > IIRC, in the past David asked to either not send the uAPI files or send
> > them as a first patch which he then uses as a hint to sync the files
> > himself.
> > 
> 
> Does that imply that I make a patch in the beginning for the include/uapi
> changes wrt the Locked flag and another in the same manner for the
> Blackhole, or just one patch for both of them as the very first patch?

One patch for both as the very first patch. Example:

https://lore.kernel.org/netdev/cover.1615985531.git.petrm@nvidia.com/
https://lore.kernel.org/netdev/ad9b63d5c76d9ef045dfed6dc9b5ab946e62e450.1615985531.git.petrm@nvidia.com/

The patch is obviously not needed if the uAPI files were already updated
by David.
