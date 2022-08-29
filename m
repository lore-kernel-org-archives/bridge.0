Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2D73381433
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D95E3815CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+iCA21eCQznXHOu6VEuN1kLPE5gxUGXLzjfFSjMA/qY=;
 b=oCoEUNvx2WXdAHymJf8dhckgC5dsDLfLpWFYc46arHzWxjw24lSlhvDSbikk5e7b+3BCj0lFTd8f/h5uS5bxVymOhKeCiYVUXPxHow4he6wTc+b+yG1L481CMV0jc3/hx6BHFHQ2g4IMOAQIN/1kf2lT4z6v72SPkdqWMZyWqnIh/6XCclpKyUPC8fhkrWDj8KNW4maliJJLGW9E7+4ad30KHt/F7Ku7X7YBb7myTc3PtnJSjAn+VubWNK4N8kZlwoJ1Yh42B5wbe8+yu/Hv9fosJ086sgM3qX8oadMyuzwkZdGR6ZIr2YQ5kMdU5jTpVp1TJwkJ4pHQbkFq0Kcr/Q==
Date: Mon, 29 Aug 2022 19:12:47 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <Ywzlfzns/vDDiKB1@shredder>
References: <20220826114538.705433-1-netdev@kapio-technology.com>
 <20220826114538.705433-2-netdev@kapio-technology.com>
 <e9eb5b72-073a-f182-13b7-37fc53611d5f@blackwall.org>
 <972663825881d135d19f9e391b2b7587@kapio-technology.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <972663825881d135d19f9e391b2b7587@kapio-technology.com>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH v5 net-next 1/6] net: bridge: add locked entry
 fdb flag to extend locked port feature
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

On Mon, Aug 29, 2022 at 04:02:46PM +0200, netdev@kapio-technology.com wrote:
> On 2022-08-27 13:30, Nikolay Aleksandrov wrote:
> > On 26/08/2022 14:45, Hans Schultz wrote:
> > 
> > Hi,
> > Please add the blackhole flag in a separate patch.
> > A few more comments and questions below..
> > 
> 
> Hi,
> if userspace is to set this flag I think I need to change stuff in
> rtnetlink.c, as I will need to extent struct ndmsg with a new u32 entry as
> the old u8 flags is full.

You cannot extend 'struct ndmsg'. That's why 'NDA_FLAGS_EXT' was
introduced. See:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2c611ad97a82b51221bb0920cc6cac0b1d4c0e52

'NTF_EXT_BLACKHOLE' belongs in 'NDA_FLAGS_EXT' like you have it now, but
the kernel should not reject it in br_fdb_add().

> Maybe this is straight forward, but I am not so sure as I don't know that
> code too well. Maybe someone can give me a hint...?
