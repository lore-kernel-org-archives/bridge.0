Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7A25242061
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 80A1642137
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680253123;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BYgdpbZjRcMBBZb2pcPFoHc8NfA9uoYOg/WF0eXftpw=;
 b=lVKy9HSAOGeFLg+iy7ujKGiGribkgannSjZw89QjDiPB0ZV6BZm9+DizSMM+gX3jEw
 8QIkoiOy2MNkxNZZupbYDoc64yJzb7Zakr4oYn+NZsqx23cfATRwfdyLTql0+IM3dC5T
 9zKB3+Y68Ext8eXLKbm+4W1Mq+WMbsW3LTUkmel8sWJCt88C13fN9xBBvjtKqUosu9Gw
 ucQZhXb/e9f0vPsnfBcOSdQNwVW3hXH1vRu0z/fas0JuC3+hUy/k1KwL7H5IS5+eme+q
 lWNM6p5ohWlyVrBT/8KIVW5ZPpOmzUu9j6j2ZOXYo+84gdkfqnAmrpw7d0uQRaY9JwTf
 NIdg==
Date: Fri, 31 Mar 2023 11:58:40 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20230331085840.5wfxsuj6u7hge2uj@skbuf>
References: <20230318141010.513424-1-netdev@kapio-technology.com>
 <20230318141010.513424-7-netdev@kapio-technology.com>
 <ZBgdAo8mxwnl+pEE@shredder> <87a5zzh65p.fsf@kapio-technology.com>
 <ZCMYbRqd+qZaiHfu@shredder> <874jq22h2u.fsf@kapio-technology.com>
 <20230330192714.oqosvifrftirshej@skbuf>
 <874jq1mkm1.fsf@kapio-technology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874jq1mkm1.fsf@kapio-technology.com>
Subject: Re: [Bridge] [PATCH v2 net-next 6/6] selftests: forwarding: add
 dynamic FDB test
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hans Schultz <netdev@kapio-technology.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, open list <linux-kernel@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, Ido Schimmel <idosch@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, Christian Marangi <ansuelsmth@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Hauke Mehrtens <hauke@hauke-m.de>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, "moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, "maintainer:MICROCHIP KSZ SERIES ETHERNET SWITCH DRIVER" <UNGLinuxDriver@microchip.com>, "open list:RENESAS RZ/N1 A5PSW SWITCH DRIVER" <linux-renesas-soc@vger.kernel.org>, davem@davemloft.net

On Fri, Mar 31, 2023 at 09:43:34AM +0200, Hans Schultz wrote:
> On Thu, Mar 30, 2023 at 22:27, Vladimir Oltean <olteanv@gmail.com> wrote:
> > This is how I always run them, and it worked fine with both Debian
> > (where it's easy to add missing packages to the rootfs) or with a more
> > embedded-oriented Buildroot.
> 
> I am not entirely clear of your idea. You need somehow to boot into a
> system with the patched net-next kernel

You have to do that anyway for any kind of kernel work, no?

> or you have a virtual machine boot into a virtual OS. I guess it is
> the last option you refer to using Debian?

You could do that too, but you don't have to. Debian, like many other
Linux distributions, supports a wide variety of CPU architectures; it
can be run on embedded systems just as well as on desktop PCs or VMs.
I didn't say you have to use Debian, though, I just said I ran the
selftests on a Debian-based rootfs and that it was easy to prepare the
environment there. The Debian rootfs and the selftests were deployed to
the target board with the DSA switch on it, in case that wasn't clear.
