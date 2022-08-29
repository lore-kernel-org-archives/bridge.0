Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3D91760BA3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E7E0C60B93
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8l6TR8xBhnzhS5VlzrmXIdXzbVUug9NrXTcRJL5RyU=;
 b=dhHrcwDDi5l/BqF+3vXdW37qpZYc8jlNyqCvBsNvh96t9YJN3ejUzicysEDrLPaJICJ8zjD9AfL/2RFIlZsDcJebhGPx+3OZ+43FAbGhZMpgtGdEg2q6CCYb0UNfCngxfsr6SjTNYkhS7agJVFTtNu0W9QmT7KEL8ggBqQI+5j/U3809XpG2JkAVD64fVFbBqaprIJgSby1h6Flm5tmKTMXyJ0izVCOpcim8d6FXCFJm9dWT/UiW1nO+At/5nbDY2HJjSKIclFZ+1bH2I95gVUjm0GURdBosIlaLOFdqGa2SawrpnfyWS7LX9gxfx5nDJ3iZN4XTu6r7HwJ015CZTA==
Date: Mon, 29 Aug 2022 17:37:27 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <YwzPJ2oCYJQHOsXD@shredder>
References: <20220826114538.705433-1-netdev@kapio-technology.com>
 <20220826114538.705433-7-netdev@kapio-technology.com>
 <YwpgvkojEdytzCAB@shredder>
 <7654860e4d7d43c15d482c6caeb6a773@kapio-technology.com>
 <YwxtVhlPjq+M9QMY@shredder>
 <2967ccc234bb672f5440a4b175b73768@kapio-technology.com>
 <Ywyj1VF1wlYqlHb6@shredder>
 <9e1a9eb218bbaa0d36cb98ff5d4b97d7@kapio-technology.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e1a9eb218bbaa0d36cb98ff5d4b97d7@kapio-technology.com>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH v5 net-next 6/6] selftests: forwarding: add
 test of MAC-Auth Bypass to locked port tests
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@kapio-technology.com
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, bridge@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Christian Marangi <ansuelsmth@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Yuwei Wang <wangyuweihx@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net

On Mon, Aug 29, 2022 at 02:04:42PM +0200, netdev@kapio-technology.com wrote:
> On 2022-08-29 13:32, Ido Schimmel wrote:
> > > The final decision on this rests with you I would say.
> > 
> > If the requirement for this feature (with or without MAB) is to work
> > with dynamic entries (which is not what is currently implemented in the
> > selftests), then learning needs to be enabled for the sole reason of
> > refreshing the dynamic entries added by user space. That is, updating
> > 'fdb->updated' with current jiffies value.
> > 
> > So, is this the requirement? I checked the hostapd fork you posted some
> > time ago and I get the impression that the answer is yes [1], but I want
> > to verify I'm not missing something.
> > 
> > [1] https://github.com/westermo/hostapd/commit/95dc96f9e89131b2319f5eae8ae7ac99868b7cd0#diff-338b6fad34b4bdb015d7d96930974bd96796b754257473b6c91527789656d6edR11
> > 
> > 
> 
> I cannot say that it is a requirement with respect to the bridge
> implementation, but it is with the driver implementation. But you are right
> that it is to be used with dynamic entries.

OK, so it's a requirement for both since we need both data paths to act
the same.

[...]

> Port association is needed for MAB to work at all on mv88e6xxx, but for
> 802.1X port association is only needed for dynamic ATU entries.

Ageing of dynamic entries in the bridge requires learning to be on as
well, but in these test cases you are only using static entries and
there is no reason to enable learning in the bridge for that. I prefer
not to leak this mv88e6xxx implementation detail to user space and
instead have the driver enable port association based on whether
"learning" or "mab" is on.

[...]

> Oh yes, I meant in the iproute2 accompanying patch set to this one?

You can send it as a standalone patch to iproute2-next:
https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git

Subject prefix should be "[PATCH iproute2-next]". See this commit for
reference:
https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=d2eecb9d1d4823a04431debd990824a5d610bfcf
