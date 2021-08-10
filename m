Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=JN+veN
 zxNu2yCry5BzS6GnnIFcdXcsuA3+5PUKwFlcc=; b=BoZoRpgnt+WDl8BD71cTnt
 7+BSt/lBzqXPG6bIDKHYFpMCqZjm66hBSO2UH09b53Th92wtPMTdJmf5VXOzw729
 vH5+g08CY/1HNoP1WJnQuZ8MH1q6gjJTP60B6R7DPaT6ZtRQqSpUTVDlYA7i8fR2
 fFFals9tLuBpY1kl8yoypuOM9LmqTNiNh/A/27YM5iEQltPcsj7T3HVu61cLltVF
 GFYB9cwoC0z/W0+EEHdWWhS70blb532RycTUfV2O8i2Tk/3TFbWL/k7Q6tgRDUpi
 GQdv0Itn4ZTYaZu0nnPgH4XYW1jpNvzjomNX/9tVX9FQnceVuZqO2s6/NF1An+YQ
 ==
Date: Tue, 10 Aug 2021 09:46:34 +0300
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <YRIgynudgTsOpe5q@shredder>
References: <20210801231730.7493-1-vladimir.oltean@nxp.com>
 <YREcqAdU+6IpT0+w@shredder> <20210809160521.audhnv7o2tugwtmp@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809160521.audhnv7o2tugwtmp@skbuf>
Subject: Re: [Bridge] [PATCH net] net: bridge: validate the NUD_PERMANENT
 bit when adding an extern_learn FDB entry
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: "syzbot+9ba1174359adba5a5b7c@syzkaller.appspotmail.com" <syzbot+9ba1174359adba5a5b7c@syzkaller.appspotmail.com>, Jiri Pirko <jiri@resnulli.us>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, "nikolay@nvidia.com" <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>

On Mon, Aug 09, 2021 at 04:05:22PM +0000, Vladimir Oltean wrote:
> On Mon, Aug 09, 2021 at 03:16:40PM +0300, Ido Schimmel wrote:
> > I have at least once selftest where I forgot the 'static' keyword:
> >
> > bridge fdb add de:ad:be:ef:13:37 dev $swp1 master extern_learn vlan 1
> >
> > This patch breaks the test when run against both the kernel and hardware
> > data paths. I don't mind patching these tests, but we might get more
> > reports in the future.
> 
> Is it the 'static' keyword that you forgot, or 'dynamic'? The
> tools/testing/selftests/net/forwarding/bridge_vlan_aware.sh selftest
> looks to me like it's testing the behavior of an FDB entry which should
> roam, and which without the extern_learn flag would be ageable.

static - no aging, no roaming
dynamic - aging, roaming
extern_learn - no aging, roaming

So these combinations do not make any sense and the kernel will ignore
static/dynamic when extern_learn is specified. It's needed to work
around iproute2 behavior of "assume permanent"
